# 数値のみの行にマッチ
/^[0-9]+$/ {
    sum = 0
    if (length($0) == 12) {
        digit = calc_checkdigit(substr($0,1,11))
        if (digit == substr($0,12,1)) {
            valid_data[FNR] = $0
        }
    }
    next
}

# 検証結果の出力
END {
    for (i = 1; i <= FNR; i++) {
        if (i in valid_data) {
            print valid_data[i]
        }
    }
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

