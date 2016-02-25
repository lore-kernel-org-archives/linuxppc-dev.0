Return-Path: <qiang.zhao@nxp.com>
Received: from emea01-db3-obe.outbound.protection.outlook.com
 (mail-db3on0082.outbound.protection.outlook.com [157.55.234.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D51951A03ED
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 16:43:58 +1100 (AEDT)
From: Qiang Zhao <qiang.zhao@nxp.com>
To: Scott Wood <oss@buserror.net>, Rob Herring <robh@kernel.org>
CC: Yang-Leo Li <leoyang.li@nxp.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH v2 1/7] QE: Add IC, SI and SIRAM document to device tree
 bindings.
Date: Thu, 25 Feb 2016 03:10:26 +0000
Message-ID: <AM3PR04MB1185D9D56F72F7AD64AC92E291A60@AM3PR04MB1185.eurprd04.prod.outlook.com>
References: <1455757572-44955-1-git-send-email-qiang.zhao@nxp.com>
 <20160223201520.GA3354@rob-hp-laptop>
 <1456258812.5360.22.camel@buserror.net>
In-Reply-To: <1456258812.5360.22.camel@buserror.net>
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

T24gV2VkLCAyMDE2LTAyLTI0IGF0IDA0OjIwICBBTSwgU2NvdHQgV29vZCB3cm90ZToNCj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2NvdHQgV29vZCBbbWFpbHRvOm9zc0Bi
dXNlcnJvci5uZXRdDQo+IFNlbnQ6IFdlZG5lc2RheSwgRmVicnVhcnkgMjQsIDIwMTYgNDoyMCBB
TQ0KPiBUbzogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47IFFpYW5nIFpoYW8gPHFpYW5n
LnpoYW9AbnhwLmNvbT4NCj4gQ2M6IFlhbmctTGVvIExpIDxsZW95YW5nLmxpQG54cC5jb20+OyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
ZzsgbGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2
MiAxLzddIFFFOiBBZGQgSUMsIFNJIGFuZCBTSVJBTSBkb2N1bWVudCB0byBkZXZpY2UgdHJlZQ0K
PiBiaW5kaW5ncy4NCj4gDQo+IE9uIFR1ZSwgMjAxNi0wMi0yMyBhdCAxNDoxNSAtMDYwMCwgUm9i
IEhlcnJpbmcgd3JvdGU6DQo+ID4gT24gVGh1LCBGZWIgMTgsIDIwMTYgYXQgMDk6MDY6MDZBTSAr
MDgwMCwgWmhhbyBRaWFuZyB3cm90ZToNCj4gPiA+IEFkZCBJQywgU0kgYW5kIFNJUkFNIGRvY3Vt
ZW50IG9mIFFFIHRvDQo+ID4gPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcG93
ZXJwYy9mc2wvY3BtX3FlL3FlLnR4dA0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFpoYW8g
UWlhbmcgPHFpYW5nLnpoYW9AbnhwLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gQ2hhbmdlcyBmb3Ig
djINCj4gPiA+IAktIEFkZCBpbnRlcnJ1cHQtY29udHJvbGxlciBpbiBSZXF1aXJlZCBwcm9wZXJ0
aWVzDQo+ID4gPiAJLSBkZWxldGUgYWRkcmVzcy1jZWxscyBhbmQgc2l6ZS1jZWxscyBmb3IgcWUt
c2kgYW5kIHFlLXNpcmFtDQo+ID4gPg0KPiA+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bv
d2VycGMvZnNsL2NwbV9xZS9xZS50eHQgIHwgNTANCj4gPiA+ICsrKysrKysrKysrKysrKysrKysr
KysNCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNTAgaW5zZXJ0aW9ucygrKQ0KPiA+ID4NCj4gPiA+
IGRpZmYgLS1naXQNCj4gPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bv
d2VycGMvZnNsL2NwbV9xZS9xZS50eHQNCj4gPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3Bvd2VycGMvZnNsL2NwbV9xZS9xZS50eHQNCj4gPiA+IGluZGV4IDRmODkzMDIu
Ljg0MDUyYTcgMTAwNjQ0DQo+ID4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvcG93ZXJwYy9mc2wvY3BtX3FlL3FlLnR4dA0KPiA+ID4gKysrIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bvd2VycGMvZnNsL2NwbV9xZS9xZS50eHQNCj4gPiA+IEBA
IC02OSw2ICs2OSw1NiBAQCBFeGFtcGxlOg0KPiA+ID4gIAl9Ow0KPiA+ID4gICAgICAgfTsNCj4g
PiA+DQo+ID4gPiArKiBJbnRlcnJ1cHQgQ29udHJvbGxlciAoSUMpDQo+ID4gPiArDQo+ID4gPiAr
UmVxdWlyZWQgcHJvcGVydGllczoNCj4gPiA+ICstIGNvbXBhdGlibGUgOiBzaG91bGQgYmUgImZz
bCxxZS1pYyIuDQo+ID4NCj4gPiA+ICstIGNvbXBhdGlibGUgOiBzaG91bGQgYmUgImZzbCxxZS1z
aSIuDQo+ID4NCj4gPiA+ICstIGNvbXBhdGlibGUgOiBzaG91bGQgYmUgImZzbCxxZS1zaXJhbSIu
DQo+ID4NCj4gPiBUaGVzZSBjb21wYXRpYmxlIHN0cmluZ3MgYXJlIGFsbCBhIGJpdCBnZW5lcmlj
IGFuZCBzaG91bGQgaGF2ZSBTb0MNCj4gPiBzcGVjaWZpYyBjb21wYXRpYmxlIHN0cmluZ3MuDQo+
IA0KPiBJIGRvbid0IGtub3cgYWJvdXQgc2kvc2lyYW0sIGJ1dCAiZnNsLHFlLWljIiBoYXMgYmVl
biBhcm91bmQgc2luY2UgMjAwOCwgc28gaXQNCj4gc2hvdWxkIGJlIGRvY3VtZW50ZWQgZXZlbiBp
ZiBhIG1vcmUgc3BlY2lmaWMgY29tcGF0aWJsZSBpcyBhbHNvIGFkZGVkLg0KDQpBZ3JlZSwgYW5k
IHNpL3NpcmFtIGFyZSBhbHNvIGhhcyBiZWVuIGFyb3VuZCBzaW5jZSAyMDA4Lg0KSW4gYWRkaXRp
b24sIEkgZG9u4oCZdCB0aGluayBpdCBpcyBuZWVkZWQgdG8gYWRkIHNwZWNpZmljIGNvbXBhdGli
bGUsIGJlY2F1c2UgdGhleSBhcmUNCnRoZSBzYW1lIGluIHFlLXN1cHBvcnRlZCBzb2MuDQoNCkJS
DQotWmhhbw0K
