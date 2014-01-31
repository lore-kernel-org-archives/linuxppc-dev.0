Return-Path: <prabhakar@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0206.outbound.protection.outlook.com [207.46.163.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9D4AD2C0090
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 14:40:03 +1100 (EST)
From: "prabhakar@freescale.com" <prabhakar@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH 1/2][v7] driver/memory:Move Freescale IFC driver to a
 common driver
Date: Fri, 31 Jan 2014 03:23:54 +0000
Message-ID: <cc597cc6590e4eb7b7d6fbc004fbf749@DM2PR03MB464.namprd03.prod.outlook.com>
References: <1390886979-9341-1-git-send-email-prabhakar@freescale.com>
 <1391117477.6733.39.camel@snotra.buserror.net>
In-Reply-To: <1391117477.6733.39.camel@snotra.buserror.net>
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
MjENCj4gU2VudDogRnJpZGF5LCBKYW51YXJ5IDMxLCAyMDE0IDM6MDEgQU0NCj4gVG86IEt1c2h3
YWhhIFByYWJoYWthci1CMzI1NzkNCj4gQ2M6IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3Jn
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXVt2N10gZHJpdmVyL21lbW9yeTpNb3ZlIEZyZWVz
Y2FsZSBJRkMgZHJpdmVyIHRvIGEgY29tbW9uDQo+IGRyaXZlcg0KPiANCj4gT24gVHVlLCAyMDE0
LTAxLTI4IGF0IDEwOjU5ICswNTMwLCBQcmFiaGFrYXIgS3VzaHdhaGEgd3JvdGU6DQo+ID4gIEZy
ZWVzY2FsZSBJRkMgY29udHJvbGxlciBoYXMgYmVlbiB1c2VkIGZvciBtcGM4eHh4LiBJdCB3aWxs
IGJlIHVzZWQNCj4gPiBmb3IgQVJNLWJhc2VkIFNvQyBhcyB3ZWxsLiBUaGlzIHBhdGNoIG1vdmVz
IHRoZSBkcml2ZXIgdG8NCj4gPiBkcml2ZXIvbWVtb3J5ICBhbmQgZml4IHRoZSBoZWFkZXIgZmls
ZSBpbmNsdWRlcy4NCj4gPg0KPiA+ICBBbHNvIHJlbW92ZSBtb2R1bGVfcGxhdGZvcm1fZHJpdmVy
KCkgYW5kICBpbnN0ZWFkIGNhbGwNCj4gPiAgcGxhdGZvcm1fZHJpdmVyX3JlZ2lzdGVyKCkgZnJv
bSBzdWJzeXNfaW5pdGNhbGwoKSB0byBtYWtlIHN1cmUgdGhpcw0KPiA+IG1vZHVsZSAgaGFzIGJl
ZW4gbG9hZGVkIGJlZm9yZSBNVEQgcGFydGl0aW9uIHBhcnNpbmcgc3RhcnRzLg0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogUHJhYmhha2FyIEt1c2h3YWhhIDxwcmFiaGFrYXJAZnJlZXNjYWxlLmNv
bT4NCj4gPiBBY2tlZC1ieTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4NCj4gDQo+IFdo
ZW4gZGlkIEFybmQgYWNrIHRoaXM/ICBFc3BlY2lhbGx5IGluIHY3IGZvcm0uLi4gYW5kIEkgZG9u
J3Qgc2VlIGhpbSBvbiBDQy4NCj4gDQo+ID4gK2NvbmZpZyBGU0xfSUZDDQo+ID4gKwlib29sICJG
cmVlc2NhbGUgSW50ZWdyYXRlZCBGbGFzaCBDb250cm9sbGVyIg0KPiA+ICsJZGVwZW5kcyBvbiBG
U0xfU09DDQo+ID4gKwloZWxwDQo+ID4gKwkgIFRoaXMgZHJpdmVyIGlzIGZvciB0aGUgSW50ZWdy
YXRlZCBGbGFzaCBDb250cm9sbGVyIENvbnRyb2xsZXIoSUZDKQ0KPiANCj4gQ29udHJvbGxlciBD
b250cm9sbGVyPw0KDQpJIHdpbGwgZml4IGl0DQoNCj4gDQo+ID4gKwkgIG1vZHVsZSBhdmFpbGFi
bGUgaW4gRnJlZXNjYWxlIFNvQ3MuIFRoaXMgY29udHJvbGxlciBhbGxvd3MgdG8gaGFuZGxlDQo+
IGZsYXNoDQo+ID4gKwkgIGRldmljZXMgc3VjaCBhcyBOT1IsIE5BTkQsIEZQR0EgYW5kIEFTSUMg
ZXRjDQo+IA0KPiBGUEdBIGFuZCBBU0lDIGFyZSBub3QgKG5lY2Vzc2FyaWx5KSBmbGFzaCBkZXZp
Y2VzLg0KPiANCg0KWWVzIGl0IHRydWUuIA0KSSBhbSBub3Qgc3VyZSB0aGlzIGZvbGRlciBpcyBv
bmx5IGZvciBmbGFzaCBjb250cm9sbGVyLg0KSSBjYW4gc2VlIHJlZmVyZW5jZXMgb2YgRlBHQSwg
U1JBTSBpbiBzYW1lIEtjb25maWdzLiANCg0KUmVnYXJkcywNClByYWJoYWthcg0K
