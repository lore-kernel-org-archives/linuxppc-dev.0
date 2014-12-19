Return-Path: <Shaohui.Xie@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0109.outbound.protection.outlook.com [157.56.110.109])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E7FD81A0BCA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Dec 2014 18:38:22 +1100 (AEDT)
From: Shaohui Xie <Shaohui.Xie@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH] [v2] power/fsl: add MDIO dt binding for FMan
Date: Fri, 19 Dec 2014 07:23:26 +0000
Message-ID: <DM2PR0301MB0864AA31CD1A7438F476020FE26B0@DM2PR0301MB0864.namprd03.prod.outlook.com>
References: <1415958800-9867-1-git-send-email-shh.xie@gmail.com>
 <1416966592.15957.172.camel@freescale.com>
 <DM2PR0301MB08641FB289DBA17AD59FBEA0E26A0@DM2PR0301MB0864.namprd03.prod.outlook.com>
 <1418940078.5581.143.camel@freescale.com>
In-Reply-To: <1418940078.5581.143.camel@freescale.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Emilian Medve <Emilian.Medve@freescale.com>,
 "Igal.Liberman@freescale.com" <Igal.Liberman@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBXb29kIFNjb3R0LUIwNzQyMQ0K
PiBTZW50OiBGcmlkYXksIERlY2VtYmVyIDE5LCAyMDE0IDY6MDEgQU0NCj4gVG86IFhpZSBTaGFv
aHVpLUIyMTk4OQ0KPiBDYzogbGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmc7IGRldmljZXRy
ZWVAdmdlci5rZXJuZWwub3JnOyBNZWR2ZSBFbWlsaWFuLQ0KPiBFTU1FRFZFMTsgTGliZXJtYW4g
SWdhbC1CMzE5NTANCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gW3YyXSBwb3dlci9mc2w6IGFkZCBN
RElPIGR0IGJpbmRpbmcgZm9yIEZNYW4NCj4gDQo+IE9uIFRodSwgMjAxNC0xMi0xOCBhdCAwNjo1
MyAtMDYwMCwgWGllIFNoYW9odWktQjIxOTg5IHdyb3RlOg0KPiA+IFBpbmcuDQo+ID4NCj4gPiBC
ZXN0IFJlZ2FyZHMsDQo+ID4gU2hhb2h1aSBYaWUNCj4gDQo+IEkgY2FuJ3QgcHV0IHBhdGNoZXMg
aW4gbXkgLW5leHQgdW50aWwgdGhlIG1lcmdlIHdpbmRvdyBjbG9zZXMuDQo+IA0KPiA+ID4gPiA+
ICtFWEFNUExFDQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICtFeGFtcGxlIGZvciBGTWFuIHYyIGV4
dGVybmFsIE1ESU86DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICttZGlvQGYxMDAwIHsNCj4gPiA+
ID4gPiArCWNvbXBhdGlibGUgPSAiZnNsLGZtYW4teG1kaW8iOw0KPiA+ID4gPiA+ICsJcmVnID0g
PDB4ZjEwMDAgMHgxMDAwPjsNCj4gPiA+ID4gPiArCWJ1cy1mcmVxdWVuY3kgPSA8MjAwMDA+Ow0K
PiA+ID4gPiA+ICt9Ow0KPiA+ID4gPg0KPiA+ID4gPiBTbyB0aGUgYnVzIGZyZXF1ZW5jeSBpcyBv
bmx5IDIwIEtIej8gIE9yIGlzIHRoZSB1bml0IHN1cHBvc2VkIHRvDQo+ID4gPiA+IGJlIHNvbWV0
aGluZyBvdGhlciB0aGFuIEh6Pw0KPiA+ID4gW1MuSF0gaXQncyBvbmx5IGFuIGV4YW1wbGUsIGl0
IGNvdWxkIGJlIGRpZmZlcmVudCBvbiByZWFsIFNvQ3MsIGJ1dA0KPiA+ID4gdGhleSBhbHdheXMg
bG93ZXIgdGhhbiB0aGUgc3RhbmRhcmQgb25lLCBUaGUgc3RhbmRhcmQgb25lIGlzIDIuNU1Ieiwg
SSBoYXZlDQo+IHRvIHVzZSBIeiBmb3IgaXQuDQo+IA0KPiBJcyB0aGVyZSBhbnkgU29DIGZvciB3
aGljaCAyMCBrSHogaXMgdGhlIHJpZ2h0IGZyZXF1ZW5jeT8gIEkganVzdCB3YW50IHRvIG1ha2UN
Cj4gc3VyZSB0aGUgZXhhbXBsZSBpcyByZWFsaXN0aWMuDQpbUy5IXSB0aGUgY2xvY2sgZGl2aWRl
ciBoYXMgYSBsaW1pdGF0aW9uIHRoYXQgdGhlIE1BWCB2YWx1ZSBpdCBjYW4gZ2V0IG9uIEZtYW4g
djIgaXMgMjU1ICgweGZmLCA4IGJpdHMpLA0KT24gRm1hbiB2MyBpcyA1MTEoMHgxZmYsIDkgYml0
cykuDQoNClNvIHRoZSBsb3dlc3QgZnJlcXVlbmN5IG9uIEZtYW4gdjIgaXM6IEZtYW5fY2xvY2sg
LyAoMiAqIDI1NSksDQpPbiBGbWFuIHYzIGlzOiBGbWFuX2Nsb2NrIC8gKCgyICogNTExKSArIDEp
Lg0KDQpUYWtlIGRlZmF1bHQgRm1hbiBmcmVxdWVuY3kgc2V0dGluZyBmcm9tIFNESzEuNyBhcyBl
eGFtcGxlLCB0aGUgbG93ZXN0IGNsb2NrIHVzZWQgZm9yIEZtYW4gdjIgaXMgNTgxTUh6LA0KVGhl
IGxvd2VzdCBjbG9jayBmb3IgRm1hbiB2MyBpcyA2MDBNSHouDQoNClRoZW4gdGhlIGxvd2VzdCBi
dXMgZnJlcXVlbmN5IGNhbiBnZXQgaXM6DQpGbWFuIHYyOiB+MTE0MEtIeg0KRm1hbiB2MzogfjU4
N0tIeg0KDQoyMEtIeiBpcyBub3QgcHJhY3RpY2UsIHdlIGRvbid0IGhhdmUgYSBzdWdnZXN0ZWQg
dmFsdWUgaW4gZXJyYXRhIGRvY3VtZW50Lg0KRm9yIHRoaXMgZXhhbXBsZSwgc2hvdWxkIEkgcG9z
dCBhIG5ldyB2ZXJzaW9uIHdpdGggYSB2YWx1ZSBsaWtlIDEyMDBLSHo/DQoNClRoYW5rcyENClNo
YW9odWkNCg==
