From: kd@flaga.is
Subject: Re: Re: fadsrom -> mkrombin
To: Ruedi.Hofer@ascom.ch
Cc: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OF05B68AC1.91BB70D4-ON00256842.0056B1F9@flaga.is>
Date: Thu, 9 Dec 1999 15:49:44 +0000
MIME-Version: 1.0
Content-type: multipart/mixed;
	Boundary="0__=4sMgO4JIzpTO5LvNv3V4hL387C7J3AFKANme1i8cmMt9qNhDF2ca9lnM"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--0__=4sMgO4JIzpTO5LvNv3V4hL387C7J3AFKANme1i8cmMt9qNhDF2ca9lnM
Content-type: text/plain; charset=us-ascii


O.k.

Here is a cleaned up diff between orginal fadsrom and our inhous fadsrom
(the parts skiped are very board specific changes for hardware only found
on our 823 custom board). It compiles (verified) but I am not shure if it
runs 8-).....


K.D.
(See attached file: fadsrom.diff)


                                                                                                                                 
                    Ruedi.Hofer@a                                                                                                
                    scom.ch              To:     kd@flaga.is                                                                     
                                         cc:     linuxppc-embedded@lists.linuxppc.org                                            
                    12/09/99             Subject:     Re: Re: fadsrom -> mkrombin                                                
                    01:55 PM                                                                                                     
                                                                                                                                 
                                                                                                                                 




Thanx, applying the patch works!


But unfortunataly a file "byteconv.h" is missing:

rac26090:/usr/src/fadsrom # make mkrombin
cc -O0 -g -o mkrombin mkrombin.c
mkrombin.c:15: byteconv.h: No such file or directory
make: *** [mkrombin] Error 1
rac26090:/usr/src/fadsrom #

It should probably be in your fadsrom directory!

Do you mind tgz-ing the whole fadsrom and sending it to me!?!?


Ruedi





--0__=4sMgO4JIzpTO5LvNv3V4hL387C7J3AFKANme1i8cmMt9qNhDF2ca9lnM
Content-type: application/octet-stream;
	name="fadsrom.diff"
