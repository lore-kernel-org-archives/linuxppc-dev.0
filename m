Return-Path: <david.laight@aculab.com>
Received: from eu-smtp-delivery-211.mimecast.com
 (eu-smtp-delivery-211.mimecast.com [207.82.80.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ZgZ03TvFzF0x7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 00:23:03 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Krzysztof Kozlowski' <krzk@kernel.org>
CC: Pantelis Antoniou <pantelis.antoniou@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Eric Biggers <ebiggers3@gmail.com>
Subject: RE: [PATCH] net: ethernet: fs-enet: Use generic CRC32 implementation
Date: Tue, 24 Jul 2018 11:22:53 +0000
Message-ID: <8a9c44b51e2f4fb08f5273d3aca71e1c@AcuMS.aculab.com>
References: <20180723162020.6221-1-krzk@kernel.org>
 <5ef968e1cb2a473cad97f6bfead369ca@AcuMS.aculab.com>
 <CAJKOXPdveQeg_M42v69m9vBEz2SaJE0_BZNRUqGLt4Ve+ZLYSg@mail.gmail.com>
In-Reply-To: <CAJKOXPdveQeg_M42v69m9vBEz2SaJE0_BZNRUqGLt4Ve+ZLYSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RnJvbTogS3J6eXN6dG9mIEtvemxvd3NraQ0KPiBTZW50OiAyNCBKdWx5IDIwMTggMTI6MTINCi4u
Lg0KPiA+PiBOb3QgdGVzdGVkIG9uIGhhcmR3YXJlLg0KPiA+DQo+ID4gSGF2ZSB5b3UgdmVyaWZp
ZWQgdGhhdCB0aGUgb2xkIGFuZCBuZXcgZnVuY3Rpb25zIGdpdmUgdGhlDQo+ID4gc2FtZSByZXN1
bHQgZm9yIGEgZmV3IG1hYyBhZGRyZXNzZXM/DQo+ID4gSXQgaXMgdmVyeSBlYXN5IHRvIHVzZSB0
aGUgd3JvbmcgYml0cyBpbiBjcmMgY2FsY3VsYXRpb25zDQo+ID4gb3IgZ2VuZXJhdGUgdGhlIG91
dHB1dCBpbiB0aGUgd3JvbmcgYml0IG9yZGVyLg0KPiANCj4gSSBjb3BpZWQgdGhlIG9yaWdpbmFs
IGNvZGUgYW5kIG5ldyBvbmUgb250byBhIGRpZmZlcmVudCBkcml2ZXIgYW5kIHJ1bg0KPiB0aGlz
IGluIGEgbG9vcCBmb3IgdGhvdXNhbmRzIG9mIGRhdGEgaW5wdXQgKGFsdGhvdWdoIG5vdCBhbGwg
cG9zc2libGUNCj4gTUFDIGNvbWJpbmF0aW9ucykuIFRoZSBvdXRwdXQgd2FzIHRoZSBzYW1lLiBJ
IGFncmVlIGhvd2V2ZXIgdGhhdCByZWFsDQo+IHRlc3Rpbmcgd291bGQgYmUgaW1wb3J0YW50Lg0K
DQpTaW5jZSBDUkMgYXJlIGxpbmVhciB5b3Ugb25seSBuZWVkIHRvIGNoZWNrIHRoYXQgZWFjaCBp
bnB1dA0KYml0IGdlbmVyYXRlcyB0aGUgY29ycmVjdCBvdXRwdXQuDQoNCglEYXZpZA0KDQotDQpS
ZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWls
dG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMp
DQo=
