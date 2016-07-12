Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rpnKn2BkCzDqDT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 02:22:04 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Paulo Flabiano Smorigo' <pfsmorigo@linux.vnet.ibm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Leonidas S. Barbosa" <leosilva@linux.vnet.ibm.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, Paul Mackerras <paulus@samba.org>, "open
 list:IBM Power VMX Cryptographic instructions"
 <linux-crypto@vger.kernel.org>, "open list:LINUX FOR POWERPC 32-BIT AND
 64-BIT" <linuxppc-dev@lists.ozlabs.org>, "David S. Miller"
 <davem@davemloft.net>
Subject: RE: [PATCH 1/2] crypto: vmx - Adding asm subroutines for XTS
Date: Tue, 12 Jul 2016 16:19:42 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D5F4F62C4@AcuExch.aculab.com>
References: <1468264060-22769-1-git-send-email-pfsmorigo@linux.vnet.ibm.com>
In-Reply-To: <1468264060-22769-1-git-send-email-pfsmorigo@linux.vnet.ibm.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RnJvbTogUGF1bG8gRmxhYmlhbm8gU21vcmlnbw0KPiBTZW50OiAxMSBKdWx5IDIwMTYgMjA6MDgN
Cj4gDQo+IFRoaXMgcGF0Y2ggYWRkIFhUUyBzdWJyb3V0aW5lcyB1c2luZyBWTVgtY3J5cHRvIGRy
aXZlci4NCj4gDQo+IEl0IGdpdmVzIGEgYm9vc3Qgb2YgMjAgdGltZXMgdXNpbmcgWFRTLg0KPiAN
Cj4gVGhlc2UgY29kZSBoYXMgYmVlbiBhZG9wdGVkIGZyb20gT3BlblNTTCBwcm9qZWN0IGluIGNv
bGxhYm9yYXRpb24NCj4gd2l0aCB0aGUgb3JpZ2luYWwgYXV0aG9yIChBbmR5IFBvbHlha292IDxh
cHByb0BvcGVuc3NsLm9yZz4pLg0KDQpZZXAsIHR5cGljYWwgb3BlbnNzbCBjb2RlLiAxMDAwKyBs
aW5lcyBvZiB1bmNvbW1lbnRlZCBpbXBlbmV0cmFibGUgYXNzZW1ibGVyLg0KVGhlcmUgaXMgMCBj
aGFuY2Ugb2YgYW55b25lIGV2ZXIgY2hlY2tpbmcgdGhpcyBkb2VzIHdoYXQgaXQgc2hvdWxkLg0K
DQoJRGF2aWQNCg0K
