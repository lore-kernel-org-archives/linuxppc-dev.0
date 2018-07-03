Return-Path: <Joakim.Tjernlund@infinera.com>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01on0072.outbound.protection.outlook.com [104.47.34.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41KgPd1FmdzF1LZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2018 20:30:44 +1000 (AEST)
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "qiang.zhao@nxp.com"
 <qiang.zhao@nxp.com>, "york.sun@nxp.com" <york.sun@nxp.com>
Subject: Re: [PATCH] QE GPIO: Add qe_gpio_set_multiple
Date: Tue, 3 Jul 2018 10:30:37 +0000
Message-ID: <b7c4d55627e474a868ad7284672fbbd14dcf8d39.camel@infinera.com>
References: <20180619162216.20030-1-joakim.tjernlund@infinera.com>
 <VI1PR04MB1200BC4D8A8B362FE62B1D7591760@VI1PR04MB1200.eurprd04.prod.outlook.com>
 <fef3d759a1f6677ec713b120b4b1f4ab1eb4946b.camel@infinera.com>
 <87a7rh7ji2.fsf@concordia.ellerman.id.au>
In-Reply-To: <87a7rh7ji2.fsf@concordia.ellerman.id.au>
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

T24gVHVlLCAyMDE4LTA2LTI2IGF0IDIzOjQxICsxMDAwLCBNaWNoYWVsIEVsbGVybWFuIHdyb3Rl
Og0KPiANCj4gSm9ha2ltIFRqZXJubHVuZCA8Sm9ha2ltLlRqZXJubHVuZEBpbmZpbmVyYS5jb20+
IHdyaXRlczoNCj4gPiBPbiBUaHUsIDIwMTgtMDYtMjEgYXQgMDI6MzggKzAwMDAsIFFpYW5nIFpo
YW8gd3JvdGU6DQo+ID4gPiBPbiAwNi8xOS8yMDE4IDA5OjIyIEFNLCBKb2FraW0gVGplcm5sdW5k
IHdyb3RlOg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IExp
bnV4cHBjLWRldiBbbWFpbHRvOmxpbnV4cHBjLWRldi1ib3VuY2VzK3FpYW5nLnpoYW89bnhwLmNv
bUBsaXN0cy5vemxhYnMub3JnXSBPbiBCZWhhbGYgT2YgSm9ha2ltIFRqZXJubHVuZA0KPiA+ID4g
U2VudDogMjAxOOW5tDbmnIgyMOaXpSAwOjIyDQo+ID4gPiBUbzogWW9yayBTdW4gPHlvcmsuc3Vu
QG54cC5jb20+OyBsaW51eHBwYy1kZXYgPGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnPg0K
PiA+ID4gU3ViamVjdDogW1BBVENIXSBRRSBHUElPOiBBZGQgcWVfZ3Bpb19zZXRfbXVsdGlwbGUN
Cj4gPiA+IA0KPiA+ID4gVGhpcyBjb3VzaW4gdG8gZ3Bpby1tcGM4eHh4IHdhcyBsYWNraW5nIGEg
bXVsdGlwbGUgcGlucyBtZXRob2QsIGFkZCBvbmUuDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYt
Ynk6IEpvYWtpbSBUamVybmx1bmQgPGpvYWtpbS50amVybmx1bmRAaW5maW5lcmEuY29tPg0KPiA+
ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9zb2MvZnNsL3FlL2dwaW8uYyB8IDI4ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysNCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygr
KQ0KPiANCj4gLi4uDQo+ID4gPiAgc3RhdGljIGludCBxZV9ncGlvX2Rpcl9pbihzdHJ1Y3QgZ3Bp
b19jaGlwICpnYywgdW5zaWduZWQgaW50IGdwaW8pICB7DQo+ID4gPiAgICAgICAgIHN0cnVjdCBv
Zl9tbV9ncGlvX2NoaXAgKm1tX2djID0gdG9fb2ZfbW1fZ3Bpb19jaGlwKGdjKTsgQEAgLTI5OCw2
ICszMjUsNyBAQCBzdGF0aWMgaW50IF9faW5pdCBxZV9hZGRfZ3Bpb2NoaXBzKHZvaWQpDQo+ID4g
PiAgICAgICAgICAgICAgICAgZ2MtPmRpcmVjdGlvbl9vdXRwdXQgPSBxZV9ncGlvX2Rpcl9vdXQ7
DQo+ID4gPiAgICAgICAgICAgICAgICAgZ2MtPmdldCA9IHFlX2dwaW9fZ2V0Ow0KPiA+ID4gICAg
ICAgICAgICAgICAgIGdjLT5zZXQgPSBxZV9ncGlvX3NldDsNCj4gPiA+ICsgICAgICAgICAgICAg
ICBnYy0+c2V0X211bHRpcGxlID0gcWVfZ3Bpb19zZXRfbXVsdGlwbGU7DQo+ID4gPiANCj4gPiA+
ICAgICAgICAgICAgICAgICByZXQgPSBvZl9tbV9ncGlvY2hpcF9hZGRfZGF0YShucCwgbW1fZ2Ms
IHFlX2djKTsNCj4gPiA+ICAgICAgICAgICAgICAgICBpZiAocmV0KQ0KPiA+ID4gDQo+ID4gPiBS
ZXZpZXdlZC1ieTogUWlhbmcgWmhhbyA8cWlhbmcuemhhb0BueHAuY29tPg0KPiA+ID4gDQo+ID4g
DQo+ID4gV2hvIHBpY2tzIHVwIHRoaXMgcGF0Y2ggPyBJcyBpdCBxdWV1ZWQgc29tZXdoZXJlIGFs
cmVhZHk/DQo+IA0KPiBOb3QgbWUuDQoNCllvcms/IFlvdSBzZWVtIHRvIGJlIHRoZSBvbmx5IG9u
ZSBsZWZ0Lg0KDQogSm9ja2U=
