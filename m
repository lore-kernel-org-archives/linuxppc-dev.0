Return-Path: <Shengzhou.Liu@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0206.outbound.protection.outlook.com [207.46.163.206])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9F7931A004F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jul 2014 17:05:08 +1000 (EST)
From: "Shengzhou.Liu@freescale.com" <Shengzhou.Liu@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH] of: Add vendor prefix for EON Corporation
Date: Tue, 8 Jul 2014 07:04:53 +0000
Message-ID: <d1f1002be5574bdc821e241e70138bc6@DM2PR03MB398.namprd03.prod.outlook.com>
References: <1404725359-6754-1-git-send-email-Shengzhou.Liu@freescale.com>
 <1404759301.21434.145.camel@snotra.buserror.net>
In-Reply-To: <1404759301.21434.145.camel@snotra.buserror.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29vZCBTY290dC1CMDc0
MjENCj4gU2VudDogVHVlc2RheSwgSnVseSAwOCwgMjAxNCAyOjU1IEFNDQo+IFRvOiBMaXUgU2hl
bmd6aG91LUIzNjY4NQ0KPiBDYzogbGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmcNCj4gU3Vi
amVjdDogUmU6IFtQQVRDSF0gb2Y6IEFkZCB2ZW5kb3IgcHJlZml4IGZvciBFT04gQ29ycG9yYXRp
b24NCj4gDQo+IE9uIE1vbiwgMjAxNC0wNy0wNyBhdCAxNzoyOSArMDgwMCwgU2hlbmd6aG91IExp
dSB3cm90ZToNCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGVuZ3pob3UgTGl1IDxTaGVuZ3pob3UuTGl1
QGZyZWVzY2FsZS5jb20+DQo+ID4gLS0tDQo+ID4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy92ZW5kb3ItcHJlZml4ZXMudHh0IHwgMSArDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKQ0KPiANCj4gQWdhaW4sIHBsZWFzZSBDQyBhbGwgcmVsZXZhbnQgbWFpbGlu
ZyBsaXN0cy4gIFdoZXJlIGlzIHRoZSBkZXZpY2V0cmVlDQo+IGxpc3Q/ICBBbmQgbWVudGlvbiB3
aHkgdGhpcyBwYXRjaCBpcyByZWxldmFudCB0byBQUEMuDQo+IA0KPiAtU2NvdHQNCltTaGVuZ3po
b3VdIEkgZGlkbid0IGZpbmQgYW55IHJlbGV2YW50IGxpc3QgZm9yIGRldmljZXRyZWUgaW4gdGhl
IE1BSU5UQUlORVJTLCBzbyBzZW50IGl0IGhlcmUgdG8gd2FpdCBmb3Igc29tZW9uZSBwb2ludCB0
byB0aGUgcHJvcGVyIGxpc3QuDQo+IA0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy92ZW5kb3ItcHJlZml4ZXMudHh0DQo+ID4gYi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdmVuZG9yLXByZWZpeGVzLnR4dA0KPiA+IGluZGV4
IDFhNjc5M2IuLjNjMTBhMjEgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3ZlbmRvci1wcmVmaXhlcy50eHQNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvdmVuZG9yLXByZWZpeGVzLnR4dA0KPiA+IEBAIC00Miw2ICs0
Miw3IEBAIGVidglFQlYgRWxla3Ryb25paw0KPiA+ICBlZHQJRW1lcmdpbmcgRGlzcGxheSBUZWNo
bm9sb2dpZXMNCj4gPiAgZW1taWNybwlFTSBNaWNyb2VsZWN0cm9uaWMNCj4gPiAgZXBmbAlFY29s
ZSBQb2x5dGVjaG5pcXVlIEbDqWTDqXJhbGUgZGUgTGF1c2FubmUNCj4gPiArZW9uCUVvbiBTaWxp
Y29uIFNvbHV0aW9uLCBJbmMuDQo+ID4gIGVwc29uCVNlaWtvIEVwc29uIENvcnAuDQo+ID4gIGVz
dAlFU1RlZW0gV2lyZWxlc3MgTW9kZW1zDQo+ID4gIGV1a3JlYSAgRXVrcsOpYSBFbGVjdHJvbWF0
aXF1ZQ0KPiANCg0K
