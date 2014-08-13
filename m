Return-Path: <Shaohui.Xie@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 172FB1A01F5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Aug 2014 18:59:44 +1000 (EST)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0145.outbound.protection.outlook.com [207.46.163.145])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 19BDE14008B
 for <linuxppc-dev@ozlabs.org>; Wed, 13 Aug 2014 18:59:42 +1000 (EST)
From: Shaohui Xie <Shaohui.Xie@freescale.com>
To: Scott Wood <scottwood@freescale.com>, Emilian Medve
 <Emilian.Medve@freescale.com>
Subject: RE: [PATCH v2 5/7] powerpc/corenet: Add MDIO bus muxing support to
 the board device tree(s)
Date: Wed, 13 Aug 2014 08:44:54 +0000
Message-ID: <28efb1be1f1640fda4486130faa1f119@CY1PR0301MB0857.namprd03.prod.outlook.com>
References: <1405541831-1277-1-git-send-email-Shruti@Freescale.com>
 <1405541831-1277-5-git-send-email-Shruti@Freescale.com>
 <1405982754.29414.33.camel@snotra.buserror.net>
 <loom.20140728T081519-636@post.gmane.org>
 <1406663895.29414.240.camel@snotra.buserror.net>
 <53D96906.1040407@Freescale.com>
 <1406773805.29414.302.camel@snotra.buserror.net>
 <53D9C77D.8070203@Freescale.com>
 <1406784487.29414.328.camel@snotra.buserror.net>
 <53D9D893.8090105@Freescale.com>
 <1406831433.29414.339.camel@snotra.buserror.net>
