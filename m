Return-Path: <Priyanka.Jain@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0181.outbound.protection.outlook.com [207.46.163.181])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7F1691A0019
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jul 2014 13:57:04 +1000 (EST)
From: Priyanka Jain <Priyanka.Jain@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH] devicetree/bindings/powerpc/fsl: Add binding for board
Date: Tue, 8 Jul 2014 03:56:56 +0000
Message-ID: <5e950276b79a48e5bc3b65007f7fc208@BLUPR03MB135.namprd03.prod.outlook.com>
References: <1404722194-8103-1-git-send-email-Priyanka.Jain@freescale.com>
 <1404768624.21434.196.camel@snotra.buserror.net>
In-Reply-To: <1404768624.21434.196.camel@snotra.buserror.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29vZCBTY290dC1CMDc0
MjENCj4gU2VudDogVHVlc2RheSwgSnVseSAwOCwgMjAxNCAzOjAwIEFNDQo+IFRvOiBKYWluIFBy
aXlhbmthLUIzMjE2Nw0KPiBDYzogZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4cHBj
LWRldkBsaXN0cy5vemxhYnMub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRldmljZXRyZWUv
YmluZGluZ3MvcG93ZXJwYy9mc2w6IEFkZCBiaW5kaW5nIGZvcg0KPiBib2FyZA0KPiANCj4gT24g
TW9uLCAyMDE0LTA3LTA3IGF0IDE0OjA2ICswNTMwLCBQcml5YW5rYSBKYWluIHdyb3RlOg0KPiA+
IFNpZ25lZC1vZmYtYnk6IFByaXlhbmthIEphaW4gPFByaXlhbmthLkphaW5AZnJlZXNjYWxlLmNv
bT4NCj4gPiAtLS0NCj4gPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvcG93ZXJwYy9mc2wvYm9h
cmQudHh0ICAgICAgfCAgIDE3DQo+ICsrKysrKysrKysrKysrKystDQo+ID4gIDEgZmlsZXMgY2hh
bmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcG93ZXJwYy9mc2wvYm9hcmQu
dHh0DQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcG93ZXJwYy9mc2wv
Ym9hcmQudHh0DQo+ID4gaW5kZXggZjM1ZjI5NS4uNzgwMDcyOSAxMDA2NDQNCj4gPiAtLS0gYS9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcG93ZXJwYy9mc2wvYm9hcmQudHh0DQo+
ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bvd2VycGMvZnNsL2Jv
YXJkLnR4dA0KPiA+IEBAIC0xLDggKzEsMjMgQEANCj4gPiAgRnJlZXNjYWxlIFJlZmVyZW5jZSBC
b2FyZCBCaW5kaW5ncw0KPiA+DQo+ID4gLVRoaXMgZG9jdW1lbnQgZGVzY3JpYmVzIGRldmljZSB0
cmVlIGJpbmRpbmdzIGZvciB2YXJpb3VzIGRldmljZXMgdGhhdA0KPiA+ICtUaGlzIGRvY3VtZW50
IGRlc2NyaWJlcyBkZXZpY2UgdHJlZSBiaW5kaW5ncyBmb3IgYm9hcmQgYW5kICB2YXJpb3VzDQo+
ID4gK2RldmljZXMgdGhhdA0KPiA+ICBleGlzdCBvbiBzb21lIEZyZWVzY2FsZSByZWZlcmVuY2Ug
Ym9hcmRzLg0KPiA+DQo+ID4gKyogQm9hcmQgbm9kZQ0KPiA+ICtSZXF1aXJlZCBwcm9wZXJ0aWVz
Og0KPiA+ICsNCj4gPiArIC0gbW9kZWwgOiBTaG91bGQgYmUgImZzbCw8Ym9hcmQ+Ig0KPiA+ICsg
LSBjb21wYXRpYmxlIDogU2hvdWxkIGJlICJmc2wsPGJvYXJkPiINCj4gPiArCWV4YW1wbGU6ICJm
c2wsVDEwNDBSREIiLCAiZnNsLFQxMDQyUkRCIiwgImZzbCxUMTA0MlJEQl9QSSINCj4gPiArCQkg
ImZzbCxUMTA0MFFEUyIsICJmc2wsVDEwNDJRRFMiDQo+ID4gKw0KPiA+ICtFeGFtcGxlOg0KPiA+
ICsNCj4gPiArLyB7DQo+ID4gKwltb2RlbCA9ICJmc2wsVDEwNDBSREIiOw0KPiA+ICsJY29tcGF0
aWJsZSA9ICJmc2wsVDEwNDBSREIiOw0KPiA+ICt9Ow0KPiANCj4gV2UgcmVhbGx5IGRvbid0IG5l
ZWQgdG8gZG8gdGhpcyBmb3IgZXZlcnkgYm9hcmQganVzdCB0byBzYXRpc2Z5DQo+IGNoZWNrcGF0
Y2guDQo+IA0KPiAtU2NvdHQNCj4gDQpbSmFpbiBQcml5YW5rYS1CMzIxNjddIElzIGl0IE9LIHRv
IHN1Ym1pdCBhIHBhdGNoIHdpdGggYm9hcmQgY2hlY2twYXRjaCB3YXJuaW5nIGZvciB0aGlzIGNh
c2UgPw0K
