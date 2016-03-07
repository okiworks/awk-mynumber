# サマリ出力するデータの初期化
BEGIN {
    invalid_count = 0
    valid_count = 0
    unexpected_count = 0
}

# 全入力データを保存
{
    mynumber[FNR] = $0
}

# 数値のみの行にマッチ
/^[0-9]+$/ {
    sum = 0
    if (length($0) == 12) {
        print "mynumber : " $0
        digit = calc_checkdigit(substr($0,1,11))
        print "digit    : " digit
        if (digit == substr($0,12,1)) {
            print "validate : true"
            valid_count++
            result[FNR] = 1
        }
        else {
            print "validate : false"
            invalid_count++
            result[FNR] = 0
        }
    }
    else {
        print $0 " :requires 12-digit."
        unexpected_count++
    }
    print ""
    next
}

# 非数を1つでも含む行にマッチ
/[^0-9]+/ {
    print $0 " : Not be used non-numeric.\n"
    unexpected_count++
    next
}

# どのパターンにもマッチしてこなかった場合は不正データ
# 改行のみの場合などはここに来る
{
    print "Unexpected data.\n"
    unexpected_count++
}

# 検証結果のサマリ出力
END {
    print "Summary:"
    print "  Number of data : " FNR
    print "  Valid data     : " valid_count
    for (i = 1; i <= FNR; i++) {
        if (result[i]) {
            print "\t" mynumber[i]
        }
    }
    print "  Invalid data   : " invalid_count
    print "  Illegal data   : " unexpected_count
# 不正入力を出したい時だけ
#    for (i = 1; i <= FNR; i++) {
#        if (!result[i]) {
#            print "\t" mynumber[i]
#        }
#    }
}

# チェックデジットの計算
# 入力は11桁の数値列
function calc_checkdigit(number){
    for (i = 1; i < 12; i++) {
        p = substr(number,12-i,1)
        if (i <= 6) {
            q = i + 1
        }
        else {
            q = i - 5
        }
        sum += p * q
    }
    remainder = sum % 11
    if (remainder <= 1) {
        return 0
    }
    else {
        return 11 - remainder
    }
}

