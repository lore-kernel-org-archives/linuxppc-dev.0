Return-Path: <nipun.gupta@nxp.com>
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr20059.outbound.protection.outlook.com [40.107.2.59])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41MYg54bHfzDr02
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jul 2018 22:18:57 +1000 (AEST)
From: Nipun Gupta <nipun.gupta@nxp.com>
To: Robin Murphy <robin.murphy@arm.com>, "will.deacon@arm.com"
 <will.deacon@arm.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Laurentiu Tudor
 <laurentiu.tudor@nxp.com>, "bhelgaas@google.com" <bhelgaas@google.com>
CC: "hch@lst.de" <hch@lst.de>, "joro@8bytes.org" <joro@8bytes.org>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "shawnguo@kernel.org"
 <shawnguo@kernel.org>, "frowand.list@gmail.com" <frowand.list@gmail.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, Bharat Bhushan <bharat.bhushan@nxp.com>,
 "stuyoder@gmail.com" <stuyoder@gmail.com>, Leo Li <leoyang.li@nxp.com>
Subject: RE: [PATCH 7/7 v5] arm64: dts: ls208xa: comply with the iommu map
 binding for fsl_mc
Date: Fri, 6 Jul 2018 12:18:49 +0000
Message-ID: <HE1PR0401MB2425F914BA7A9DDCB3D76AEDE6470@HE1PR0401MB2425.eurprd04.prod.outlook.com>
References: <1526824191-7000-1-git-send-email-nipun.gupta@nxp.com>
 <1526824191-7000-8-git-send-email-nipun.gupta@nxp.com>
 <88626adc-6f5b-86df-88a0-620d258f8053@arm.com>
