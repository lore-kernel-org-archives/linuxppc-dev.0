Return-Path: <Shaohui.Xie@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0117.outbound.protection.outlook.com [157.56.110.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9208C1A0D81
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2015 14:36:46 +1100 (AEDT)
From: Shaohui Xie <Shaohui.Xie@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH][v4] power/fsl: add MDIO dt binding for FMan
Date: Fri, 30 Jan 2015 03:04:03 +0000
Message-ID: <DM2PR0301MB0864C4D65559673487B9267DE2310@DM2PR0301MB0864.namprd03.prod.outlook.com>
References: <1422446064-3901-1-git-send-email-shh.xie@gmail.com>
 <1422579249.10544.140.camel@freescale.com>
 <DM2PR0301MB0864EF866EFDEB634BED54E5E2310@DM2PR0301MB0864.namprd03.prod.outlook.com>
 <1422585820.10544.146.camel@freescale.com>
In-Reply-To: <1422585820.10544.146.camel@freescale.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Emilian Medve <Emilian.Medve@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBXb29kIFNjb3R0LUIwNzQyMQ0K
PiBTZW50OiBGcmlkYXksIEphbnVhcnkgMzAsIDIwMTUgMTA6NDQgQU0NCj4gVG86IFhpZSBTaGFv
aHVpLUIyMTk4OQ0KPiBDYzogbGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmc7IGRldmljZXRy
ZWVAdmdlci5rZXJuZWwub3JnOyBNZWR2ZQ0KPiBFbWlsaWFuLUVNTUVEVkUxDQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0hdW3Y0XSBwb3dlci9mc2w6IGFkZCBNRElPIGR0IGJpbmRpbmcgZm9yIEZNYW4N
Cj4gDQo+IE9uIFRodSwgMjAxNS0wMS0yOSBhdCAyMDozOCAtMDYwMCwgWGllIFNoYW9odWktQjIx
OTg5IHdyb3RlOg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206
IFdvb2QgU2NvdHQtQjA3NDIxDQo+ID4gPiBTZW50OiBGcmlkYXksIEphbnVhcnkgMzAsIDIwMTUg
ODo1NCBBTQ0KPiA+ID4gVG86IHNoaC54aWVAZ21haWwuY29tDQo+ID4gPiBDYzogbGludXhwcGMt
ZGV2QGxpc3RzLm96bGFicy5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBNZWR2ZQ0K
PiA+ID4gRW1pbGlhbi1FTU1FRFZFMTsgWGllIFNoYW9odWktQjIxOTg5DQo+ID4gPiBTdWJqZWN0
OiBSZTogW1BBVENIXVt2NF0gcG93ZXIvZnNsOiBhZGQgTURJTyBkdCBiaW5kaW5nIGZvciBGTWFu
DQo+ID4gPg0KPiA+ID4gT24gV2VkLCAyMDE1LTAxLTI4IGF0IDE5OjU0ICswODAwLCBzaGgueGll
QGdtYWlsLmNvbSB3cm90ZToNCj4gPiA+ID4gKy0gaW50ZXJydXB0cw0KPiA+ID4gPiArCQlVc2Fn
ZTogcmVxdWlyZWQNCj4gPiA+ID4gKwkJVmFsdWUgdHlwZTogPHByb3AtZW5jb2RlZC1hcnJheT4N
Cj4gPiA+ID4gKwkJRGVmaW5pdGlvbjogRXZlbnQgaW50ZXJydXB0IG9mIGV4dGVybmFsIE1ESU8g
Y29udHJvbGxlci4NCj4gPiA+DQo+ID4gPiBXaGF0IGlmIHRoaXMgTURJTyBjb250cm9sbGVyIGlz
IG5vdCAiZXh0ZXJuYWwiPyAgU2hvdWxkIFVzYWdlIHNheQ0KPiA+ID4gInJlcXVpcmVkIGZvciBl
eHRlcm5hbCBNRElPIj8NCj4gPiBbUy5IXSBJIHRob3VnaHQgdGhlIGRlZmluaXRpb24gY2FuIHRl
bGwgdGhlIGludGVycnVwdCBpcyBmb3IgZXh0ZXJuYWwNCj4gPiBNRElPLCBJIGNhbiBjaGFuZ2Ug
dGhlIFVzYWdlIHRvICJyZXF1aXJlZCBmb3IgZXh0ZXJuYWwgTURJTyIgaW4gbmV4dA0KPiB2ZXJz
aW9uLg0KPiA+IGhvdyBhYm91dCBvdGhlciBwYXJ0cywgYXJlIHRoZXkgT0s/DQo+IA0KPiBZZXMu
ICBJJ2xsIGZpeCBpdCB1cCB3aGVuIGFwcGx5aW5nLg0KDQpUaGFuayB5b3UhDQoNClNoYW9odWkN
Cg0K
