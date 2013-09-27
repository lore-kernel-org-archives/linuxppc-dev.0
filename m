Return-Path: <B36685@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B8EC72C0087
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 12:51:56 +1000 (EST)
From: Liu Shengzhou-B36685 <B36685@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH] powerpc/fsl/defconfig: enable CONFIG_AT803X_PHY
Date: Fri, 27 Sep 2013 02:51:48 +0000
Message-ID: <3F453DDFF675A64A89321A1F35281021AE0312@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1378196906-9850-1-git-send-email-Shengzhou.Liu@freescale.com>
 <1380158651.24959.239.camel@snotra.buserror.net>
 <3F453DDFF675A64A89321A1F35281021ADFACA@039-SN1MPN1-003.039d.mgd.msft.net>
 <1380229898.24959.318.camel@snotra.buserror.net>
In-Reply-To: <1380229898.24959.318.camel@snotra.buserror.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFdvb2QgU2NvdHQtQjA3NDIx
DQo+IFNlbnQ6IEZyaWRheSwgU2VwdGVtYmVyIDI3LCAyMDEzIDU6MTIgQU0NCj4gVG86IExpdSBT
aGVuZ3pob3UtQjM2Njg1DQo+IENjOiBXb29kIFNjb3R0LUIwNzQyMTsgbGludXhwcGMtZGV2QGxp
c3RzLm96bGFicy5vcmc7IGdhbGFrQGtlcm5lbC5jcmFzaGluZy5vcmcNCj4gU3ViamVjdDogUmU6
IFtQQVRDSF0gcG93ZXJwYy9mc2wvZGVmY29uZmlnOiBlbmFibGUgQ09ORklHX0FUODAzWF9QSFkN
Cj4gDQo+IE9uIFdlZCwgMjAxMy0wOS0yNSBhdCAyMjowMiAtMDUwMCwgTGl1IFNoZW5nemhvdS1C
MzY2ODUgd3JvdGU6DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJv
bTogV29vZCBTY290dC1CMDc0MjENCj4gPiA+IFNlbnQ6IFRodXJzZGF5LCBTZXB0ZW1iZXIgMjYs
IDIwMTMgOToyNCBBTQ0KPiA+ID4gVG86IExpdSBTaGVuZ3pob3UtQjM2Njg1DQo+ID4gPiBDYzog
bGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmc7IGdhbGFrQGtlcm5lbC5jcmFzaGluZy5vcmcN
Cj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHBvd2VycGMvZnNsL2RlZmNvbmZpZzogZW5hYmxl
IENPTkZJR19BVDgwM1hfUEhZDQo+ID4gPg0KPiA+ID4gT24gVHVlLCAyMDEzLTA5LTAzIGF0IDE2
OjI4ICswODAwLCBTaGVuZ3pob3UgTGl1IHdyb3RlOg0KPiA+ID4gPiBFbmFibGUgQ09ORklHX0FU
ODAzWF9QSFkgdG8gc3VwcG9ydCBBUjgwMzAvODAzMy84MDM1IFBIWS4NCj4gPiA+ID4NCj4gPiA+
ID4gU2lnbmVkLW9mZi1ieTogU2hlbmd6aG91IExpdSA8U2hlbmd6aG91LkxpdUBmcmVlc2NhbGUu
Y29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIGFyY2gvcG93ZXJwYy9jb25maWdzL2NvcmVuZXQz
Ml9zbXBfZGVmY29uZmlnIHwgICAgMSArDQo+ID4gPiA+ICBhcmNoL3Bvd2VycGMvY29uZmlncy9t
cGM4NXh4X2RlZmNvbmZpZyAgICAgICB8ICAgIDEgKw0KPiA+ID4gPiAgYXJjaC9wb3dlcnBjL2Nv
bmZpZ3MvbXBjODV4eF9zbXBfZGVmY29uZmlnICAgfCAgICAxICsNCj4gPiA+ID4gIDMgZmlsZXMg
Y2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQ0KPiA+ID4NCj4gPiA+IFdo
eSBub3QgY29yZW5ldDY0X3NtcF9kZWZjb25maWc/ICBXaGljaCBib2FyZHMgaGF2ZSB0aGlzIFBI
WT8NCj4gPiA+DQo+ID4gPiAtU2NvdHQNCj4gPiA+DQo+ID4gQ3VycmVudGx5IEFUODAzWCBleGlz
dHMgb24gUDEwMTBSREIsIFAxMDI1VFdSLCBldGMuDQo+ID4gSXQgc2VlbXMgd2UgZG9uJ3QgdXNl
IEFUODAzWCBmb3IgdGhvc2UgYm9hcmRzIG9mIGNvcmVuZXQ2NC4NCj4gDQo+IE5laXRoZXIgb2Yg
dGhvc2UgYm9hcmRzIGFyZSBjb3JlbmV0MzIgZWl0aGVyLg0KPiANCkdlbmVyYWxseSwgd2UgdXNl
IEFUODAzWCBhcyBsb3ctY29zdCBzb2x1dGlvbiwgaXQncyBwb3NzaWJsZSB0byB1c2UgaXQgb24g
UDEvUDIvUDMgc2VyaWFsLCBjb3JlbmV0NjQgaXMgZm9yIGhpZ2gtZW5kIGNhc2UsIHRoYXQncyB3
aHkgSSBkaWRuJ3QgZW5hYmxlIGl0IGZvciBjb3JlbmV0NjQuDQotU2hlbmd6aG91DQo=
