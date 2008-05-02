Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by ozlabs.org (Postfix) with ESMTP id E6763DDE0A
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 03:19:47 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id n7so246718wag.13
	for <linuxppc-dev@ozlabs.org>; Fri, 02 May 2008 10:19:46 -0700 (PDT)
Message-ID: <9e4733910805021019t6fb94ed0m63a82ba7103c0202@mail.gmail.com>
Date: Fri, 2 May 2008 13:19:44 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Jean Delvare" <khali@linux-fr.org>
Subject: Re: [PATCH] mpc i2c driver, compare to NO_IRQ instead of zero
In-Reply-To: <20080502182917.41dc560e@hyperion.delvare>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_15104_32453361.1209748785054"
References: <20080121200740.13800.20524.stgit@terra.home>
	<20080219174221.5b18cba8@hyperion.delvare>
	<9e4733910805020723p7900c132j872893113f9d739e@mail.gmail.com>
	<20080502164610.277ec04b@hyperion.delvare>
	<9e4733910805020902ga4f05b3nfd2221511ec2ebba@mail.gmail.com>
	<20080502182917.41dc560e@hyperion.delvare>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_15104_32453361.1209748785054
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I attached the diff file. I had forgot that I renamed the file so it
wasn't getting compiled. I compiled it this time. I've made too many
other changes to it to test this version on my current hardware.

-- 
Jon Smirl
jonsmirl@gmail.com

------=_Part_15104_32453361.1209748785054
Content-Type: text/x-diff; name=p2.diff
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ffr12x2e
Content-Disposition: attachment; filename=p2.diff

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtbXBjLmMgYi9kcml2ZXJzL2kyYy9i
dXNzZXMvaTJjLW1wYy5jCmluZGV4IGJiZTc4N2IuLmQ3M2VkZWYgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvaTJjL2J1c3Nlcy9pMmMtbXBjLmMKKysrIGIvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1tcGMu
YwpAQCAtOTksNyArOTksNyBAQCBzdGF0aWMgaW50IGkyY193YWl0KHN0cnVjdCBtcGNfaTJjICpp
MmMsIHVuc2lnbmVkIHRpbWVvdXQsIGludCB3cml0aW5nKQogCXUzMiB4OwogCWludCByZXN1bHQg
PSAwOwogCi0JaWYgKGkyYy0+aXJxID09IDApCisJaWYgKGkyYy0+aXJxID09IE5PX0lSUSkKIAl7
CiAJCXdoaWxlICghKHJlYWRiKGkyYy0+YmFzZSArIE1QQ19JMkNfU1IpICYgQ1NSX01JRikpIHsK
IAkJCXNjaGVkdWxlKCk7CkBAIC0zMjksMTAgKzMyOSw5IEBAIHN0YXRpYyBpbnQgZnNsX2kyY19w
cm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCQlyZXR1cm4gLUVOT01FTTsKIAog
CWkyYy0+aXJxID0gcGxhdGZvcm1fZ2V0X2lycShwZGV2LCAwKTsKLQlpZiAoaTJjLT5pcnEgPCAw
KSB7Ci0JCXJlc3VsdCA9IC1FTlhJTzsKLQkJZ290byBmYWlsX2dldF9pcnE7Ci0JfQorCWlmIChp
MmMtPmlycSA8IDApCisJCWkyYy0+aXJxID0gTk9fSVJROyAvKiBVc2UgcG9sbGluZyAqLworCiAJ
aTJjLT5mbGFncyA9IHBkYXRhLT5kZXZpY2VfZmxhZ3M7CiAJaW5pdF93YWl0cXVldWVfaGVhZCgm
aTJjLT5xdWV1ZSk7CiAKQEAgLTM0NCw3ICszNDMsNyBAQCBzdGF0aWMgaW50IGZzbF9pMmNfcHJv
YmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKIAkJZ290byBmYWlsX21hcDsKIAl9CiAK
LQlpZiAoaTJjLT5pcnEgIT0gMCkKKwlpZiAoaTJjLT5pcnEgIT0gTk9fSVJRKQogCQlpZiAoKHJl
c3VsdCA9IHJlcXVlc3RfaXJxKGkyYy0+aXJxLCBtcGNfaTJjX2lzciwKIAkJCQkJICBJUlFGX1NI
QVJFRCwgImkyYy1tcGMiLCBpMmMpKSA8IDApIHsKIAkJCXByaW50ayhLRVJOX0VSUgpAQCAtMzY3
LDEyICszNjYsMTEgQEAgc3RhdGljIGludCBmc2xfaTJjX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpCiAJcmV0dXJuIHJlc3VsdDsKIAogICAgICAgZmFpbF9hZGQ6Ci0JaWYgKGky
Yy0+aXJxICE9IDApCisJaWYgKGkyYy0+aXJxICE9IE5PX0lSUSkKIAkJZnJlZV9pcnEoaTJjLT5p
cnEsIGkyYyk7CiAgICAgICBmYWlsX2lycToKIAlpb3VubWFwKGkyYy0+YmFzZSk7CiAgICAgICBm
YWlsX21hcDoKLSAgICAgIGZhaWxfZ2V0X2lycToKIAlrZnJlZShpMmMpOwogCXJldHVybiByZXN1
bHQ7CiB9OwpAQCAtMzg0LDcgKzM4Miw3IEBAIHN0YXRpYyBpbnQgZnNsX2kyY19yZW1vdmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKIAlpMmNfZGVsX2FkYXB0ZXIoJmkyYy0+YWRhcCk7
CiAJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgTlVMTCk7CiAKLQlpZiAoaTJjLT5pcnEgIT0g
MCkKKwlpZiAoaTJjLT5pcnEgIT0gTk9fSVJRKQogCQlmcmVlX2lycShpMmMtPmlycSwgaTJjKTsK
IAogCWlvdW5tYXAoaTJjLT5iYXNlKTsK
------=_Part_15104_32453361.1209748785054--
