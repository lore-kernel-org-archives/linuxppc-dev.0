Return-Path: <Lijun.Pan@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9CAB31A0021
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2015 03:04:46 +1000 (AEST)
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0132.outbound.protection.outlook.com [65.55.169.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 49AFF1402F5
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2015 03:04:44 +1000 (AEST)
From: Lijun Pan <Lijun.Pan@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: new way of writing defconfigs for freescale's powerpc platforms
Date: Thu, 16 Apr 2015 17:04:39 +0000
Message-ID: <DM2PR03MB36891C0386416E91A15E323FCE40@DM2PR03MB368.namprd03.prod.outlook.com>
References: <DM2PR03MB3689ECA6BC27B156BD10F76FCFB0@DM2PR03MB368.namprd03.prod.outlook.com>
 <1428618671.22867.551.camel@freescale.com>
In-Reply-To: <1428618671.22867.551.camel@freescale.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Richard Schmitt <richard.schmitt@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29vZCBTY290dC1CMDc0
MjENCj4gU2VudDogVGh1cnNkYXksIEFwcmlsIDA5LCAyMDE1IDU6MzEgUE0NCj4gVG86IFBhbiBM
aWp1bi1CNDQzMDYNCj4gQ2M6IGxpbnV4cHBjLWRldkBvemxhYnMub3JnOyBTY2htaXR0IFJpY2hh
cmQtQjQzMDgyDQo+IFN1YmplY3Q6IFJlOiBuZXcgd2F5IG9mIHdyaXRpbmcgZGVmY29uZmlncyBm
b3IgZnJlZXNjYWxlJ3MgcG93ZXJwYyBwbGF0Zm9ybXMNCj4gDQo+IE9uIFRodSwgMjAxNS0wNC0w
OSBhdCAxNjo1MiAtMDUwMCwgUGFuIExpanVuLUI0NDMwNiB3cm90ZToNCj4gPiBIaSBNYWludGFp
bmVycywNCj4gPg0KPiA+IFdlIGhhdmUgYSBwcm9wb3NhbCBmb3Igd3JpdGluZyB0aGUgZGVmY29u
ZmlncyBmb3IgZnJlZXNjYWxlJ3MgcG93cGVycGMNCj4gcGxhdGZvcm1zIGluIGEgbmV3IHdheS4N
Cj4gPiBDYW4geW91IHRha2UgYSBsb29rIGFuZCBwcm92aWRlIHNvbWUgZmVlZGJhY2s/DQo+ID4N
Cj4gPiBZb3Uga25vdyBjdXJyZW50bHkgd2UgaGF2ZSBtcGM4NXh4X2RlZmNvbmZpZywgY29yZW5l
dDMyX2RlZmNvbmZpZywNCj4gYnNjOTEzeF9kZWZjb25maWcsICpmbWFuKl9kZWZjb25maWcsIGV0
Yy4NCj4gPiBXZSBhcmUgZ29pbmcgdG8gZXh0cmFjdCBzb21lIGNvbW1vbiBwYXJ0cyBmcm9tIHRo
ZSBleGlzdGluZyBkZWZjb25maWdzLA0KPiBhbmQgbmFtZSBpdCwgc2F5LCBmc2xfYmFzaWNfZGVm
Y29uZmlnLg0KPiA+IFRoZW4sIHdlIGNvdWxkIGNyZWF0ZSBzb21lIGRlZmNvbmZpZ3MgdGFyZ2V0
aW5nIHNwZWNpZmljIGZlYXR1cmVzIG9yIHNwZWNpZmljDQo+IHBsYXRmb3Jtcy4NCj4gPiBTYXks
IGZlYXR1cmVzIHNwZWNpZmljOiBrdm1fZGVmY29uZmlnLCBmbWFuX2RlZmNvbmZpZywgZXRjLg0K
PiA+IFBsYXRmb3JtcyBzcGVjaWZpYzogcDFfZGVmY29uZmlnLCBwMl9kZWZjb25nZmlnLCBwNF9k
ZWZjb25maWcsDQo+ID4gdDFfZGVmY29uZmlnLCB0Ml9kZWZjb25maWcsIHQyX2RlZmNvbmZpZywg
YjRfZGVmY29uZmlnLCBldGMgV2hlbiB3ZQ0KPiA+IHdhbnQgdG8gbWFrZSBhIGtlcm5lbCBpbWFn
ZSBmb3IgcDEgcGxhdGZvcm0sIFVzaW5nIHRoZSBmb2xsb3dpbmcgc3RlcHM6DQo+ID4NCj4gPiBt
YWtlIC4vc2NyaXB0cy9rY29uZmlnL21lcmdlX2NvbmZpZy5zaA0KPiA+IGFyY2gvcG93ZXJwYy9j
b25maWdzL2ZzbF9iYXNpY19jb25maWcgcDFfZGVmY29uZmlnIG1ha2UNCj4gPg0KPiA+IFdoYXQg
ZG8geW91IHRoaW5rIG9mIHRoaXMgbmV3IGFwcHJvYWNoPw0KPiA+IFdpbGwgeW91IGFjY2VwdCB0
aGlzIGFwcHJvYWNoPw0KPiANCj4gSSdtIE9LIHdpdGggYSBtZXJnZV9jb25maWcgYXBwcm9hY2gu
DQo+IA0KPiBJJ20gbm90IE9LIHdpdGggaGF2aW5nIHNlcGFyYXRlIGJ1aWxkcyBmb3IgcDEvcDIv
cDQvdDEvdDIvYjQuDQoNCklmIHdlIGRvbid0IGhhdmUgc2VwYXJhdGUgYnVpbGQgZm9yIHAxL3Ay
L3A0L3QxL3QyL2I0LCBpbiB3aGF0IHdheSBkbyB3ZQ0KYnVpbGQgZm9yIHRoZXNlIFNvQyB3aXRo
IG1lcmdlX2NvbmZpZyBhcHByb2FjaD8gRG8geW91IGhhdmUgYW55IHN1Z2dlc3Rpb25zPyANCg0K
PiANCj4gLVNjb3R0DQo+IA0KDQo=