In-Reply-To: <1406831433.29414.339.camel@snotra.buserror.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW51eHBwYy1kZXYgW21haWx0
bzpsaW51eHBwYy1kZXYtDQo+IGJvdW5jZXMrYjIxOTg5PWZyZWVzY2FsZS5jb21AbGlzdHMub3ps
YWJzLm9yZ10gT24gQmVoYWxmIE9mIFNjb3R0IFdvb2QNCj4gU2VudDogRnJpZGF5LCBBdWd1c3Qg
MDEsIDIwMTQgMjozMSBBTQ0KPiBUbzogTWVkdmUgRW1pbGlhbi1FTU1FRFZFMQ0KPiBDYzogbGlu
dXhwcGMtZGV2QG96bGFicy5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiA1LzddIHBvd2Vy
cGMvY29yZW5ldDogQWRkIE1ESU8gYnVzIG11eGluZyBzdXBwb3J0DQo+IHRvIHRoZSBib2FyZCBk
ZXZpY2UgdHJlZShzKQ0KPiANCj4gT24gVGh1LCAyMDE0LTA3LTMxIGF0IDAwOjQ4IC0wNTAwLCBF
bWlsIE1lZHZlIHdyb3RlOg0KPiA+IEhlbGxvIFNjb3R0LA0KPiA+DQo+ID4NCj4gPiBPbiAwNy8z
MS8yMDE0IDEyOjI4IEFNLCBTY290dCBXb29kIHdyb3RlOg0KPiA+ID4gT24gV2VkLCAyMDE0LTA3
LTMwIGF0IDIzOjM1IC0wNTAwLCBFbWlsIE1lZHZlIHdyb3RlOg0KPiA+ID4+IEhlbGxvIFNjb3R0
LA0KPiA+ID4+DQo+ID4gPj4NCj4gPiA+PiBPbiAwNy8zMC8yMDE0IDA5OjMwIFBNLCBTY290dCBX
b29kIHdyb3RlOg0KPiA+ID4+PiBPbiBXZWQsIDIwMTQtMDctMzAgYXQgMTY6NTIgLTA1MDAsIEVt
aWwgTWVkdmUgd3JvdGU6DQo+ID4gPj4+Pj4+Pj4gKwkJCW1kaW8wOiBtZGlvIDxhdD4gZmMwMDAg
ew0KPiA+ID4+Pj4+Pj4+ICsJCQl9Ow0KPiA+ID4+Pj4+Pj4NCj4gPiA+Pj4+Pj4+IFdoeSBpcyB0
aGUgZW1wdHkgbm9kZSBuZWVkZWQ/DQo+ID4gPj4+Pj4+DQo+ID4gPj4+Pj4+IEZvciB0aGUgbGFi
ZWwNCj4gPiA+Pj4+Pg0KPiA+ID4+Pj4+IEZvciBtZGlvLXBhcmVudC1idXMsIG9yIGlzIHRoZXJl
IHNvbWUgb3RoZXIgZHRzIGxheWVyIHRoYXQgbWFrZXMNCj4gPiA+Pj4+PiB0aGlzIG5vZGUgbm9u
LWVtcHR5Pw0KPiA+ID4+Pj4NCj4gPiA+Pj4+ICdwb3dlcnBjL2NvcmVuZXQ6IENyZWF0ZSB0aGUg
ZHRzIGNvbXBvbmVudHMgZm9yIHRoZSBEUEFBIEZNYW4nIC0NCj4gPiA+Pj4+IGh0dHA6Ly9wYXRj
aHdvcmsub3psYWJzLm9yZy9wYXRjaC8zNzA4NzINCj4gPiA+Pj4NCj4gPiA+Pj4gV2h5IGRvZXMg
dGhpcyBwYXRjaCBkZWZpbmUgdGhlIG1kaW8wIGxhYmVsIGZvciBtZGlvQGUxMTIwLCBidXQgbm90
DQo+ID4gPj4+IGRlZmluZSBhIGxhYmVsIGZvciBhbnkgb3RoZXIgbm9kZT8NCj4gPiA+Pg0KPiA+
ID4+IE9ubHkgTURJTyBjb250cm9sbGVycyB0aGF0IGFyZSBwaW5uZWQgb3V0IGhhdmUgdGhlc2Ug
bGFiZWxzLiBPbmx5DQo+ID4gPj4gcGlubmVkIG91dCBNRElPKHMpIGFyZSBjYXBhYmxlIG9mIGNv
bnRyb2xsaW5nIGV4dGVybmFsIFBIWShzKSB2aWENCj4gPiA+PiB0aGVzZSBib2FyZCBsZXZlbCBN
RElPIGJ1c2VzDQo+ID4gPg0KPiA+ID4gSXMgdGhlcmUgYW55IHJlYXNvbiB0byBkZXNjcmliZSBu
b24tcGlubmVkLW91dCBNRElPIGNvbnRyb2xsZXJzIGF0DQo+IGFsbD8NCltTLkhdIFJlZ2FyZGlu
ZyB0aGUgcGlubmVkLW91dCBNRElPIGNvbnRyb2xsZXJzIGFuZCBub24tcGlubmVkLW91dCBNRElP
IGNvbnRyb2xsZXJzLA0KSG93IHRvIGRpZmZlcmVudGlhdGUgdGhlbT8NCg0KPiA+DQo+ID4gWWVz
LiBGb3IgdGhlIGludGVybmFsIFRCSSBQSFkocykuIEVhY2ggTUFDIHN1cHBvcnRpbmcgU0dNSUkg
aGFzIGEgVEJJDQo+ID4gUEhZIHRoYXQgaXMgYXR0YWNoZWQgdG8gdGhlIE1ESU8gY29udHJvbGxl
ciBvZiB0aGUgcmVzcGVjdGl2ZSBNQUMNCj4gDQpbUy5IXSB0aGVyZSBhcmUgbXVsdGlwbGUgaW50
ZXJuYWwgUEhZcyBvbiBGbWFuLXYzIFNPQ3MuIEVhY2ggb25lIGlzIHVzZWQgZm9yDQpTcGVjaWZp
YyBmdW5jdGlvbiwgZm9yIGV4LiBvbiBUNCB0aGVyZSBhcmUgWEZJLCBTR01JSSwgUVNHTUlJLg0K
V2lsbCBhbGwgb2YgdGhlbSBiZSBsaXN0ZWQgaW4gdGhlIERUUz8gDQoNClRoYW5rcyENCg0KLVNo
YW9odWkNCg==
