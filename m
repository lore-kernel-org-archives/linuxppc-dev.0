Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.192])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rvcrd58S8zDqTf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jul 2016 23:17:04 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Paulo Flabiano Smorigo' <pfsmorigo@linux.vnet.ibm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Paul Mackerras
 <paulus@samba.org>, "open list:CRYPTO API" <linux-crypto@vger.kernel.org>,
 "open list:LINUX FOR POWERPC 32-BIT AND 64-BIT"
 <linuxppc-dev@lists.ozlabs.org>, "David S. Miller" <davem@davemloft.net>
Subject: RE: [PATCH] crypto: vmx - Ignore generated files
Date: Wed, 20 Jul 2016 13:15:14 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D5F4FE8AB@AcuExch.aculab.com>
References: <1468935388-6489-1-git-send-email-pfsmorigo@linux.vnet.ibm.com>
In-Reply-To: <1468935388-6489-1-git-send-email-pfsmorigo@linux.vnet.ibm.com>
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

RnJvbTogIFBhdWxvIEZsYWJpYW5vIFNtb3JpZ28NCj4gU2VudDogMTkgSnVseSAyMDE2IDE0OjM2
DQo+IElnbm9yZSBhc3NlbWJseSBmaWxlcyBnZW5lcmF0ZWQgYnkgdGhlIHBlcmwgc2NyaXB0Lg0K
Li4uDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NyeXB0by92bXgvLmdpdGlnbm9yZSBiL2RyaXZl
cnMvY3J5cHRvL3ZteC8uZ2l0aWdub3JlDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4
IDAwMDAwMDAuLmFmNGE3Y2UNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9kcml2ZXJzL2NyeXB0
by92bXgvLmdpdGlnbm9yZQ0KPiBAQCAtMCwwICsxLDIgQEANCj4gK2Flc3A4LXBwYy5TDQo+ICtn
aGFzaHA4LXBwYy5TDQoNClNob3VsZG4ndCB0aGUgZ2VuZXJhdGVkIGZpbGVzIGJlIHdyaXR0ZW4g
dG8gdGhlIG9iamVjdCB0cmVlPw0KDQpJIHdvdWxkIGhvcGUgdGhlIGxpbnV4IGtlcm5lbCBidWls
ZHMgZnJvbSBhIHJlYWRvbmx5IHNvdXJjZSB0cmVlLg0KDQoJRGF2aWQNCg0K
