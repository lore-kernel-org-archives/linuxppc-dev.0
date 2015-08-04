Return-Path: <Igal.Liberman@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0138.outbound.protection.outlook.com [207.46.100.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3EE371A076F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Aug 2015 23:52:21 +1000 (AEST)
From: Liberman Igal <Igal.Liberman@freescale.com>
To: Scott Wood <scottwood@freescale.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Madalin-Cristian Bucur <madalin.bucur@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [v3, 1/2] powerpc/mpc85xx: Create dts components for the FSL QorIQ
 DPAA FMan
Date: Tue, 4 Aug 2015 13:52:14 +0000
Message-ID: <DM2PR03MB509851209BA3F1CB941E30CE6760@DM2PR03MB509.namprd03.prod.outlook.com>
References: <1438584241-10460-1-git-send-email-igal.liberman@freescale.com>
 <1438664426.2097.75.camel@freescale.com>
In-Reply-To: <1438664426.2097.75.camel@freescale.com>
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

DQoNClJlZ2FyZHMsDQpJZ2FsIExpYmVybWFuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogV29vZCBTY290dC1CMDc0MjENCj4gU2VudDogVHVlc2RheSwgQXVndXN0IDA0
LCAyMDE1IDg6MDAgQU0NCj4gVG86IExpYmVybWFuIElnYWwtQjMxOTUwIDxJZ2FsLkxpYmVybWFu
QGZyZWVzY2FsZS5jb20+DQo+IENjOiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXhw
cGMtZGV2QGxpc3RzLm96bGFicy5vcmc7IEJ1Y3VyDQo+IE1hZGFsaW4tQ3Jpc3RpYW4tQjMyNzE2
IDxtYWRhbGluLmJ1Y3VyQGZyZWVzY2FsZS5jb20+OyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2Vy
bmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW3YzLDEvMl0gcG93ZXJwYy9tcGM4NXh4OiBDcmVhdGUg
ZHRzIGNvbXBvbmVudHMgZm9yIHRoZSBGU0wNCj4gUW9ySVEgRFBBQSBGTWFuDQo+IA0KPiBbUmVz
ZW5kaW5nIGFmdGVyIGJvZ29maWx0ZXIgYWRqdXN0bWVudCBvbiB2Z2VyLmtlcm5lbC5vcmddDQo+
IA0KPiBPbiBNb24sIEF1ZyAwMywgMjAxNSBhdCAwOTo0NDowMUFNICswMzAwLCBJZ2FsLkxpYmVy
bWFuIHdyb3RlOg0KPiA+ICsgICAgIHhtZGlvMDogIG1kaW9AZjEwMDB7DQo+ID4gKyAgICAgICAg
ICAgICAjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gPiArICAgICAgICAgICAgICNzaXplLWNlbGxz
ID0gPDA+Ow0KPiA+ICsgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJmc2wsZm1hbi14bWRpbyI7
DQo+ID4gKyAgICAgICAgICAgICByZWcgPSA8MHhmMTAwMCAweDEwMDA+Ow0KPiA+ICsgICAgICAg
ICAgICAgaW50ZXJydXB0cyA9IDwxMDEgMSAwIDA+Ow0KPiA+ICsgICAgIH07DQo+IA0KPiBXaHkg
aXMgdGhpcyA8MTAxIDEgMCAwPiBhbmQgbm90IDwxMDEgMiAwIDA+PyAgSW50ZXJuYWwgaW50ZXJy
dXB0cyBhcmUgYWN0aXZlLQ0KPiBoaWdoLg0KPiANCg0KT0ssIEknbGwgZml4IHRoaXMgaXNzdWUu
IFRoYW5rcy4NCklnYWwuDQoNCj4gPiArICAgICBtZGlvMDogIG1kaW9AZTExMjB7DQo+ID4gKyAg
ICAgICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gPiArICAgICAgICAgICAgICNzaXpl
LWNlbGxzID0gPDA+Ow0KPiA+ICsgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJmc2wsZm1hbi1t
ZGlvIjsNCj4gPiArICAgICAgICAgICAgIHJlZyA9IDwweGUxMTIwIDB4ZWUwPjsNCj4gPiArICAg
ICAgICAgICAgIGludGVycnVwdHMgPSA8MTAwIDEgMCAwPjsNCj4gDQo+IExpa2V3aXNlLg0KPiAN
Cj4gLVNjb3R0DQo=
