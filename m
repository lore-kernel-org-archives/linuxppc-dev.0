Return-Path: <r61911@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe001.messaging.microsoft.com [216.32.180.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A7BFB2C0040
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Jun 2013 19:44:50 +1000 (EST)
From: Zang Roy-R61911 <r61911@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: RE: FSL 64-bit DMA window question
Date: Fri, 7 Jun 2013 09:44:10 +0000
Message-ID: <3E027F8168735B46AC006B1D0C7BB0020B213BF7@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1368679657.9603.32.camel@pasglop>
 <1368683156.9603.34.camel@pasglop>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0701C307@039-SN2MPN1-012.039d.mgd.msft.net>
 <3E027F8168735B46AC006B1D0C7BB0020B1E040F@039-SN2MPN1-011.039d.mgd.msft.net>
 <1368684547.9603.38.camel@pasglop> <51947A00.9010504@windriver.com>
 <1368685307.9603.39.camel@pasglop> <51947E35.30808@windriver.com>
 <1368686426.9603.49.camel@pasglop> <5194800D.3010606@windriver.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0701C498@039-SN2MPN1-012.039d.mgd.msft.net>
 <1368687133.9603.51.camel@pasglop>
 <CAOZdJXU79kqEGk_nqv1NSzna7c=bgwSv+6WFgaTVjR4Rj4cZVg@mail.gmail.com>
 <1370577138.3766.342.camel@pasglop> <1370579976.3766.345.camel@pasglop>
 <3E027F8168735B46AC006B1D0C7BB0020B2135A0@039-SN2MPN1-012.039d.mgd.msft.net>
 <1370588727.3766.355.camel@pasglop>
 <3E027F8168735B46AC006B1D0C7BB0020B213AA9@039-SN2MPN1-012.039d.mgd.msft.net>
 <1370595309.3766.361.camel@pasglop>
In-Reply-To: <1370595309.3766.361.camel@pasglop>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Xie Shaohui-B21989 <B21989@freescale.com>,
 Liu Qiang-B32616 <B32616@freescale.com>, Timur Tabi <timur@tabi.org>,
 "tiejun.chen" <tiejun.chen@windriver.com>,
 Fleming Andy-AFLEMING <afleming@freescale.com>,
 Bhushan Bharat-R65777 <R65777@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmVuamFtaW4gSGVycmVu
c2NobWlkdCBbbWFpbHRvOmJlbmhAa2VybmVsLmNyYXNoaW5nLm9yZ10NCj4gDQo+IE9uIEZyaSwg
MjAxMy0wNi0wNyBhdCAwNzo1OCArMDAwMCwgWmFuZyBSb3ktUjYxOTExIHdyb3RlOg0KPiA+DQo+
ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogQmVuamFtaW4gSGVy
cmVuc2NobWlkdCBbbWFpbHRvOmJlbmhAa2VybmVsLmNyYXNoaW5nLm9yZ10NCj4gPiA+DQo+ID4g
PiBIaSBGb2xrcyAhDQo+ID4gPg0KPiA+ID4gSXMgdGhlcmUgYW55IHNwZWNpZmljIHJlYXNvbiB3
aHkgeW91IGNob3NlIDFUICg0MCBiaXQpIGFzIHRoZQ0KPiBsb2NhdGlvbiBvZg0KPiA+ID4gdGhl
IDY0LWJpdCBETUEgd2luZG93ID8NCj4gPiA+DQo+ID4gPiBJdCBoYXBwZW5zIHRoYXQgbW9zdCBj
dXJyZW50IHJhZGVvbiBhZGFwdGVycyBjYW5ub3QgRE1BIHRoZXJlLCB0aGV5DQo+IGhhdmUNCj4g
PiA+IGEgNDAtYml0IERNQSBsaW1pdC4gSSBzZWVtIHRvIGJlIGdldHRpbmcgdGhpbmdzIHRvIHdv
cmsgZmluZSB1c2luZyBhDQo+IDM5LQ0KPiA+ID4gYml0IHdpbmRvdywgYnV0IEkgc3VwcG9zZSB0
aGF0IG1pZ2h0IGNvbGxpZGUgd2l0aCBzb21ldGhpbmcgZWxzZSA/DQo+ID4gVDQyNDAgaGFzIDQw
Yml0IHBoeXNpY2FsIGFkZHJlc3MgYWJpbGl0eS4NCj4gPiAiDQo+ID4gVGhpcyBjaGlwJ3MgNDAt
Yml0LCBwaHlzaWNhbCBhZGRyZXNzIG1hcCBjb25zaXN0cyBvZiBsb2NhbCBzcGFjZSBhbmQNCj4g
ZXh0ZXJuYWwgYWRkcmVzcw0KPiA+IHNwYWNlLiBGb3IgdGhlIGxvY2FsIGFkZHJlc3MgbWFwLCAz
MiBsb2NhbCBhY2Nlc3Mgd2luZG93cyAoTEFXcykgZGVmaW5lDQo+IG1hcHBpbmcNCj4gPiB3aXRo
aW4gdGhlIGxvY2FsIDQwLWJpdCAoMSBUQikgYWRkcmVzcyBzcGFjZS4gSW5ib3VuZCBhbmQgb3V0
Ym91bmQNCj4gdHJhbnNsYXRpb24gd2luZG93cw0KPiA+IGNhbiBtYXAgdGhlIGNoaXAgaW50byBh
IGxhcmdlciBzeXN0ZW0gYWRkcmVzcyBzcGFjZSBzdWNoIGFzIHRoZSBSYXBpZElPDQo+IG9yIFBD
SWUgNjQtYml0DQo+ID4gYWRkcmVzcyBlbnZpcm9ubWVudC4gVGhpcyBmdW5jdGlvbmFsaXR5IGlz
IGluY2x1ZGVkIGluIHRoZSBhZGRyZXNzDQo+IHRyYW5zbGF0aW9uIGFuZA0KPiA+IG1hcHBpbmcg
dW5pdHMgKEFUTVVzKS4NCj4gPg0KPiA+ICINCj4gPiBUaGF0IHNob3VsZCBiZSB0aGUgcmVhc29u
IHRvIHNldCB0aGUgRE1BIHdpbmRvdyB0byA0MC1iaXQuDQo+IEkgc2VlLiBIb3dldmVyIGlmIHRo
ZSB0b3AgaGFsZiBvZiB0aGF0IHNwYWNlIGlzbid0IHVzZWQgYnkgZGVmYXVsdCB3aXRoDQo+IHdo
YXRldmVyIGlzIG91ciBjdXJyZW50IHNldHVwLCBpdCBtYWtlcyBzZW5zZSB0byBtb3ZlIGRvd24g
dGhlIDY0LWJpdA0KPiBETUEgd2luZG93IHRvIGFsbG93IHRob3NlIGFkYXB0ZXJzIHRvIGZ1bmN0
aW9uIGRvbid0IHlvdSB0aGluayA/DQpHb29kIHRvIG1lLg0KNDAgYml0IERNQSB3aWxsIHByZXZl
bnQgeW91ciByYWRlb24gdmlkZW8gY2FyZCBmcm9tIHdvcmtpbmcuIFJpZ2h0Pw0KWW91ciBQNTAy
MCBEUyBzeXN0ZW0gb25seSBzdXBwb3J0IDM2IGJpdCBwaHlzaWNhbCBhZGRyZXNzLg0KDQo+IA0K
PiBJJ20gdHJ5aW5nIHRvIHR1cm4gdGhvc2UgRlNMIGJveGVzIGludG8gbmljZSBwcGM2NCBkZXYu
IHdvcmtzdGF0aW9ucyA6LSkNClRoYXQgaXMgZ29vZC4gSSdkIGxpa2UgdG8gc2VlIGhvdyBsb25n
IGl0IHdpbGwgYnVpbGQgYSBrZXJuZWwgLi4uDQp0aGFua3MuDQpSb3kNCg==
