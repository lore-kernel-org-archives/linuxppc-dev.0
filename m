Return-Path: <B40534@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AC9EF2C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Oct 2013 18:43:54 +1100 (EST)
Received: from mail161-co1 (localhost [127.0.0.1])	by
 mail161-co1-R.bigfish.com (Postfix) with ESMTP id 721CAA80194	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Oct 2013 07:43:49 +0000 (UTC)
Received: from CO1EHSMHS014.bigfish.com (unknown [10.243.78.236])	by
 mail161-co1.bigfish.com (Postfix) with ESMTP id 4642720068	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Oct 2013 07:43:47 +0000 (UTC)
From: Wang Dongsheng-B40534 <B40534@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH v4 4/4] powerpc/85xx: add sysfs for pw20 state and
 altivec idle
Date: Fri, 11 Oct 2013 07:43:45 +0000
Message-ID: <ABB05CD9C9F68C46A5CEDC7F15439259010AA2D8@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1380014925-23300-2-git-send-email-dongsheng.wang@freescale.com>
 <1380014925-23300-4-git-send-email-dongsheng.wang@freescale.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0717F8F9@039-SN2MPN1-011.039d.mgd.msft.net>
 <ABB05CD9C9F68C46A5CEDC7F154392590108FF41@039-SN2MPN1-021.039d.mgd.msft.net>
 <1380131815.24959.185.camel@snotra.buserror.net>
 <ABB05CD9C9F68C46A5CEDC7F15439259010909C3@039-SN2MPN1-021.039d.mgd.msft.net>
 <6A3DF150A5B70D4F9B66A25E3F7C888D07183D0B@039-SN2MPN1-011.039d.mgd.msft.net>
 <ABB05CD9C9F68C46A5CEDC7F1543925901090B4F@039-SN2MPN1-021.039d.mgd.msft.net>
 <1380231435.24959.328.camel@snotra.buserror.net>
 <ABB05CD9C9F68C46A5CEDC7F15439259010911C2@039-SN2MPN1-021.039d.mgd.msft.net>
 <1380317594.24959.490.camel@snotra.buserror.net>
 <ABB05CD9C9F68C46A5CEDC7F15439259010920B0@039-SN2MPN1-021.039d.mgd.msft.net>
 <1380582385.24959.542.camel@snotra.buserror.net>
 <ABB05CD9C9F68C46A5CEDC7F1543925901094898@039-SN2MPN1-021.039d.mgd.msft.net>
 <1381243807.7979.198.camel@snotra.buserror.net>
