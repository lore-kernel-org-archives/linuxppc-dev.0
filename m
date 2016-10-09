Return-Path: <hongtao.jia@nxp.com>
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30072.outbound.protection.outlook.com [40.107.3.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ssDx06f42zDrWP
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Oct 2016 18:12:52 +1100 (AEDT)
From: Troy Jia <hongtao.jia@nxp.com>
To: Zhang Rui <rui.zhang@intel.com>, Leo Li <pku.leo@gmail.com>, Rob Herring
 <robh@kernel.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, lkml <linux-kernel@vger.kernel.org>, "Scott
 Wood" <scott.wood@nxp.com>, Eduardo Valentin <edubezval@gmail.com>, Kumar
 Gala <galak@codeaurora.org>, Shawn Guo <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH V2 1/7] dt-bindings: Update QorIQ TMU thermal bindings
Date: Sun, 9 Oct 2016 07:12:46 +0000
Message-ID: <AM4PR0401MB18433BD56D0441C832B06123EBD80@AM4PR0401MB1843.eurprd04.prod.outlook.com>
References: <1465270054-31512-1-git-send-email-hongtao.jia@nxp.com>
 <20160608195241.GA6805@rob-hp-laptop>
 <CADRPPNQ+hikr1qNK1wPbLnhudUrU1bN_2iuYyRQnqCN4Zwh83Q@mail.gmail.com>
 <1474253068.23153.2.camel@intel.com>
In-Reply-To: <1474253068.23153.2.camel@intel.com>
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBaaGFuZyBSdWkgW21haWx0bzpy
dWkuemhhbmdAaW50ZWwuY29tXQ0KPiBTZW50OiBNb25kYXksIFNlcHRlbWJlciAxOSwgMjAxNiAx
MDo0NCBBTQ0KPiBUbzogTGVvIExpIDxwa3UubGVvQGdtYWlsLmNvbT47IFJvYiBIZXJyaW5nIDxy
b2JoQGtlcm5lbC5vcmc+DQo+IENjOiBUcm95IEppYSA8aG9uZ3Rhby5qaWFAbnhwLmNvbT47IGRl
dmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gcG1Admdlci5rZXJuZWwub3JnOyBs
aW51eHBwYy1kZXYgPGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnPjsgbGttbCA8bGludXgt
DQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBTY290dCBXb29kIDxzY290dC53b29kQG54cC5j
b20+OyBFZHVhcmRvIFZhbGVudGluDQo+IDxlZHViZXp2YWxAZ21haWwuY29tPjsgS3VtYXIgR2Fs
YSA8Z2FsYWtAY29kZWF1cm9yYS5vcmc+OyBTaGF3biBHdW8NCj4gPHNoYXduZ3VvQGtlcm5lbC5v
cmc+OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gU3ViamVjdDogUmU6
IFtQQVRDSCBWMiAxLzddIGR0LWJpbmRpbmdzOiBVcGRhdGUgUW9ySVEgVE1VIHRoZXJtYWwgYmlu
ZGluZ3MNCj4gDQo+IE9uIOS4iSwgMjAxNi0wOS0xNCBhdCAxMTo0MCAtMDUwMCwgTGVvIExpIHdy
b3RlOg0KPiA+IE9uIFdlZCwgSnVuIDgsIDIwMTYgYXQgMjo1MiBQTSwgUm9iIEhlcnJpbmcgPHJv
YmhAa2VybmVsLm9yZz4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gT24gVHVlLCBKdW4gMDcsIDIwMTYg
YXQgMTE6Mjc6MzRBTSArMDgwMCwgSmlhIEhvbmd0YW8gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+
IEZvciBkaWZmZXJlbnQgdHlwZXMgb2YgU29DIHRoZSBzZW5zb3IgaWQgYW5kIGVuZGlhbm5lc3Mg
bWF5IHZhcnkuDQo+ID4gPiA+ICIjdGhlcm1hbC1zZW5zb3ItY2VsbHMiIGlzIHVzZWQgdG8gcHJv
dmlkZSBzZW5zb3IgaWQgaW5mb3JtYXRpb24uDQo+ID4gPiA+ICJsaXR0bGUtZW5kaWFuIiBwcm9w
ZXJ0eSBpcyB0byB0ZWxsIHRoZSBlbmRpYW5uZXNzIG9mIFRNVS4NCj4gPiA+ID4NCj4gPiA+ID4g
U2lnbmVkLW9mZi1ieTogSmlhIEhvbmd0YW8gPGhvbmd0YW8uamlhQG54cC5jb20+DQo+ID4gPiA+
IC0tLQ0KPiA+ID4gPiBDaGFuZ2VzIGZvciBWMjoNCj4gPiA+ID4gKiBSZW1vdmUgZm9ybWF0dGlu
ZyBjaG5hZ2VzLg0KPiA+ID4gPg0KPiA+ID4gPiDCoERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy90aGVybWFsL3FvcmlxLXRoZXJtYWwudHh0IHwgNw0KPiA+ID4gPiArKysrKysrDQo+
ID4gPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gQWNrZWQtYnk6
IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+ID4gSGkgWmhhbmcgUnVpLA0KPiA+DQo+
ID4gU2luY2UgeW91IGhhdmUgYXBwbGllZCB0aGUgZHJpdmVyIHBhdGNoLCBjYW4geW91IGFsc28g
YXBwbHkgdGhlDQo+ID4gYmluZGluZyBwYXRjaD/CoMKgVGhlIGJpbmRpbmcgaXMgc3VwcG9zZWQg
dG8gZ28gd2l0aCB0aGUgZHJpdmVyLg0KPiA+DQo+IA0KPiBEbyB5b3UgbWVhbiBJIHNob3VsZCB0
YWtlIGJvdGggcGF0Y2ggMS83IGFuZCA3Lzc/IEkgY2FuIG5vdCBzZWUgdGhlIG90aGVyIHBhdGNo
ZXMNCj4gaW4gdGhpcyBwYXRjaCBzZXQuDQoNClllcywgcGxlYXNlIHRha2UgNy83IGFzIHdlbGwu
DQpJIGFsc28gcmV3b3JrZWQgdGhlIGRldmljZSB0cmVlIHBhdGNoZXMgYW5kIHlvdSBjYW4gZmlu
ZCB0aGVtIGhlcmU6DQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzkzNjgzNzcv
DQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzkzNjgzODEvDQpodHRwczovL3Bh
dGNod29yay5rZXJuZWwub3JnL3BhdGNoLzkzNjgzODMvDQpodHRwczovL3BhdGNod29yay5rZXJu
ZWwub3JnL3BhdGNoLzkzNjgzNzkvDQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNo
LzkzNjgzODUvDQoNCi1Ib25ndGFvLg0KDQo+IA0KPiB0aGFua3MsDQo+IHJ1aQ0KDQo=
