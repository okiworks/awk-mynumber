# MyNumber Validator (awk version.)

## Overview
Japanese MyNumber validator.

## Usage

This script extract the valid MyNumber.
```
$ awk -f get_valid_mynumber.awk checkdata.txt > result.txt
```

This script outputs the summary and detailed verification process.
```
$ awk -f validate_mynumber.awk checkdata.txt > valid.txt
```

## Author
Hironao Oki (http://oki.hateblo.jp/)

blog:[awkでマイナンバーのチェックデジットを検証・集計 - 沖の雑記帳](http://oki.hateblo.jp/entry/2016/03/07/143644)

## Reference
[マイナンバーのチェックデジットを計算する - Qiita](http://qiita.com/qube81/items/fa6ef94d3c8615b0ce64)
