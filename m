Return-Path: <qiang.zhao@nxp.com>
Received: from emea01-db3-obe.outbound.protection.outlook.com
 (mail-db3on0093.outbound.protection.outlook.com [157.55.234.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 692621A0037
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jan 2016 12:22:34 +1100 (AEDT)
From: Qiang Zhao <qiang.zhao@nxp.com>
To: Scott Wood <oss@buserror.net>, Li Yang <leoli@freescale.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, lkml
 <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "Priyanka.Jain@freescale.com" <Priyanka.Jain@freescale.com>
Subject: RE: [PATCH 3/6] QE: Add uqe_serial document to bindings
Date: Tue, 19 Jan 2016 01:22:24 +0000
Message-ID: <AM3PR04MB1185A208E42FBC20C7E9887A91C10@AM3PR04MB1185.eurprd04.prod.outlook.com>
References: <1452219494-31947-1-git-send-email-qiang.zhao@nxp.com>
 <1452219494-31947-3-git-send-email-qiang.zhao@nxp.com>
 <CADRPPNS3qT+=zz60UKRSYwxpaphcE7e04SntOQ==RjoOfhQ68Q@mail.gmail.com>
 <AM3PR04MB11851EDA91BA3C1D7386BC8D91C00@AM3PR04MB1185.eurprd04.prod.outlook.com>
 <1453158476.19133.70.camel@buserror.net>
In-Reply-To: <1453158476.19133.70.camel@buserror.net>
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

T24gRnJpLCBKYW4gMTksIDIwMTYgYXQgMDc6MDggUE0sIFNjb3R0IFdvb2QgPG9zc0BidXNlcnJv
ci5uZXQ+IHdyb3RlOg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTY290
dCBXb29kIFttYWlsdG86b3NzQGJ1c2Vycm9yLm5ldF0NCj4gU2VudDogVHVlc2RheSwgSmFudWFy
eSAxOSwgMjAxNiA3OjA4IEFNDQo+IFRvOiBRaWFuZyBaaGFvIDxxaWFuZy56aGFvQG54cC5jb20+
OyBMaSBZYW5nIDxsZW9saUBmcmVlc2NhbGUuY29tPg0KPiBDYzogZGV2aWNldHJlZUB2Z2VyLmtl
cm5lbC5vcmc7IGxrbWwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+Ow0KPiBsaW51eHBw
Yy1kZXYgPGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnPjsgUHJpeWFua2EuSmFpbkBmcmVl
c2NhbGUuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMy82XSBRRTogQWRkIHVxZV9zZXJpYWwg
ZG9jdW1lbnQgdG8gYmluZGluZ3MNCj4gDQo+IE9uIE1vbiwgMjAxNi0wMS0xOCBhdCAwOToyNCAr
MDAwMCwgUWlhbmcgWmhhbyB3cm90ZToNCj4gPiBPbiBGcmksIEphbiAxOCwgMjAxNiBhdCAwNTox
MCBQTSwgTGkgWWFuZyA8bGVvbGlAZnJlZXNjYWxlLmNvbT53cm90ZToNCj4gPiA+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBwa3UubGVvQGdtYWlsLmNvbSBbbWFpbHRv
OnBrdS5sZW9AZ21haWwuY29tXSBPbiBCZWhhbGYgT2YgTGkNCj4gPiA+IFlhbmcNCj4gPiA+IFNl
bnQ6IE1vbmRheSwgSmFudWFyeSAxOCwgMjAxNiA1OjEwIFBNDQo+ID4gPiBUbzogUWlhbmcgWmhh
byA8cWlhbmcuemhhb0BueHAuY29tPg0KPiA+ID4gQ2M6IGRldmljZXRyZWVAdmdlci5rZXJuZWwu
b3JnOyBsa21sIDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsNCj4gPiA+IGxpbnV4cHBj
LWRldiA8bGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmc+Ow0KPiA+ID4gUHJpeWFua2EuSmFp
bkBmcmVlc2NhbGUuY29tOyBvc3NAYnVzZXJyb3IubmV0DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BB
VENIIDMvNl0gUUU6IEFkZCB1cWVfc2VyaWFsIGRvY3VtZW50IHRvIGJpbmRpbmdzDQo+ID4gPg0K
PiA+ID4gT24gRnJpLCBKYW4gOCwgMjAxNiBhdCAxMDoxOCBBTSwgWmhhbyBRaWFuZyA8cWlhbmcu
emhhb0BueHAuY29tPiB3cm90ZToNCj4gPiA+ID4gQWRkIHVxZV9zZXJpYWwgZG9jdW1lbnQgdG8N
Cj4gPiA+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bvd2VycGMvZnNsL2Nw
bV9xZS91cWVfc2VyaWFsLnR4DQo+ID4gPiA+IHQNCj4gPiA+DQo+ID4gPiBBcyB5b3UgaGF2ZSBz
dWJtaXR0ZWQgcGF0Y2ggdG8gbW92ZSBRRSBjb2RlIGZyb20gYXJjaC9wb3dlcnBjIGludG8NCj4g
PiA+IGRyaXZlcnMvc29jL2ZzbCBmb3IgdGhlIHJldXNlIG9mIEFSTSBhbmQgcG93ZXJwYywgIHlv
dSBzaG91bGQgYWxzbw0KPiA+ID4gbW92ZSB0aGUgYmluZGluZyBkb2N1bWVudHMgb3V0IG9mIHRo
ZSBwb3dlcnBjIGZvbGRlciBpbnRvIGEgbW9yZQ0KPiA+ID4gY29tbW9uIHBsYWNlIGFuZCBhZGQg
bmV3IGJpbmRpbmdzIGluIHRoZSBuZXcgbG9jYXRpb24uDQo+ID4NCj4gPiBUaGFuayB5b3UgZm9y
IHlvdXIgcmVjb21tZW5kYXRpb24uDQo+ID4gSG93IGFib3V0IGNyZWF0ZSBhIG5ldyBkaXJlY3Rv
cnkgbmFtZWQgcWUgdW5kZXINCj4gPiAiRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
LyI/DQo+ID4gT3IgeW91IGhhdmUgYSBiZXR0ZXIgc3VnZ2VzdGlvbj8NCj4gDQo+IERvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvZnNsL2NwbV9xZQ0KDQpUaGFuayB5b3UgdmVy
eSBtdWNoIQ0KDQpCZXN0IFJlZ2FyZHMNClpoYW8gUWlhbmcNCg==
