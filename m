Return-Path: <B48286@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0123.outbound.protection.outlook.com [207.46.100.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9DB9C1A2D09
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2015 20:04:01 +1000 (AEST)
From: Hou Zhiqiang <B48286@freescale.com>
To: Scott Wood <scottwood@freescale.com>
CC: "galak@kernel.crashing.org" <galak@kernel.crashing.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Hu Vincent
 <Mingkai.Hu@freescale.com>, Wang Dongsheng <Dongsheng.Wang@freescale.com>
Subject: RE: [PATCH] c293/pci: remove hook pcibios_fixup_phb
Date: Mon, 10 Aug 2015 09:49:12 +0000
Message-ID: <CY1PR0301MB0780A3D16B0BF3A45CF638C98B700@CY1PR0301MB0780.namprd03.prod.outlook.com>
References: <1437473400-11184-1-git-send-email-B48286@freescale.com>
 <CY1PR0301MB0780F0F41541CBFC5B5998018B8A0@CY1PR0301MB0780.namprd03.prod.outlook.com>
 <1438363461.19345.18.camel@freescale.com>
In-Reply-To: <1438363461.19345.18.camel@freescale.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29vZCBTY290dC1CMDc0
MjENCj4gU2VudDogMjAxNeW5tDjmnIgx5pelIDE6MjQNCj4gVG86IEhvdSBaaGlxaWFuZy1CNDgy
ODYNCj4gQ2M6IGdhbGFrQGtlcm5lbC5jcmFzaGluZy5vcmc7IGxpbnV4cHBjLWRldkBsaXN0cy5v
emxhYnMub3JnOyBIdSBNaW5na2FpLQ0KPiBCMjEyODQ7IFdhbmcgRG9uZ3NoZW5nLUI0MDUzNA0K
PiBTdWJqZWN0OiBSZTogW1BBVENIXSBjMjkzL3BjaTogcmVtb3ZlIGhvb2sgcGNpYmlvc19maXh1
cF9waGINCj4gDQo+IE9uIEZyaSwgMjAxNS0wNy0zMSBhdCAwNTo1OSAtMDUwMCwgSG91IFpoaXFp
YW5nLUI0ODI4NiB3cm90ZToNCj4gPiBIaSBEb25nc2hlbmcgYW5kIFNjb3R0LA0KPiA+DQo+ID4g
RG8geW91IGhhdmUgYW55IGNvbW1lbnQ/DQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+ID4gPiBGcm9tOiBaaGlxaWFuZyBIb3UgW21haWx0bzpCNDgyODZAZnJlZXNjYWxl
LmNvbV0NCj4gPiA+IFNlbnQ6IDIwMTXlubQ35pyIMjHml6UgMTg6MTANCj4gPiA+IFRvOiBnYWxh
a0BrZXJuZWwuY3Jhc2hpbmcub3JnOyBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZw0KPiA+
ID4gQ2M6IEh1IE1pbmdrYWktQjIxMjg0OyBXYW5nIERvbmdzaGVuZy1CNDA1MzQ7IEhvdSBaaGlx
aWFuZy1CNDgyODYNCj4gPiA+IFN1YmplY3Q6IFtQQVRDSF0gYzI5My9wY2k6IHJlbW92ZSBob29r
IHBjaWJpb3NfZml4dXBfcGhiDQo+ID4gPg0KPiA+ID4gRnJvbTogSG91IFpoaXFpYW5nIDxCNDgy
ODZAZnJlZXNjYWxlLmNvbT4NCj4gPiA+DQo+ID4gPiBUaGUgYzI5M3BjaWUgYm9hcmQgaXMgYW4g
ZW5kcG9pbnQgZGV2aWNlLCBhbmQgaXQgZG9lcyd0IG5lZWQgUE0uDQo+ID4gPg0KPiA+ID4gU2ln
bmVkLW9mZi1ieTogSG91IFpoaXFpYW5nIDxCNDgyODZAZnJlZXNjYWxlLmNvbT4NCj4gPiA+IC0t
LQ0KPiA+ID4gIGFyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvODV4eC9jMjkzcGNpZS5jIHwgMSAtDQo+
ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkNCj4gPiA+DQo+ID4gPiBkaWZmIC0t
Z2l0IGEvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy84NXh4L2MyOTNwY2llLmMNCj4gPiA+IGIvYXJj
aC9wb3dlcnBjL3BsYXRmb3Jtcy84NXh4L2MyOTNwY2llLmMNCj4gPiA+IGluZGV4IDg0NDc2YjYu
LjIxM2Q1YjggMTAwNjQ0DQo+ID4gPiAtLS0gYS9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zLzg1eHgv
YzI5M3BjaWUuYw0KPiA+ID4gKysrIGIvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy84NXh4L2MyOTNw
Y2llLmMNCj4gPiA+IEBAIC02OCw3ICs2OCw2IEBAIGRlZmluZV9tYWNoaW5lKGMyOTNfcGNpZSkg
ew0KPiA+ID4gICAgIC5pbml0X0lSUSAgICAgICAgICAgICAgID0gYzI5M19wY2llX3BpY19pbml0
LA0KPiA+ID4gICNpZmRlZiBDT05GSUdfUENJDQo+ID4gPiAgICAgLnBjaWJpb3NfZml4dXBfYnVz
ICAgICAgPSBmc2xfcGNpYmlvc19maXh1cF9idXMsDQo+ID4gPiAtICAgLnBjaWJpb3NfZml4dXBf
cGhiICAgICAgPSBmc2xfcGNpYmlvc19maXh1cF9waGIsDQo+ID4gPiAgI2VuZGlmDQo+ID4gPiAg
ICAgLmdldF9pcnEgICAgICAgICAgICAgICAgPSBtcGljX2dldF9pcnEsDQo+ID4gPiAgICAgLnJl
c3RhcnQgICAgICAgICAgICAgICAgPSBmc2xfcnN0Y3JfcmVzdGFydCwNCj4gDQo+IElmIHRoaXMg
aXMgYW4gZW5kcG9pbnQgd2h5IGRvIHlvdSBuZWVkIHBjaWJpb3NfZml4dXBfYnVzPw0KPiANCg0K
VGhhbmtzIGFuZCB5ZXMsIGl0IGlzbid0IHVzZWQgaW4gZW5kcG9pbnQgbW9kZS4NClJlbW92ZWQg
aXQgaW4gcGF0Y2ggdmVyc2lvbiAyLg0KDQo+IC1TY290dA0KDQpUaGFua3MsDQpaaGlxaWFuZw0K
