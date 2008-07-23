Return-Path: <weiyi.huang@gmail.com>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.191])
	by ozlabs.org (Postfix) with ESMTP id 0ED27DDED9
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 00:44:51 +1000 (EST)
Received: by ti-out-0910.google.com with SMTP id w7so1271340tib.13
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 07:44:50 -0700 (PDT)
Date: Wed, 23 Jul 2008 22:44:51 +0800
From: Huang Weiyi <weiyi.huang@gmail.com>
To: hch@infradead.org,
 paulus@samba.org,
 benh@kernel.crashing.org
Subject: arch/powerpc/kernel/stacktrace.c: Removed duplicated include
Message-Id: <20080723214310.9413.WEIYI.HUANG@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

UmVtb3ZlZCBkdXBsaWNhdGVkIGluY2x1ZGUgZmlsZSA8bGludXgvbW9kdWxlLmg+IGluDQphcmNo
L3Bvd2VycGMva2VybmVsL3N0YWNrdHJhY2UuYy4NCg0KU2lnbmVkLW9mZi1ieTogSHVhbmcgV2Vp
eWkgPHdlaXlpLmh1YW5nQGdtYWlsLmNvbT4NCg0KZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9r
ZXJuZWwvc3RhY2t0cmFjZS5jIGIvYXJjaC9wb3dlcnBjL2tlcm5lbC9zdGFja3RyYWNlLmMNCmlu
ZGV4IGYyNTg5NjQuLmIwZGJiMWQgMTAwNjQ0DQotLS0gYS9hcmNoL3Bvd2VycGMva2VybmVsL3N0
YWNrdHJhY2UuYw0KKysrIGIvYXJjaC9wb3dlcnBjL2tlcm5lbC9zdGFja3RyYWNlLmMNCkBAIC0x
Myw3ICsxMyw2IEBADQogI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KICNpbmNsdWRlIDxsaW51
eC9zY2hlZC5oPg0KICNpbmNsdWRlIDxsaW51eC9zdGFja3RyYWNlLmg+DQotI2luY2x1ZGUgPGxp
bnV4L21vZHVsZS5oPg0KICNpbmNsdWRlIDxhc20vcHRyYWNlLmg+DQogI2luY2x1ZGUgPGFzbS9w
cm9jZXNzb3IuaD4NCg0K
