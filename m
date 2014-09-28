Return-Path: <Yuantian.Tang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0138.outbound.protection.outlook.com [157.56.111.138])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6EFF51A016E
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Sep 2014 13:52:57 +1000 (EST)
From: Yuantian Tang <Yuantian.Tang@freescale.com>
To: Mike Turquette <mturquette@linaro.org>, Scott Wood
 <scottwood@freescale.com>
Subject: RE: [PATCHv4] clk: ppc-corenet: rename to ppc-qoriq and add
 CLK_OF_DECLARE support
Date: Sun, 28 Sep 2014 02:18:38 +0000
Message-ID: <d637914864824bda8d0dd62639e9097b@DM2PR03MB574.namprd03.prod.outlook.com>
References: <1411454806-8214-1-git-send-email-jingchang.lu@freescale.com>
 <d4a375f40b544cf1ae78ac82dc20569c@BL2PR03MB467.namprd03.prod.outlook.com>
 <1411675680.13320.201.camel@snotra.buserror.net>
 <20140925225406.19023.25065@quantum>
 <1411685780.13320.209.camel@snotra.buserror.net>
 <20140926232900.19023.35854@quantum>
In-Reply-To: <20140926232900.19023.35854@quantum>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Jingchang Lu <jingchang.lu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW51eHBwYy1kZXYNCj4gW21h
aWx0bzpsaW51eHBwYy1kZXYtYm91bmNlcytiMjk5ODM9ZnJlZXNjYWxlLmNvbUBsaXN0cy5vemxh
YnMub3JnXSBPbg0KPiBCZWhhbGYgT2YgTWlrZSBUdXJxdWV0dGUNCj4gU2VudDogU2F0dXJkYXks
IFNlcHRlbWJlciAyNywgMjAxNCA3OjI5IEFNDQo+IFRvOiBXb29kIFNjb3R0LUIwNzQyMQ0KPiBD
YzogbGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgTHUgSmluZ2No
YW5nLUIzNTA4Mw0KPiBTdWJqZWN0OiBSZTogW1BBVENIdjRdIGNsazogcHBjLWNvcmVuZXQ6IHJl
bmFtZSB0byBwcGMtcW9yaXEgYW5kIGFkZA0KPiBDTEtfT0ZfREVDTEFSRSBzdXBwb3J0DQo+IA0K
PiBRdW90aW5nIFNjb3R0IFdvb2QgKDIwMTQtMDktMjUgMTU6NTY6MjApDQo+ID4gT24gVGh1LCAy
MDE0LTA5LTI1IGF0IDE1OjU0IC0wNzAwLCBNaWtlIFR1cnF1ZXR0ZSB3cm90ZToNCj4gPiA+IFF1
b3RpbmcgU2NvdHQgV29vZCAoMjAxNC0wOS0yNSAxMzowODowMCkNCj4gPiA+ID4gV2VsbCwgbGlr
ZSBJIHNhaWQsIEknZCByYXRoZXIgc2VlIHRoZSBDTEtfT0ZfREVDTEFSRSBzdHVmZiBiZSBtYWRl
DQo+ID4gPiA+IHRvIHdvcmsgb24gUFBDIHJhdGhlciB0aGFuIGhhdmUgdGhlIGRyaXZlciBjYXJy
eSBhcm91bmQgdHdvDQo+ID4gPiA+IGJpbmRpbmcgbWV0aG9kcy4NCj4gPiA+DQo+ID4gPiBJIGd1
ZXNzIHRoYXQgaXMgYW4gZXhpc3RpbmcgcHJvYmxlbSwgYW5kIG5vdCByZWxhdGVkIGRpcmVjdGx5
IHRvDQo+ID4gPiB0aGlzIHBhdGNoPyBUaGlzIHBhdGNoIGlzIGVzc2VudGlhbGx5IGp1c3QgcmVu
YW1lcyAodGhvdWdoIHRoZQ0KPiA+ID4gVjEuMC9WMi4wIHN0dWZmIHNlZW1zIHdlaXJkKS4NCj4g
Pg0KPiA+IFRoaXMgcGF0Y2ggaXMgYWRkaW5nIENMS19PRl9ERUNMQVJFLg0KPiANCj4gSSdtIGZp
bmUgdGFraW5nIHRoaXMgcGF0Y2ggYnV0IHlvdXIgY29tbWVudHMgYXJlIHN0aWxsIHVucmVzb2x2
ZWQuIFdoYXQgZG8geW91DQo+IHRoaW5rIG5lZWRzIHRvIGJlIGRvbmUgdG8gZml4IHRoZSBwcm9i
bGVtcyB0aGF0IHlvdSBzZWU/DQo+IA0KQ0xLX09GX0RFQ0xBUkUgaXMgdG90YWxseSB3b3JrZWQg
b24gUFBDLiBJIHdpbGwgZG8gaXQgaW4gYSBzZXBhcmF0ZSBwYXRjaC4NClJlZ2FyZGluZyBWMS4w
IGFuZCBWMi4wLCBpdCBpcyBub3Qgd2lyZWQganVzdCBzYW1lIGZvciBub3cuIEJ1dCB3ZSBhcmUg
bm90IHN1cmUgaWYgaXQgaXMgc2FtZSBmb3IgdjMuMCBpbiB0aGUgZnV0dXJlLg0KDQpCZXNpZGVz
IHVwZGF0aW5nIGRyaXZlcnMvY3B1ZnJlcS9LY29uZmlnLnBvd2VycGMsIHRoZXJlIGlzIG9uZSBt
b3JlIHRoaW5nIEkgYW0gbm90IGNvbWZvcnRhYmxlIHdpdGg6DQpUaGlzIHBhdGNoIHVzZXMgIiBm
aXhlZC1jbG9jayIgYXMgc3lzY2xrJ3MgY29tcGF0aWJsZSBzdHJpbmcsIHdoaWxlIG9uIFBQQyB3
ZSB0cmVhdGVkIGl0IGFzICIgZnNsLHFvcmlxLXN5c2Nsay1bMS0yXS4wIi4NClRoYXQncyBpbmNv
bnNpc3RlbnQgb24gYm90aCBBUk0gYW5kIFBQQyBwbGF0Zm9ybXMsIG5laXRoZXIgZGlkIG9uIGJp
bmRpbmdzLg0KDQpUaGFua3MsDQpZdWFudGlhbg0KDQo+IFJlZ2FyZHMsDQo+IE1pa2UNCj4gDQo+
ID4NCj4gPiAtU2NvdHQNCj4gPg0KPiA+DQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fDQo+IExpbnV4cHBjLWRldiBtYWlsaW5nIGxpc3QNCj4gTGludXhw
cGMtZGV2QGxpc3RzLm96bGFicy5vcmcNCj4gaHR0cHM6Ly9saXN0cy5vemxhYnMub3JnL2xpc3Rp
bmZvL2xpbnV4cHBjLWRldg0K
