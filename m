Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id 2FA76DDDFC
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 30 Apr 2007 19:03:29 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so933145ugf
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 30 Apr 2007 02:03:27 -0700 (PDT)
Message-ID: <528646bc0704300203p2b7afb22we23fa0da66c80a80@mail.gmail.com>
Date: Mon, 30 Apr 2007 03:03:27 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Andrei Konovalov" <akonovalov@ru.mvista.com>,
	"Linux PPC" <linuxppc-embedded@ozlabs.org>
Subject: Xilinx framebuffer platform bus binding
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_49573_13243200.1177923807375"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_49573_13243200.1177923807375
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Andrei; FWIW, here is the code that I'm using to register the Xilinx
FB to the platform bus.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195

------=_Part_49573_13243200.1177923807375
Content-Type: application/x-patch; name=tft_binding.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f14pdcww
Content-Disposition: attachment; filename="tft_binding.patch"

LS0tIGFyY2gvcHBjL3N5c2xpYi92aXJ0ZXhfZGV2aWNlcy5jLm9sZAkyMDA3LTA0LTMwIDAyOjU5
OjE4LjAwMDAwMDAwMCAtMDYwMAorKysgYXJjaC9wcGMvc3lzbGliL3ZpcnRleF9kZXZpY2VzLmMJ
MjAwNy0wNC0zMCAwMjo1Nzo1My4wMDAwMDAwMDAgLTA2MDAKQEAgLTE1Myw2ICsxNTMsMjYgQEAK
IAl9LCBcCiB9CiAKKy8qCisgKiBNTDMwMC9NTDQwMyBWaWRlbyBEZXZpY2U6IHNob3J0Y3V0IG1h
Y3JvIGZvciBzaW5nbGUgaW5zdGFuY2UKKyAqLworI2RlZmluZSBYUEFSX1RGVChudW0pIHsgXAor
CS5uYW1lID0gInhpbGlueGZiIiwgXAorCS5pZCA9IG51bSwgXAorCS5kZXYucGxhdGZvcm1fZGF0
YSA9ICYoc3RydWN0IHhpbGlueGZiX3BsYXRmb3JtX2RhdGEpIHsgXAorCQkudXNlX2RjciA9IFhQ
QVJfVEZUXyMjbnVtIyNfVVNFX0RDUiwgXAorCQkuc2NyZWVuX2hlaWdodF9tbSA9IENPTkZJR19G
Ql9YSUxJTlhfU0NSX0hFSUdIVCwgXAorCQkuc2NyZWVuX3dpZHRoX21tID0gQ09ORklHX0ZCX1hJ
TElOWF9TQ1JfV0lEVEgsIFwKKwl9LCBcCisJLm51bV9yZXNvdXJjZXMgPSAxLCBcCisJLnJlc291
cmNlID0gKHN0cnVjdCByZXNvdXJjZVtdKSB7IFwKKwkJeyBcCisJCQkuc3RhcnQgPSBYUEFSX1RG
VF8jI251bSMjX0JBU0VBRERSLCBcCisJCQkuZW5kID0gWFBBUl9URlRfIyNudW0jI19CQVNFQURE
Uis3LCBcCisJCQkuZmxhZ3MgPSBJT1JFU09VUkNFX0lPLCBcCisJCX0sIFwKKwl9LCBcCit9CiAK
IC8qIFVBUlQgODI1MCBkcml2ZXIgcGxhdGZvcm0gZGF0YSB0YWJsZSAqLwogc3RydWN0IHBsYXRf
c2VyaWFsODI1MF9wb3J0IHZpcnRleF9zZXJpYWxfcGxhdGZvcm1fZGF0YVtdID0gewpAQCAtMjc1
LDYgKzI5NSwxMiBAQAogI2VuZGlmCiAjZW5kaWYKIAorI2lmIGRlZmluZWQoWFBBUl9URlRfMF9C
QVNFQUREUikKKwlYUEFSX1RGVCgwKSwKKyNlbmRpZgorI2lmIGRlZmluZWQoWFBBUl9URlRfMV9C
QVNFQUREUikKKwlYUEFSX1RGVCgxKSwKKyNlbmRpZgogfTsKIAogLyogRWFybHkgc2VyaWFsIHN1
cHBvcnQgZnVuY3Rpb25zICovCg==
------=_Part_49573_13243200.1177923807375--
