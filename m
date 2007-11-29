Return-Path: <gorcunov@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.183])
	by ozlabs.org (Postfix) with ESMTP id 416F6DDDEF
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 16:41:17 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so2365090wag
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2007 21:41:14 -0800 (PST)
Message-ID: <aa79d98a0711282141l6b07569fmb925b198730a554e@mail.gmail.com>
Date: Thu, 29 Nov 2007 08:41:14 +0300
From: "Cyrill Gorcunov" <gorcunov@gmail.com>
To: "Ishizaki Kou" <kou.ishizaki@toshiba.co.jp>
Subject: Re: [PATCH] PPC: CELLEB - fix potential NULL pointer dereference
In-Reply-To: <20071129.122245.-1300543769.kouish@swc.toshiba.co.jp>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_581_27737840.1196314874618"
References: <aa79d98a0711280259o6cc6fb12mf020c4a986d84ca6@mail.gmail.com>
	<20071129.122245.-1300543769.kouish@swc.toshiba.co.jp>
Cc: olof@lixom.net, paulus@samba.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_581_27737840.1196314874618
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 11/29/07, Ishizaki Kou <kou.ishizaki@toshiba.co.jp> wrote:
[...snip...]
>
> There is no problem to use Michael's part, and I also prefer simple
> one like this.
>
> Cyrill, would you please update your patch?
>
> Best regards,
> Kou Ishizaki
>

Please see updated patch enveloped. (Can't do it inline becase I'm on
my work now where I have no Linux machine)

Cyrill

------=_Part_581_27737840.1196314874618
Content-Type: text/plain; name=ppc-celleb-fix-null-v2.diff
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f9kuy5f4
Content-Disposition: attachment; filename=ppc-celleb-fix-null-v2.diff

LS0tCkZyb206IEN5cmlsbCBHb3JjdW5vdiA8Z29yY3Vub3ZAZ21haWwuY29tPgpTdWJqZWN0OiBb
UEFUQ0hdIFBQQzogQ0VMTEVCIC0gZml4IHBvc3NpYmxlIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5j
ZQoKVGhpcyBwYXRjaCBhZGRzIGNoZWNraW5nIGZvciBOVUxMIHJldHVybmVkIHZhbHVlIHRvCnBy
ZXZlbnQgcG9zc2libGUgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlLgoKU2lnbmVkLW9mZi1ieTog
Q3lyaWxsIEdvcmN1bm92IDxnb3JjdW5vdkBnbWFpbC5jb20+Ci0tLQoKIGFyY2gvcG93ZXJwYy9w
bGF0Zm9ybXMvY2VsbGViL3BjaS5jIHwgICAxMSArKysrKysrKy0tLQogMSBmaWxlcyBjaGFuZ2Vk
LCA4IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9wb3dl
cnBjL3BsYXRmb3Jtcy9jZWxsZWIvcGNpLmMgYi9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zL2NlbGxl
Yi9wY2kuYwppbmRleCA2YmMzMmZkLi4xM2VjNGE2IDEwMDY0NAotLS0gYS9hcmNoL3Bvd2VycGMv
cGxhdGZvcm1zL2NlbGxlYi9wY2kuYworKysgYi9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zL2NlbGxl
Yi9wY2kuYwpAQCAtMTM4LDggKzEzOCw2IEBAIHN0YXRpYyB2b2lkIGNlbGxlYl9jb25maWdfcmVh
ZF9mYWtlKHVuc2lnbmVkIGNoYXIgKmNvbmZpZywgaW50IHdoZXJlLAogCQkqdmFsID0gY2VsbGVi
X2Zha2VfY29uZmlnX3JlYWRsKHApOwogCQlicmVhazsKIAl9Ci0KLQlyZXR1cm47CiB9CiAKIHN0
YXRpYyB2b2lkIGNlbGxlYl9jb25maWdfd3JpdGVfZmFrZSh1bnNpZ25lZCBjaGFyICpjb25maWcs
IGludCB3aGVyZSwKQEAgLTE1OCw3ICsxNTYsNiBAQCBzdGF0aWMgdm9pZCBjZWxsZWJfY29uZmln
X3dyaXRlX2Zha2UodW5zaWduZWQgY2hhciAqY29uZmlnLCBpbnQgd2hlcmUsCiAJCWNlbGxlYl9m
YWtlX2NvbmZpZ193cml0ZWwodmFsLCBwKTsKIAkJYnJlYWs7CiAJfQotCXJldHVybjsKIH0KIAog
c3RhdGljIGludCBjZWxsZWJfZmFrZV9wY2lfcmVhZF9jb25maWcoc3RydWN0IHBjaV9idXMgKmJ1
cywKQEAgLTM1MSw2ICszNDgsMTAgQEAgc3RhdGljIGludCBfX2luaXQgY2VsbGViX3NldHVwX2Zh
a2VfcGNpX2RldmljZShzdHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGUsCiAJd2kxID0gb2ZfZ2V0X3By
b3BlcnR5KG5vZGUsICJ2ZW5kb3ItaWQiLCBOVUxMKTsKIAl3aTIgPSBvZl9nZXRfcHJvcGVydHko
bm9kZSwgImNsYXNzLWNvZGUiLCBOVUxMKTsKIAl3aTMgPSBvZl9nZXRfcHJvcGVydHkobm9kZSwg
InJldmlzaW9uLWlkIiwgTlVMTCk7CisJaWYgKCF3aTAgfHwgIXdpMSB8fCAhd2kyIHx8ICF3aTMp
IHsKKwkJcHJpbnRrKEtFUk5fRVJSICJQQ0k6IE1pc3NpbmcgZGV2aWNlIHRyZWUgcHJvcGVydGll
cy5cbiIpOworCQlnb3RvIGVycm9yOworCX0KIAogCWNlbGxlYl9jb25maWdfd3JpdGVfZmFrZSgq
Y29uZmlnLCBQQ0lfREVWSUNFX0lELCAyLCB3aTBbMF0gJiAweGZmZmYpOwogCWNlbGxlYl9jb25m
aWdfd3JpdGVfZmFrZSgqY29uZmlnLCBQQ0lfVkVORE9SX0lELCAyLCB3aTFbMF0gJiAweGZmZmYp
OwpAQCAtMzcyLDYgKzM3MywxMCBAQCBzdGF0aWMgaW50IF9faW5pdCBjZWxsZWJfc2V0dXBfZmFr
ZV9wY2lfZGV2aWNlKHN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9kZSwKIAljZWxsZWJfc2V0dXBfcGNp
X2Jhc2VfYWRkcnMoaG9zZSwgZGV2bm8sIGZuLCBudW1fYmFzZV9hZGRyKTsKIAogCWxpID0gb2Zf
Z2V0X3Byb3BlcnR5KG5vZGUsICJpbnRlcnJ1cHRzIiwgJnJsZW4pOworCWlmICghbGkpIHsKKwkJ
cHJpbnRrKEtFUk5fRVJSICJQQ0k6IGludGVycnVwdHMgbm90IGZvdW5kLlxuIik7CisJCWdvdG8g
ZXJyb3I7CisJfQogCXZhbCA9IGxpWzBdOwogCWNlbGxlYl9jb25maWdfd3JpdGVfZmFrZSgqY29u
ZmlnLCBQQ0lfSU5URVJSVVBUX1BJTiwgMSwgMSk7CiAJY2VsbGViX2NvbmZpZ193cml0ZV9mYWtl
KCpjb25maWcsIFBDSV9JTlRFUlJVUFRfTElORSwgMSwgdmFsKTsK
------=_Part_581_27737840.1196314874618--
