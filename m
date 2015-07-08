Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0134.outbound.protection.outlook.com [157.56.110.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9B4C61A18B2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 12:46:52 +1000 (AEST)
From: Wang Dongsheng <Dongsheng.Wang@freescale.com>
To: Scott Wood <scottwood@freescale.com>
CC: York Sun <yorksun@freescale.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, Jin Jason <Jason.Jin@freescale.com>
Subject: RE: [RESEND] powerpc/diu: adjust DIU initialization entry
Date: Wed, 8 Jul 2015 02:46:44 +0000
Message-ID: <SN1PR0301MB16166B5D40997C9558AA76159D910@SN1PR0301MB1616.namprd03.prod.outlook.com>
References: <1436255497-41207-1-git-send-email-dongsheng.wang@freescale.com>
 <1436305887.2658.49.camel@freescale.com>
 <SN1PR0301MB16161F3443AF7311DB42A36E9D910@SN1PR0301MB1616.namprd03.prod.outlook.com>
 <1436323289.2658.61.camel@freescale.com>
In-Reply-To: <1436323289.2658.61.camel@freescale.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29vZCBTY290dC1CMDc0
MjENCj4gU2VudDogV2VkbmVzZGF5LCBKdWx5IDA4LCAyMDE1IDEwOjQxIEFNDQo+IFRvOiBXYW5n
IERvbmdzaGVuZy1CNDA1MzQNCj4gQ2M6IFN1biBZb3JrLVI1ODQ5NTsgbGludXhwcGMtZGV2QGxp
c3RzLm96bGFicy5vcmc7IEppbiBaaGVuZ3hpb25nLVI2NDE4OA0KPiBTdWJqZWN0OiBSZTogW1JF
U0VORF0gcG93ZXJwYy9kaXU6IGFkanVzdCBESVUgaW5pdGlhbGl6YXRpb24gZW50cnkNCj4gDQo+
IE9uIFR1ZSwgMjAxNS0wNy0wNyBhdCAyMTozMCAtMDUwMCwgV2FuZyBEb25nc2hlbmctQjQwNTM0
IHdyb3RlOg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJv
bTogV29vZCBTY290dC1CMDc0MjENCj4gPiA+IFNlbnQ6IFdlZG5lc2RheSwgSnVseSAwOCwgMjAx
NSA1OjUxIEFNDQo+ID4gPiBUbzogV2FuZyBEb25nc2hlbmctQjQwNTM0DQo+ID4gPiBDYzogU3Vu
IFlvcmstUjU4NDk1OyBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZzsgSmluDQo+ID4gPiBa
aGVuZ3hpb25nLVI2NDE4OA0KPiA+ID4gU3ViamVjdDogUmU6IFtSRVNFTkRdIHBvd2VycGMvZGl1
OiBhZGp1c3QgRElVIGluaXRpYWxpemF0aW9uIGVudHJ5DQo+ID4gPg0KPiA+ID4gT24gVHVlLCAy
MDE1LTA3LTA3IGF0IDE1OjUxICswODAwLCBEb25nc2hlbmcgV2FuZyB3cm90ZToNCj4gPiA+ID4g
RnJvbTogV2FuZyBEb25nc2hlbmcgPGRvbmdzaGVuZy53YW5nQGZyZWVzY2FsZS5jb20+DQo+ID4g
PiA+DQo+ID4gPiA+IE1vdmUgZnNsX2RpdV9pbml0IGludG8gZGl1IHByb2JlIGZ1bmN0aW9uLCBi
ZWNhdXNlIGl0IHNob3VsZCBiZQ0KPiA+ID4gPiBpbml0aWFsaXplZCB3aGVuIHN5c3RlbSBnZXQg
ZGl1IGRldmljZSB0cmVlIG5vZGUsIG5vdCBhbHdheXMgZG8NCj4gPiA+ID4gaW5pdGlhbGl6YXRp
b24uDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFdhbmcgRG9uZ3NoZW5nIDxkb25n
c2hlbmcud2FuZ0BmcmVlc2NhbGUuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gQ2hhbmdlczoN
Cj4gPiA+ID4gUmViYXNlIG9yaWdpbmFsIHBhdGNoIGZvciB1cHN0cmVhbSBiZWNhdXNlIGZzbC1k
aXUtZmIuYyBoYXMgbW92ZWQNCj4gPiA+ID4gdG8gZmJkZXYgZGlyLg0KPiA+ID4gPg0KPiA+ID4g
PiBUaGlzIHBhdGNoIGlzIGEgbG9uZyB0aW1lIGFnbywgdGhlcmUgaXMgbm8gZmVlZGJhY2ssIGFu
ZCB0aGUNCj4gPiA+ID4gUGF0Y2h3b3JrIHN0YXRlIGhhcyBiZWVuIG1vZGlmaWVkIGZvciB0aGUg
Y2hhbmdlcyByZXF1ZXN0ZWQsIEkgZG9uJ3Qga25vdw0KPiB3aHkuDQo+ID4gPiA+IFNvIEkgcmVz
ZW5kIHRoaXMgcGF0Y2ggdG8gdXBzdHJlYW0uDQo+ID4gPg0KPiA+ID4gUGxlYXNlIHNlbmQgdGhp
cyB0byB0aGUgcHJvcGVyIGxpc3QgYW5kIG1haW50YWluZXIsIGFuZCB3aXRoIGENCj4gPiA+IHN1
YmplY3QgcHJlZml4IHRoYXQgaW5kaWNhdGVzIGl0J3MgYW4gZmJkZXYgcGF0Y2guDQo+ID4gPg0K
PiA+IFRoYW5rcy4NCj4gPg0KPiA+IEkgd2lsbCBzZW5kIHRoaXMgcGF0Y2ggdG8gbGludXgtZmJk
ZXZAdmdlci5rZXJuZWwub3JnLg0KPiA+DQo+ID4gUGxlYXNlIGlnbm9yZSB0aGlzIHBhdGNoLg0K
PiANCj4gWW91IHN0aWxsIGRpZG4ndCBmaXggdGhlIHN1YmplY3QgbGluZS4uLg0KPiANCg0KVGhl
IERJVSBiZWxvbmdzIHRvIHRoZSBQT1dFUlBDLCBuZWVkIEkgZml4IHRoaXM/IGZiZGV2L2RpdT8N
Cg0KUmVnYXJkcywNCi1Eb25nc2hlbmcNCg0K
