Return-Path: <skrishnakar@gmail.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
	by ozlabs.org (Postfix) with ESMTP id A6618B70AE
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  8 Oct 2010 23:49:45 +1100 (EST)
Received: by wwa36 with SMTP id 36so807841wwa.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 08 Oct 2010 05:49:43 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 8 Oct 2010 18:19:42 +0530
Message-ID: <AANLkTikVdVkej7LNKXjrcNH2t2rJL=O=NhBDnw3j6N1v@mail.gmail.com>
Subject: RTC rtc-cmos.c : Fix warning on PowerPC
From: srikanth krishnakar <skrishnakar@gmail.com>
To: Linuxppc-dev@ozlabs.org, linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/mixed; boundary=0016e6d97801cc873504921a71bf
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016e6d97801cc873504921a71bf
Content-Type: multipart/alternative; boundary=0016e6d97801cc872e04921a71bd

--0016e6d97801cc872e04921a71bd
Content-Type: text/plain; charset=ISO-8859-1

Hello,

I noticed a compilation warning of RTC for powerpc. Found the fix existing
for MIPS & not for available for PowerPC.

-- 
"The Good You Do, The Best You GET"

Regards
Srikanth Krishnakar
**********************

--0016e6d97801cc872e04921a71bd
Content-Type: text/html; charset=ISO-8859-1

Hello,<br><br>I noticed a compilation warning of RTC for powerpc. Found the fix existing for MIPS &amp; not for available for PowerPC.<br clear="all"><br>-- <br>&quot;The Good You Do, The Best You GET&quot;<br><br>Regards<br>
Srikanth Krishnakar<br>**********************<br>

--0016e6d97801cc872e04921a71bd--

--0016e6d97801cc873504921a71bf
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-RTC-rtc-cmos.c-Fix-warning-on-PowerPC.patch"
Content-Disposition: attachment;
	filename="0001-RTC-rtc-cmos.c-Fix-warning-on-PowerPC.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gf11yrg70

RnJvbSA4NDM1ZTU4NzZmYzNkNjI5NDA2YzYzYjg1YmZmODJjMjVmYzRiZjc1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTcmlrYW50aCBLcmlzaG5ha2FyIDxza3Jpc2huYUBtdmlzdGEu
Y29tPgpEYXRlOiBGcmksIDggT2N0IDIwMTAgMTg6MDc6MDYgKzA1MzAKU3ViamVjdDogW1BBVENI
XSBSVEM6IHJ0Yy1jbW9zLmM6IEZpeCB3YXJuaW5nIG9uIFBvd2VyUEMKClRoZSBmb2xsb3dpbmcg
d2FybmluZyBpcyBzZWVuIHdoaWxlIGNvbXBpbGF0aW9uIG9mIFBvd2VyUEMga2VybmVsOgoKIEND
ICAgICAgZHJpdmVycy9ydGMvcnRjLWNtb3Mubwpkcml2ZXJzL3J0Yy9ydGMtY21vcy5jOjY5Nzoy
OiB3YXJuaW5nOiAjd2FybmluZyBBc3N1bWluZyAxMjggYnl0ZXMKb2YgUlRDK05WUkFNIGFkZHJl
c3Mgc3BhY2UsIG5vdCA2NCBieXRlcy4KCkZpeCBpdCBieSBhZGRpbmcgZGVmaW5lZChfX3Bvd2Vy
cGNfXykuCgpTaWduZWQtb2ZmLWJ5OiBTcmlrYW50aCBLcmlzaG5ha2FyIDxza3Jpc2huYUBtdmlz
dGEuY29tPgotLS0KIGRyaXZlcnMvcnRjL3J0Yy1jbW9zLmMgfCAgICAzICsrLQogMSBmaWxlcyBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ydGMvcnRjLWNtb3MuYyBiL2RyaXZlcnMvcnRjL3J0Yy1jbW9zLmMKaW5kZXggNTg1NjE2
Ny4uN2U2Y2U2MiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ydGMvcnRjLWNtb3MuYworKysgYi9kcml2
ZXJzL3J0Yy9ydGMtY21vcy5jCkBAIC02ODcsNyArNjg3LDggQEAgY21vc19kb19wcm9iZShzdHJ1
Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCByZXNvdXJjZSAqcG9ydHMsIGludCBydGNfaXJxKQogI2lm
CWRlZmluZWQoQ09ORklHX0FUQVJJKQogCWFkZHJlc3Nfc3BhY2UgPSA2NDsKICNlbGlmIGRlZmlu
ZWQoX19pMzg2X18pIHx8IGRlZmluZWQoX194ODZfNjRfXykgfHwgZGVmaW5lZChfX2FybV9fKSBc
Ci0JCQl8fCBkZWZpbmVkKF9fc3BhcmNfXykgfHwgZGVmaW5lZChfX21pcHNfXykKKwkJCXx8IGRl
ZmluZWQoX19zcGFyY19fKSB8fCBkZWZpbmVkKF9fbWlwc19fKSBcCisJCQl8fCBkZWZpbmVkKF9f
cG93ZXJwY19fKQogCWFkZHJlc3Nfc3BhY2UgPSAxMjg7CiAjZWxzZQogI3dhcm5pbmcgQXNzdW1p
bmcgMTI4IGJ5dGVzIG9mIFJUQytOVlJBTSBhZGRyZXNzIHNwYWNlLCBub3QgNjQgYnl0ZXMuCi0t
IAoxLjYuMy4zLjMzMy5nZGY2OAoK
--0016e6d97801cc873504921a71bf--