In-Reply-To: <88626adc-6f5b-86df-88a0-620d258f8053@arm.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iaW4gTXVycGh5IFtt
YWlsdG86cm9iaW4ubXVycGh5QGFybS5jb21dDQo+IFNlbnQ6IFR1ZXNkYXksIEp1bHkgMywgMjAx
OCAxMDowNiBQTQ0KPiBUbzogTmlwdW4gR3VwdGEgPG5pcHVuLmd1cHRhQG54cC5jb20+OyB3aWxs
LmRlYWNvbkBhcm0uY29tOw0KPiByb2JoK2R0QGtlcm5lbC5vcmc7IHJvYmhAa2VybmVsLm9yZzsg
bWFyay5ydXRsYW5kQGFybS5jb207DQo+IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOyBncmVna2hA
bGludXhmb3VuZGF0aW9uLm9yZzsgTGF1cmVudGl1IFR1ZG9yDQo+IDxsYXVyZW50aXUudHVkb3JA
bnhwLmNvbT47IGJoZWxnYWFzQGdvb2dsZS5jb20NCj4gQ2M6IGhjaEBsc3QuZGU7IGpvcm9AOGJ5
dGVzLm9yZzsgbS5zenlwcm93c2tpQHNhbXN1bmcuY29tOw0KPiBzaGF3bmd1b0BrZXJuZWwub3Jn
OyBmcm93YW5kLmxpc3RAZ21haWwuY29tOyBpb21tdUBsaXN0cy5saW51eC0NCj4gZm91bmRhdGlv
bi5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJu
ZWwub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4cHBj
LWRldkBsaXN0cy5vemxhYnMub3JnOyBsaW51eC0NCj4gcGNpQHZnZXIua2VybmVsLm9yZzsgQmhh
cmF0IEJodXNoYW4gPGJoYXJhdC5iaHVzaGFuQG54cC5jb20+Ow0KPiBzdHV5b2RlckBnbWFpbC5j
b207IExlbyBMaSA8bGVveWFuZy5saUBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDcv
NyB2NV0gYXJtNjQ6IGR0czogbHMyMDh4YTogY29tcGx5IHdpdGggdGhlIGlvbW11IG1hcA0KPiBi
aW5kaW5nIGZvciBmc2xfbWMNCj4gDQo+IE9uIDIwLzA1LzE4IDE0OjQ5LCBOaXB1biBHdXB0YSB3
cm90ZToNCj4gPiBmc2wtbWMgYnVzIHN1cHBvcnQgdGhlIG5ldyBpb21tdS1tYXAgcHJvcGVydHku
IENvbXBseSB0byB0aGlzIGJpbmRpbmcNCj4gPiBmb3IgZnNsX21jIGJ1cy4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IE5pcHVuIEd1cHRhIDxuaXB1bi5ndXB0YUBueHAuY29tPg0KPiA+IFJldmll
d2VkLWJ5OiBMYXVyZW50aXUgVHVkb3IgPGxhdXJlbnRpdS50dWRvckBueHAuY29tPg0KPiA+IC0t
LQ0KPiA+ICAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMjA4eGEuZHRzaSB8
IDYgKysrKystDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2Nh
bGUvZnNsLWxzMjA4eGEuZHRzaQ0KPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2Zz
bC1sczIwOHhhLmR0c2kNCj4gPiBpbmRleCAxMzdlZjRkLi42MDEwNTA1IDEwMDY0NA0KPiA+IC0t
LSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczIwOHhhLmR0c2kNCj4gPiAr
KysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMyMDh4YS5kdHNpDQo+ID4g
QEAgLTE4NCw2ICsxODQsNyBAQA0KPiA+ICAgCQkjYWRkcmVzcy1jZWxscyA9IDwyPjsNCj4gPiAg
IAkJI3NpemUtY2VsbHMgPSA8Mj47DQo+ID4gICAJCXJhbmdlczsNCj4gPiArCQlkbWEtcmFuZ2Vz
ID0gPDB4MCAweDAgMHgwIDB4MCAweDEwMDAwIDB4MDAwMDAwMDA+Ow0KPiA+DQo+ID4gICAJCWNs
b2NrZ2VuOiBjbG9ja2luZ0AxMzAwMDAwIHsNCj4gPiAgIAkJCWNvbXBhdGlibGUgPSAiZnNsLGxz
MjA4MGEtY2xvY2tnZW4iOw0KPiA+IEBAIC0zNTcsNiArMzU4LDggQEANCj4gPiAgIAkJCXJlZyA9
IDwweDAwMDAwMDA4IDB4MGMwMDAwMDAgMCAweDQwPiwJIC8qIE1DIHBvcnRhbA0KPiBiYXNlICov
DQo+ID4gICAJCQkgICAgICA8MHgwMDAwMDAwMCAweDA4MzQwMDAwIDAgMHg0MDAwMD47IC8qIE1D
DQo+IGNvbnRyb2wgcmVnICovDQo+ID4gICAJCQltc2ktcGFyZW50ID0gPCZpdHM+Ow0KPiA+ICsJ
CQlpb21tdS1tYXAgPSA8MCAmc21tdSAwIDA+OwkvKiBUaGlzIGlzIGZpeGVkLXVwIGJ5DQo+IHUt
Ym9vdCAqLw0KPiA+ICsJCQlkbWEtY29oZXJlbnQ7DQo+ID4gICAJCQkjYWRkcmVzcy1jZWxscyA9
IDwzPjsNCj4gPiAgIAkJCSNzaXplLWNlbGxzID0gPDE+Ow0KPiA+DQo+ID4gQEAgLTQ2MCw2ICs0
NjMsOCBAQA0KPiA+ICAgCQkJY29tcGF0aWJsZSA9ICJhcm0sbW11LTUwMCI7DQo+ID4gICAJCQly
ZWcgPSA8MCAweDUwMDAwMDAgMCAweDgwMDAwMD47DQo+ID4gICAJCQkjZ2xvYmFsLWludGVycnVw
dHMgPSA8MTI+Ow0KPiA+ICsJCQkjaW9tbXUtY2VsbHMgPSA8MT47DQo+ID4gKwkJCXN0cmVhbS1t
YXRjaC1tYXNrID0gPDB4N0MwMD47DQo+ID4gICAJCQlpbnRlcnJ1cHRzID0gPDAgMTMgND4sIC8q
IGdsb2JhbCBzZWN1cmUgZmF1bHQgKi8NCj4gPiAgIAkJCQkgICAgIDwwIDE0IDQ+LCAvKiBjb21i
aW5lZCBzZWN1cmUgaW50ZXJydXB0ICovDQo+ID4gICAJCQkJICAgICA8MCAxNSA0PiwgLyogZ2xv
YmFsIG5vbi1zZWN1cmUgZmF1bHQgKi8NCj4gPiBAQCAtNTAyLDcgKzUwNyw2IEBADQo+ID4gICAJ
CQkJICAgICA8MCAyMDQgND4sIDwwIDIwNSA0PiwNCj4gPiAgIAkJCQkgICAgIDwwIDIwNiA0Piwg
PDAgMjA3IDQ+LA0KPiA+ICAgCQkJCSAgICAgPDAgMjA4IDQ+LCA8MCAyMDkgND47DQo+ID4gLQkJ
CW1tdS1tYXN0ZXJzID0gPCZmc2xfbWMgMHgzMDAgMD47DQo+IA0KPiBTaW5jZSB3ZSdyZSBpbiBo
ZXJlLCBpcyB0aGUgU01NVSBpdHNlbGYgYWxzbyBjb2hlcmVudD8gSWYgaXQgaXMsIHlvdQ0KPiBw
cm9iYWJseSB3YW50IHRvIHNheSBzbyBhbmQgYXZvaWQgdGhlIG92ZXJoZWFkIG9mIHBvaW50bGVz
c2x5IGNsZWFuaW5nDQo+IGNhY2hlIGxpbmVzIG9uIGV2ZXJ5IHBhZ2UgdGFibGUgdXBkYXRlLg0K
DQpZZXMsIGRtYS1jb2hlcmVudCBwcm9wZXJ0eSBpcyBhbHNvIHJlcXVpcmVkIGhlcmUuIEkgbWlz
c2VkIGl0IHNvbWVob3cuDQpUaGFua3MgZm9yIHBvaW50aW5nIHRoaXMuDQoNClJlZ2FyZHMsDQpO
aXB1bg0KDQo+IA0KPiBSb2Jpbi4NCj4gDQo+ID4gICAJCX07DQo+ID4NCj4gPiAgIAkJZHNwaTog
ZHNwaUAyMTAwMDAwIHsNCj4gPg0K