Content-Disposition: attachment; filename="fadsrom.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtdSAtYiAtQiBmYWRzcm9tX29yZy9NYWtlZmlsZSBmYWRzcm9tL01ha2VmaWxlCi0tLSBm
YWRzcm9tX29yZy9NYWtlZmlsZQlNb24gTm92IDMwIDE4OjEyOjM0IDE5OTgKKysrIGZhZHNyb20v
TWFrZWZpbGUJVGh1IERlYyAgOSAxNTozODo0NSAxOTk5CkBAIC0yLDE0ICsyLDMyIEBACiAjIE1h
a2VmaWxlIGZvciB0aGUgRkFEUyBST00KICMKIAorS0VSTkVMSEVBREVSPS9ob21lL2tkL2RldmVs
L2xpbnV4L2luY2x1ZGUKKworQ1JPU1NDT01QSUxFID0gL3Vzci9wb3dlcnBjLWxpbnV4L2Jpbi8K
KyNDUk9TU0NPTVBJTEUgPSAKKworQ0MgPSAkKENST1NTQ09NUElMRSlnY2MKK0xEID0gJChDUk9T
U0NPTVBJTEUpbGQKKworCiAjIFVzZSBrZXJuZWwgaW5jbHVkZSBmaWxlcyB0byBnZXQgbWFjaGlu
ZS9wcm9jZXNzb3IgZGVwZW5kZW50IHN0dWZmCi1JTkNTID0gLUkuLi9saW51eC9pbmNsdWRlIFwK
LQktSS4uL2xpbnV4L2FyY2gvcHBjLzh4eF9pbworSU5DUyA9IC1JJChLRVJORUxIRUFERVIpIFwK
KwktSSQoS0VSTkVMSEVBREVSKS9saW51eCBcCisJLUkkKEtFUk5FTEhFQURFUikvLi4vYXJjaC9w
cGMvOHh4X2lvIAogCisjUk9NTE9BRD0weGZlMDAwMDAwCiBST01MT0FEPTB4ZmUwMDAwMDAKIERB
VEE9MHgwMDAxMDAwMAogCi1DRkxBR1MgPSAtTzIgLW1jcHU9ODYwICQoSU5DUykgLURfX3Bvd2Vy
cGNfXyAtRE1IWl81MCAtREZBRFNfODYwIFwKK1MxOUFERFI9MHhmZTAwMDAwMAorCitERUJVRyA9
IC1EX0RFQlVHIC1nCisjREVCVUcgPQorCitIT1NUID0gLURIT1NUaTM4NgorCitDRkxBR1MgPSAt
Z2R3YXJmIC1PIC1tY3B1PTgyMyAkKElOQ1MpIC1EX19wb3dlcnBjX18gLURNSFpfNTAgLURGQURT
Xzg2MCBcCiAJLURfX0tFUk5FTF9fIC1EREFUQV9NRU1fQUREUj0kKERBVEEpIC1EQ09ORklHXzh4
eCAtZnNpZ25lZC1jaGFyIFwKIAktbXNvZnQtZmxvYXQgIC1waXBlIC1mbm8tYnVpbHRpbiAtZmZp
eGVkLXIyIC1Xbm8tdW5pbml0aWFsaXplZCBcCiAJLW1tdWx0aXBsZSAtbXN0cmluZwpAQCAtMjYs
MjAgKzQ0LDIwIEBACiAJcHBjc3RyaW5nLm8gZXh0YWJsZS5vCiAKIGZhZHNyb206ICQoT0JKUykg
bWtyb21iaW4KLQlsZCAkKExJTktGTEFHUykgJChPQkpTKSAtbyBmYWRzcm9tCi0JbWtyb21iaW4g
ZmFkc3JvbQorCSQoTEQpICQoTElOS0ZMQUdTKSAkKE9CSlMpIC1vIGZhZHNyb20KKwkuL21rcm9t
YmluIGZhZHNyb20KIAogIyBJIHJhbiB0aGlzIHRob3VnaCAnZGQnIGJlY2F1c2Ugb24gc29tZSBO
RlMgbW91bnRlZCBmaWxlIHN5c3RlbXMgdGhpcwogIyB3YXMgcHJldHR5IHNsb3cgZHVlIHRvIHRo
ZSBwcmludGYuICBUaGUgJ2RkJyBidWZmZXJzIGl0IGludG8KICMgbW9yZSBlZmZpY2llbnQgYmxv
Y2tzLgogczE5OiBmYWRzcm9tIGJpbnRvczE5Ci0JYmludG9zMTkgZmFkc3JvbS5iaW4gfCBkZCBv
Zj1mYWRzcm9tLnMxOQorCS4vYmludG9zMTkgZmFkc3JvbS5iaW4gJChTMTlBRERSKSB8IGRkIG9m
PWZhZHNyb20uczE5CiAKIG1rcm9tYmluOiBta3JvbWJpbi5jCi0JY2MgLU8yIC1vIG1rcm9tYmlu
IG1rcm9tYmluLmMKKwlnY2MgJChERUJVRykgJChIT1NUKSAtTzIgLW8gbWtyb21iaW4gbWtyb21i
aW4uYwogCiBiaW50b3MxOTogYmludG9zMTkuYwotCWNjIC1PMiAtbyBiaW50b3MxOSBiaW50b3Mx
OS5jCisJZ2NjICQoREVCVUcpICQoSE9TVCkgLU8yIC1vIGJpbnRvczE5IGJpbnRvczE5LmMKIAog
Y2xlYW46CiAJcm0gLWYgJChPQkpTKSBmYWRzcm9tIGZhZHNyb20uYmluIGZhZHNyb20uczE5CkBA
IC01Miw0ICs3MCw5IEBACiBzdGFydC5vOiBNYWtlZmlsZSBwcGNfYXNtLnRtcGwgcHBjX2RlZnMu
aAogbWFpbi5vOiBNYWtlZmlsZQogc2VyaWFsLm86IE1ha2VmaWxlCitkc3AubzogTWFrZWZpbGUK
K2V4dHRpbWVyLm86IE1ha2VmaWxlCisKKworCiAKZGlmZiAtdSAtYiAtQiBmYWRzcm9tX29yZy9l
eHRhYmxlLmMgZmFkc3JvbS9leHRhYmxlLmMKLS0tIGZhZHNyb21fb3JnL2V4dGFibGUuYwlXZWQg
Tm92IDE4IDA2OjQzOjM5IDE5OTgKKysrIGZhZHNyb20vZXh0YWJsZS5jCVRodSBEZWMgIDkgMTU6
Mzg6MjUgMTk5OQpAQCAtNCw3ICs0LDggQEAKICAqIGZyb20gbGludXgvYXJjaC9pMzg2L21tL2V4
dGFibGUuYwogICovCiAKLSNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KKy8vI2luY2x1ZGUgPHN5cy90
eXBlcy5oPgorI2luY2x1ZGUgPHR5cGVzLmg+CiAKIC8qCiAgKiBUaGUgZXhjZXB0aW9uIHRhYmxl
IGNvbnNpc3RzIG9mIHBhaXJzIG9mIGFkZHJlc3NlczogdGhlIGZpcnN0IGlzIHRoZQpkaWZmIC11
IC1iIC1CIGZhZHNyb21fb3JnL21haW4uYyBmYWRzcm9tL21haW4uYwotLS0gZmFkc3JvbV9vcmcv
bWFpbi5jCVR1ZSBOb3YgMjQgMjM6MDQ6NTQgMTk5OAorKysgZmFkc3JvbS9tYWluLmMJVGh1IERl
YyAgOSAxNTozNzoxMiAxOTk5CkBAIC0yLDcgKzIsOCBAQAogLyogRkFEUyBCb290IFJPTSAoc2tl
bGV0b24gOi0pLgogICogRGFuIE1hbGVrLgogICovCi0jaW5jbHVkZSA8c3lzL3R5cGVzLmg+Cisj
aW5jbHVkZSA8dHlwZXMuaD4KKy8vI2luY2x1ZGUgPHN5cy90eXBlcy5oPgogI2luY2x1ZGUgImFz
bS9mYWRzLmgiCiAjaW5jbHVkZSA8YXNtLzh4eF9pbW1hcC5oPgogCmRpZmYgLXUgLWIgLUIgZmFk
c3JvbV9vcmcvbWVtc3R1ZmYuYyBmYWRzcm9tL21lbXN0dWZmLmMKLS0tIGZhZHNyb21fb3JnL21l
bXN0dWZmLmMJV2VkIE5vdiAxOCAwNjo1Mjo0NSAxOTk4CisrKyBmYWRzcm9tL21lbXN0dWZmLmMJ
VGh1IERlYyAgOSAxNTozNzozNyAxOTk5CkBAIC0yLDcgKzIsOCBAQAogLyogRkFEUyBST00KICAq
IERhbiBNYWxlayAoZG1hbGVrQGpsYy5uZXQpCiAgKi8KLSNpbmNsdWRlIDxzeXMvdHlwZXMuaD4K
KyNpbmNsdWRlIDx0eXBlcy5oPgorLy8jaW5jbHVkZSA8c3lzL3R5cGVzLmg+CiAjaW5jbHVkZSAi
YXNtL2ZhZHMuaCIKICNpbmNsdWRlIDxhc20vOHh4X2ltbWFwLmg+CiAKZGlmZiAtdSAtYiAtQiBm
YWRzcm9tX29yZy9ta3JvbWJpbi5jIGZhZHNyb20vbWtyb21iaW4uYwotLS0gZmFkc3JvbV9vcmcv
bWtyb21iaW4uYwlXZWQgTm92IDE4IDA2OjQzOjM5IDE5OTgKKysrIGZhZHNyb20vbWtyb21iaW4u
YwlUaHUgRGVjICA5IDE1OjM5OjI2IDE5OTkKQEAgLTEwLDYgKzEwLDkgQEAKICAqIFdlIHN0cmlw
IHRoZSBoZWFkZXIsIHBsYWNlIHRoZSBjb2RlIGZpcnN0LCBhbmQgbW92ZSB0aGUgZGF0YSB0bwog
ICogYSA0SyBwYWdlIGJvdW5kYXJ5IGZvbGxvd2luZyB0aGUgY29kZS4KICAqLworDQorDQorI2lu
Y2x1ZGUgImJ5dGVjb252LmgiDQogI2luY2x1ZGUgPHN5cy90eXBlcy5oPgogI2luY2x1ZGUgPGZj
bnRsLmg+CiAjaW5jbHVkZSA8c3RyaW5nLmg+CkBAIC01MCwzMSArNTMsNDIgQEAKIAkJZXhpdCgy
KTsKIAl9CiAJZWhwID0gKEVsZjMyX0VoZHIgKikgaWJ1ZjsKKyNpZmRlZiBfREVCVUcNCisJZnBy
aW50ZihzdGRvdXQsImlidWYgPSAldSwgZWhwID0gJXUgIiwgaWJ1ZiwgZWhwKTsNCisjZW5kaWYN
CiAKIAlpZiAoc3RybmNtcChlaHAtPmVfaWRlbnQsIEVMRk1BRywgNCkgIT0gMCkgewogCQlmcHJp
bnRmKHN0ZGVyciwgIiVzIGRvZXNuJ3QgbG9vayBsaWtlIEVMRlxuIiwgYXJndlsxXSk7CiAJCWV4
aXQoMik7CiAJfQogCi0JbnNjbnMgPSBlaHAtPmVfcGhudW07Ci0JZXBwID0gKEVsZjMyX1BoZHIg
KikoKHVpbnQpZWhwICsgZWhwLT5lX3Bob2ZmKTsKKwluc2NucyA9IENUT0hTKGVocC0+ZV9waG51
bSk7DQorCWVwcCA9IChFbGYzMl9QaGRyICopKCh1aW50KWVocCArIENUT0hMKGVocC0+ZV9waG9m
ZikpOw0KKyNpZmRlZiBfREVCVUcNCisJZnByaW50ZihzdGRvdXQsIm5zY3NuID0gJWksIGVfcGhv
ZmYgPSAlaVxuIiwgbnNjbnMsIENUT0hMKGVocC0+ZV9waG9mZikpOw0KKyNlbmRpZg0KIAogCWlm
IChuc2NucyAhPSAyKSB7Ci0JCWZwcmludGYoc3RkZXJyLCAic29tZXRoaW5nIHdyb25nIHdpdGgg
ZmlsZSAlc1xuIiwgYXJndlsxXSk7Ci0JCWV4aXQoMik7CisJCWZwcmludGYoc3RkZXJyLCAiMXNv
bWV0aGluZyB3cm9uZyB3aXRoIGZpbGUgJXNcbiIsIGFyZ3ZbMV0pOw0KKwkvLwlleGl0KDIpOw0K
IAl9CiAKIAkvKiBHZXQgdGhlIGRhdGEgcG9ydGlvbi4KIAkqLwotCWlmICgoZXBwLT5wX3R5cGUg
IT0gUFRfTE9BRCkgfHwgKGVwcC0+cF9vZmZzZXQgIT0gMHgxMDAwMCkpIHsKLQkJZnByaW50Zihz
dGRlcnIsICJzb21ldGhpbmcgd3Jvbmcgd2l0aCBmaWxlICVzXG4iLCBhcmd2WzFdKTsKKyNpZmRl
ZiBfREVCVUcNCisJZnByaW50ZihzdGRvdXQsICJwX3R5cGUgPSAlaSwgcF9vZmZzZXQgPSAlaVxu
IiwNCisJCQkJQ1RPSEwoZXBwLT5wX3R5cGUpLENUT0hMKGVwcC0+cF9vZmZzZXQpKTsNCisjZW5k
aWYNCisJaWYgKChDVE9ITChlcHAtPnBfdHlwZSkgIT0gUFRfTE9BRCkgfHwNCisJCQkJKENUT0hM
KGVwcC0+cF9vZmZzZXQpICE9IDB4MTAwMDApKSB7DQorCQlmcHJpbnRmKHN0ZGVyciwgIjJzb21l
dGhpbmcgd3Jvbmcgd2l0aCBmaWxlICVzXG4iLCBhcmd2WzFdKTsNCiAJCWV4aXQoMik7CiAJfQot
CWRzaXplID0gZXBwLT5wX2ZpbGVzejsKKwlkc2l6ZSA9IENUT0hMKGVwcC0+cF9maWxlc3opOw0K
IAotI2lmIDAKLQlwcmludGYoIiAlZCAlZCAlZCAlZFxuIiwgZXBwLT5wX3R5cGUsIGVwcC0+cF9v
ZmZzZXQsIGVwcC0+cF9maWxlc3osCi0JCWVwcC0+cF9tZW1zeik7CisjaWYgX0RFQlVHDQorCXBy
aW50ZigiICVkICVkICVkICVkXG4iLCBDVE9ITChlcHAtPnBfdHlwZSksIENUT0hMKGVwcC0+cF9v
ZmZzZXQpLA0KKwkJCUNUT0hMKGVwcC0+cF9maWxlc3opLCBDVE9ITChlcHAtPnBfbWVtc3opKTsN
CiAjZW5kaWYKIAlpZiAocmVhZChlbGZfZmQsIGRidWYsIHNpemVvZihkYnVmKSkgIT0gc2l6ZW9m
KGRidWYpKSB7CiAJCWZwcmludGYoc3RkZXJyLCAiJXMgZG9lc24ndCBsb29rIGxpa2UgRUxGXG4i
LCBhcmd2WzFdKTsKQEAgLTg0LDE2ICs5OCwxNyBAQAogCS8qIEdldCB0aGUgaW5zdHJ1Y3Rpb24g
cG9ydGlvbi4KIAkqLwogCWVwcCsrOwotCWlmICgoZXBwLT5wX3R5cGUgIT0gUFRfTE9BRCkgfHwg
KGVwcC0+cF9vZmZzZXQgIT0gMHgyMDAwMCkgfHwKLQkJKGVwcC0+cF9maWxlc3ogIT0gZXBwLT5w
X21lbXN6KSkgewotCQlmcHJpbnRmKHN0ZGVyciwgInNvbWV0aGluZyB3cm9uZyB3aXRoIGZpbGUg
JXNcbiIsIGFyZ3ZbMV0pOworCWlmICgoQ1RPSEwoZXBwLT5wX3R5cGUpICE9IFBUX0xPQUQpIHx8
DQorCQkJKENUT0hMKGVwcC0+cF9vZmZzZXQpICE9IDB4MjAwMDApIHx8DQorCQkJKENUT0hMKGVw
cC0+cF9maWxlc3opICE9IENUT0hMKGVwcC0+cF9tZW1zeikpKSB7DQorCQlmcHJpbnRmKHN0ZGVy
ciwgIjNzb21ldGhpbmcgd3Jvbmcgd2l0aCBmaWxlICVzXG4iLCBhcmd2WzFdKTsNCiAJCWV4aXQo
Mik7CiAJfQogI2lmIDAKLQlwcmludGYoIiAlZCAlZCAlZCAlZFxuIiwgZXBwLT5wX3R5cGUsIGVw
cC0+cF9vZmZzZXQsIGVwcC0+cF9maWxlc3osCi0JCWVwcC0+cF9tZW1zeik7CisJcHJpbnRmKCIg
JWQgJWQgJWQgJWRcbiIsIENUT0hMKGVwcC0+cF90eXBlKSwgQ1RPSEwoZXBwLT5wX29mZnNldCks
IA0KKwkJCUNUT0hMKGVwcC0+cF9maWxlc3opLCBDVE9ITChlcHAtPnBfbWVtc3opKTsNCiAjZW5k
aWYKLQlzaXplID0gZXBwLT5wX2ZpbGVzejsKKwlzaXplID0gQ1RPSEwoZXBwLT5wX2ZpbGVzeik7
DQogCWlmIChyZWFkKGVsZl9mZCwgaWJ1Ziwgc2l6ZSkgIT0gc2l6ZSkgewogCQlmcHJpbnRmKHN0
ZGVyciwgIiVzIGRvZXNuJ3QgbG9vayBsaWtlIEVMRlxuIiwgYXJndlsxXSk7CiAJCWV4aXQoMik7
CmRpZmYgLXUgLWIgLUIgZmFkc3JvbV9vcmcvcGFydGl0aW9uLmMgZmFkc3JvbS9wYXJ0aXRpb24u
YwotLS0gZmFkc3JvbV9vcmcvcGFydGl0aW9uLmMJV2VkIE5vdiAxOCAwNjo0MzozOSAxOTk4Cisr
KyBmYWRzcm9tL3BhcnRpdGlvbi5jCVRodSBEZWMgIDkgMTU6Mzc6NTYgMTk5OQpAQCAtNCw3ICs0
LDggQEAKICAqIFdyaXRlIGFuIE9TRiBwYXJ0aXRpb24gdG8gdGhlIGZpcnN0IHNlY3RvciBvZiB0
aGUgZmxhc2ggZGlzay4KICAqLwogCi0jaW5jbHVkZSA8c3lzL3R5cGVzLmg+CisvLyNpbmNsdWRl
IDxzeXMvdHlwZXMuaD4KKyNpbmNsdWRlIDx0eXBlcy5oPgogCiBzdHJ1Y3QgZGlza2xhYmVsIHsK
IAl1aW50IGRfbWFnaWM7Cg==

--0__=4sMgO4JIzpTO5LvNv3V4hL387C7J3AFKANme1i8cmMt9qNhDF2ca9lnM--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