In-Reply-To: <1381243807.7979.198.camel@snotra.buserror.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Bhushan Bharat-R65777 <R65777@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29vZCBTY290dC1CMDc0
MjENCj4gU2VudDogVHVlc2RheSwgT2N0b2JlciAwOCwgMjAxMyAxMDo1MCBQTQ0KPiBUbzogV2Fu
ZyBEb25nc2hlbmctQjQwNTM0DQo+IENjOiBXb29kIFNjb3R0LUIwNzQyMTsgQmh1c2hhbiBCaGFy
YXQtUjY1Nzc3OyBsaW51eHBwYy0NCj4gZGV2QGxpc3RzLm96bGFicy5vcmcNCj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2NCA0LzRdIHBvd2VycGMvODV4eDogYWRkIHN5c2ZzIGZvciBwdzIwIHN0YXRl
IGFuZA0KPiBhbHRpdmVjIGlkbGUNCj4gDQo+IE9uIE1vbiwgMjAxMy0xMC0wNyBhdCAyMjo1OCAt
MDUwMCwgV2FuZyBEb25nc2hlbmctQjQwNTM0IHdyb3RlOg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogV29vZCBTY290dC1CMDc0MjENCj4gPiA+IFNl
bnQ6IFR1ZXNkYXksIE9jdG9iZXIgMDEsIDIwMTMgNzowNiBBTQ0KPiA+ID4gVG86IFdhbmcgRG9u
Z3NoZW5nLUI0MDUzNA0KPiA+ID4gQ2M6IFdvb2QgU2NvdHQtQjA3NDIxOyBCaHVzaGFuIEJoYXJh
dC1SNjU3Nzc7IGxpbnV4cHBjLQ0KPiA+ID4gZGV2QGxpc3RzLm96bGFicy5vcmcNCj4gPiA+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjQgNC80XSBwb3dlcnBjLzg1eHg6IGFkZCBzeXNmcyBmb3IgcHcy
MCBzdGF0ZQ0KPiBhbmQNCj4gPiA+IGFsdGl2ZWMgaWRsZQ0KPiA+ID4NCj4gPiA+IE9uIFN1biwg
MjAxMy0wOS0yOSBhdCAwMTo1NyAtMDUwMCwgV2FuZyBEb25nc2hlbmctQjQwNTM0IHdyb3RlOg0K
PiA+ID4gPiBJIHRoaW5rIHdlIG5lZWQgdG8gZG8gdGhpczoNCj4gPiA+ID4NCj4gPiA+ID4gI2Rl
ZmluZSBVNjRfTE9XX01BU0sgICAgICAgICAgICAweGZmZmZmZmZmVUxMDQo+ID4gPiA+ICNkZWZp
bmUgVTY0X01BU0sgICAgICAgICAgICAgICAgMHhmZmZmZmZmZmZmZmZmZmZmVUxMDQo+ID4gPiA+
DQo+ID4gPiA+ICAgICAgICAgdTMyIHRtcF9yZW07DQo+ID4gPiA+ICAgICAgICAgdTY0IG5zX3Vf
cmVtLCBuc191LCBuc19sLCBuc19sX2NhcnJ5Ow0KPiA+ID4gPiAgICAgICAgIHU2NCBjeWNsZTsN
Cj4gPiA+ID4NCj4gPiA+ID4gICAgICAgICBuc191ID0gbnMgPj4gMzI7DQo+ID4gPiA+ICAgICAg
ICAgbnNfbCA9IG5zICYgVTY0X0xPV19NQVNLOw0KPiA+ID4gPg0KPiA+ID4gPiAgICAgICAgIG5z
X2wgKj0gdGJfdGlja3NfcGVyX3VzZWM7DQo+ID4gPiA+ICAgICAgICAgbnNfbF9jYXJyeSA9IG5z
X2wgPj4gMzI7DQo+ID4gPiA+ICAgICAgICAgbnNfdSAqPSB0Yl90aWNrc19wZXJfdXNlYzsNCj4g
PiA+ID4gICAgICAgICBuc191ICs9IG5zX2xfY2Fycnk7DQo+ID4gPiA+DQo+ID4gPiA+ICAgICAg
ICAgbnNfdSA9IGRpdl91NjRfcmVtKG5zX3UsIDEwMDAsICZ0bXBfcmVtKTsNCj4gPiA+ID4gICAg
ICAgICBuc191X3JlbSA9IHRtcF9yZW07DQo+ID4gPiA+ICAgICAgICAgbnNfbCA9IChuc19sICYg
VTY0X0xPV19NQVNLKSB8ICgobnNfdV9yZW0pIDw8IDMyKTsNCj4gPiA+ID4gICAgICAgICBuc19s
ID0gZGl2X3U2NChuc19sLCAxMDAwKTsNCj4gPiA+ID4NCj4gPiA+ID4gICAgICAgICBpZiAobnNf
dSA+PiAzMikNCj4gPiA+ID4gICAgICAgICAgICAgICAgIGN5Y2xlID0gVTY0X01BU0s7DQo+ID4g
PiA+ICAgICAgICAgZWxzZQ0KPiA+ID4gPiAgICAgICAgICAgICAgICAgY3ljbGUgPSAobnNfdSA8
PCAzMikgfCAobnNfbCAmIFU2NF9MT1dfTUFTSyk7DQo+ID4gPiA+DQo+ID4gPiA+IEkgaGFzIGFs
cmVhZHkgdGVzdGVkIHRoaXMgY29kZSwgYW5kIHdvcmtzIGdvb2QuIDopDQo+ID4gPg0KPiA+ID4g
VWdoLiAgSSBkb24ndCB0aGluayB3ZSBuZWVkIHRvIGdldCB0aGlzIGNvbXBsaWNhdGVkIChhbmQg
SSdkIHJhdGhlcg0KPiBub3QNCj4gPiA+IHNwZW5kIHRoZSB0aW1lIHZlcmlmeWluZyB0aGUgY29y
cmVjdG5lc3Mgb2YgdGhpcykuDQo+ID4gPg0KPiA+ID4gSWYgZm9yIHNvbWUgcmVhc29uIHdlIGRp
ZCBuZWVkIHNvbWV0aGluZyBsaWtlIHRoaXMgaW4gc29tZSBvdGhlcg0KPiBjb250ZXh0DQo+ID4g
PiAoSSBkb24ndCB3YW50IHRvIHNlZSBpdCBqdXN0IGZvciBwdzIwKSwgSSdkIGJlIG1vcmUgaW5j
bGluZWQgdG8gc2VlDQo+ID4gPiBnZW5lcmFsIDEyOC1iaXQgbXVsdC9kaXZpZGUgc3VwcG9ydC4N
Cj4gPiA+DQo+ID4gSSB3b3VsZCBsaWtlIHRvIHVzZSBteSB2ZXJzaW9uLDopLCBiZWNhdXNlIGl0
IGNhbiBoYW5kbGUgYW55IHNpdHVhdGlvbg0KPiBhbmQgd2UgZG8gbm90IG5lZWQgdG8gcmVzdHJp
Y3QgdXNlcnMuDQo+IA0KPiBJdCBhbHNvIHdvdWxkIHRha2UgbW9yZSB0aW1lIHRvIHJldmlldyB0
aGFuIEkgaGF2ZSB0byBzcGVuZCBvbiBpdCwgbm90DQo+IHRvIG1lbnRpb24gdGhlIGltcGFjdCBv
biBhbnlvbmUgaW4gdGhlIGZ1dHVyZSB0aGF0IHdhbnRzIHRvIHVuZGVyc3RhbmQNCj4gb3IgbWFp
bnRhaW4gdGhpcyBjb2RlIC0tIGFsbCBmb3IgdmVyeSB1bmxpa2VseSBzaXR1YXRpb25zIChhbmQg
dGhlDQo+ICJmYWlsdXJlIiBpbiB0aG9zZSB2ZXJ5IHVubGlrZWx5IHNpdHVhdGlvbnMgaXMganVz
dCB0aGF0IHdlIGdvIGludG8gUFcyMA0KPiBtb3JlIG9mdGVuIHRoYW4gaW50ZW5kZWQpLg0KPiAN
Ck9LLCBJIHdpbGwgdXNlIHlvdXIgdmVyaXNvbiwgOikNCg0KICAgICAgICBpZiAobnMgPj0gMTAw
MDApDQogICAgICAgICAgICAgICAgY3ljbGUgPSAoKG5zICsgNTAwKSAvIDEwMDApICogdGJfdGlj
a3NfcGVyX3VzZWM7DQogICAgICAgIGVsc2UNCiAgICAgICAgICAgICAgICBjeWNsZSA9IGRpdl91
NjQoKHU2NClucyAqIHRiX3RpY2tzX3Blcl91c2VjLCAxMDAwKTsNCg0KLWRvbmdzaGVuZw0KDQo+
IC1TY290dA0KPiANCg0K
