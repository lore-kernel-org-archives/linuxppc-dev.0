Return-Path: <pradyumna.sampath@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.182])
	by ozlabs.org (Postfix) with ESMTP id A0C02DDE43
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 May 2007 14:24:51 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id z74so3685779pyg
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 May 2007 21:24:50 -0700 (PDT)
Message-ID: <f87351060705282124q6d6b1562ic1dd4da4b8a62886@mail.gmail.com>
Date: Tue, 29 May 2007 09:54:49 +0530
From: "Pradyumna Sampath" <pradyumna.sampath@gmail.com>
To: linuxppc-embedded@ozlabs.org, linux-rt-users@vger.kernel.org
Subject: [PATCH] Powerpc compiler error fix for 2.6.21-rt8
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_130582_14329058.1180412689748"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_130582_14329058.1180412689748
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi everyone,

Attached is a small patch to fix compile time errors which is broken
in 2.6.21-rt8 for powerpc.

thanks
regards
prady

------=_Part_130582_14329058.1180412689748
Content-Type: text/x-patch; name=2_6_21_rt8_powerpc_rt_compile_fix.diff;
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f29vqqfj
Content-Disposition: attachment; filename="2_6_21_rt8_powerpc_rt_compile_fix.diff"

ZGlmZiAtdXIgbGF0ZXN0L2xpbnV4LTIuNi4yMS9hcmNoL3Bvd2VycGMva2VybmVsL3RpbWUuYyBs
aW51eC0yLjYuMjEvYXJjaC9wb3dlcnBjL2tlcm5lbC90aW1lLmMKLS0tIGxhdGVzdC9saW51eC0y
LjYuMjEvYXJjaC9wb3dlcnBjL2tlcm5lbC90aW1lLmMJMjAwNy0wNS0yOSAwOTo1ODoxMi4wMDAw
MDAwMDAgKzA1MzAKKysrIGxpbnV4LTIuNi4yMS9hcmNoL3Bvd2VycGMva2VybmVsL3RpbWUuYwky
MDA3LTA1LTI5IDA4OjU4OjU2LjAwMDAwMDAwMCArMDUzMApAQCAtOTUsNiArOTUsOCBAQAogI2Rl
ZmluZSBTQ0FMRV9YU0VDKHhzZWMsIG1heCkJbXVsaHd1KCh4c2VjKSA8PCAxMiwgbWF4KQogI2Vu
ZGlmCiAKK3Vuc2lnbmVkIGxvbmcgY3B1X2toejsgIC8qIERldGVjdGVkIGFzIHdlIGNhbGlicmF0
ZSB0aGUgVFNDICovCitFWFBPUlRfU1lNQk9MKGNwdV9raHopOwogdW5zaWduZWQgbG9uZyB0Yl90
aWNrc19wZXJfamlmZnk7CiB1bnNpZ25lZCBsb25nIHRiX3RpY2tzX3Blcl91c2VjID0gMTAwOyAv
KiBzYW5lIGRlZmF1bHQgKi8KIEVYUE9SVF9TWU1CT0wodGJfdGlja3NfcGVyX3VzZWMpOwpPbmx5
IGluIGxpbnV4LTIuNi4yMS9hcmNoL3Bvd2VycGMva2VybmVsOiB2bWxpbnV4LmxkcwpPbmx5IGlu
IGxpbnV4LTIuNi4yMS9zY3JpcHRzL2tjb25maWc6IG1jb25mCg==
------=_Part_130582_14329058.1180412689748--
