Message-ID: <3E9C33AC.6090204@alles.or.jp>
Date: Wed, 16 Apr 2003 01:30:36 +0900
From: Takeharu KATO <tk1219@alles.or.jp>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: [TRIVIAL PATCH][2.5.67] Compile fix to include appropriate file in
 bootloader
Content-Type: multipart/mixed;
 boundary="------------080608060305050805070309"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------080608060305050805070309
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Dear maintainers:

I use Linux-2.5.67 on PowerPC4xx and apply the patch which is
attached in this mail to compile it.
Because Linux-2.5.67 kernel attempt to include header file for mpc8xx.
Please apply this patch.

--
-----------------------------------
Takeharu KATO
Mail: tk1219@alles.or.jp


--------------080608060305050805070309
Content-Type: text/plain;
 name="linux-PPC4xx.pat"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="linux-PPC4xx.pat"

ZGlmZiAtTmFjciBsaW51eC1QUEMub3JpZy9hcmNoL3BwYy9ib290L3NpbXBsZS9taXNjLWVt
YmVkZGVkLmMgbGludXgtUFBDL2FyY2gvcHBjL2Jvb3Qvc2ltcGxlL21pc2MtZW1iZWRkZWQu
YwoqKiogbGludXgtUFBDLm9yaWcvYXJjaC9wcGMvYm9vdC9zaW1wbGUvbWlzYy1lbWJlZGRl
ZC5jCU1vbiBBcHIgMTQgMDk6MTA6MzAgMjAwMwotLS0gbGludXgtUFBDL2FyY2gvcHBjL2Jv
b3Qvc2ltcGxlL21pc2MtZW1iZWRkZWQuYwlNb24gQXByIDE0IDA5OjQwOjU1IDIwMDMKKioq
KioqKioqKioqKioqCioqKiAxMSwyMCAqKioqCiAgI2luY2x1ZGUgPGxpbnV4L2VsZi5oPgog
ICNpbmNsdWRlIDxsaW51eC9zdHJpbmcuaD4KICAjaW5jbHVkZSA8YXNtL2Jvb3RpbmZvLmg+
Ci0gI2luY2x1ZGUgPGFzbS9pYm00eHguaD4KICAjaW5jbHVkZSA8YXNtL21tdS5oPgogICNp
bmNsdWRlIDxhc20vbXBjOHh4Lmg+CiAgI2luY2x1ZGUgPGFzbS9tcGM4MjYwLmg+CiAgI2lu
Y2x1ZGUgPGFzbS9wYWdlLmg+CiAgI2luY2x1ZGUgPGFzbS9wcm9jZXNzb3IuaD4KICAjaW5j
bHVkZSA8YXNtL3Jlc2lkdWFsLmg+Ci0tLSAxMSwyNCAtLS0tCiAgI2luY2x1ZGUgPGxpbnV4
L2VsZi5oPgogICNpbmNsdWRlIDxsaW51eC9zdHJpbmcuaD4KICAjaW5jbHVkZSA8YXNtL2Jv
b3RpbmZvLmg+CiAgI2luY2x1ZGUgPGFzbS9tbXUuaD4KKyAjaWYgZGVmaW5lZChDT05GSUdf
NHh4KQorICNpbmNsdWRlIDxhc20vaWJtNHh4Lmg+CisgI2VsaWYgZGVmaW5lZChDT05GSUdf
OHh4KQogICNpbmNsdWRlIDxhc20vbXBjOHh4Lmg+CisgI2VsaWYgZGVmaW5lZChDT05GSUdf
ODI2MCkKICAjaW5jbHVkZSA8YXNtL21wYzgyNjAuaD4KKyAjZW5kaWYgIC8qICBDT05GSUdf
NHh4ICAqLwogICNpbmNsdWRlIDxhc20vcGFnZS5oPgogICNpbmNsdWRlIDxhc20vcHJvY2Vz
c29yLmg+CiAgI2luY2x1ZGUgPGFzbS9yZXNpZHVhbC5oPgo=
--------------080608060305050805070309--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
