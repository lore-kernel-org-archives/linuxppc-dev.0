Return-Path: <Bharat.Bhushan@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0153.outbound.protection.outlook.com [207.46.163.153])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.protection.outlook.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1E12E2C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Dec 2013 15:56:15 +1100 (EST)
From: "Bharat.Bhushan@freescale.com" <Bharat.Bhushan@freescale.com>
To: Scott Wood <scottwood@freescale.com>, Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: RE: [1/3] powerpc/vfio: Enable on POWERNV platform
Date: Sat, 14 Dec 2013 04:56:06 +0000
Message-ID: <2e087e1f2aa34c0688a6c06420872d5f@BN1PR03MB266.namprd03.prod.outlook.com>
References: <1369107191-28547-2-git-send-email-aik@ozlabs.ru>
 <20131212233527.GA16929@home.buserror.net> <52AA78AE.2050800@ozlabs.ru>
 <1386968550.10013.320.camel@snotra.buserror.net>
In-Reply-To: <1386968550.10013.320.camel@snotra.buserror.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Varun Sethi <Varun.Sethi@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29vZCBTY290dC1CMDc0
MjENCj4gU2VudDogU2F0dXJkYXksIERlY2VtYmVyIDE0LCAyMDEzIDI6MzMgQU0NCj4gVG86IEFs
ZXhleSBLYXJkYXNoZXZza2l5DQo+IENjOiBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZzsg
a3ZtQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEFs
ZXggV2lsbGlhbXNvbjsgUGF1bCBNYWNrZXJyYXM7IERhdmlkIEdpYnNvbjsgU2V0aGkNCj4gVmFy
dW4tQjE2Mzk1OyBCaHVzaGFuIEJoYXJhdC1SNjU3NzcNCj4gU3ViamVjdDogUmU6IFsxLzNdIHBv
d2VycGMvdmZpbzogRW5hYmxlIG9uIFBPV0VSTlYgcGxhdGZvcm0NCj4gDQo+IE9uIEZyaSwgMjAx
My0xMi0xMyBhdCAxNDowMiArMTEwMCwgQWxleGV5IEthcmRhc2hldnNraXkgd3JvdGU6DQo+ID4g
T24gMTIvMTMvMjAxMyAxMDozNSBBTSwgU2NvdHQgV29vZCB3cm90ZToNCj4gPiA+IE9uIFR1ZSwg
TWF5IDIxLCAyMDEzIGF0IDAxOjMzOjA5UE0gKzEwMDAsIEFsZXhleSBLYXJkYXNoZXZza2l5IHdy
b3RlOg0KPiA+ID4+ICtzdGF0aWMgaW50IGlvbW11X2FkZF9kZXZpY2Uoc3RydWN0IGRldmljZSAq
ZGV2KSB7DQo+ID4gPj4gKwlzdHJ1Y3QgaW9tbXVfdGFibGUgKnRibDsNCj4gPiA+PiArCWludCBy
ZXQgPSAwOw0KPiA+ID4+ICsNCj4gPiA+PiArCWlmIChXQVJOX09OKGRldi0+aW9tbXVfZ3JvdXAp
KSB7DQo+ID4gPj4gKwkJcHJfd2FybigiaW9tbXVfdGNlOiBkZXZpY2UgJXMgaXMgYWxyZWFkeSBp
biBpb21tdSBncm91cCAlZCwNCj4gc2tpcHBpbmdcbiIsDQo+ID4gPj4gKwkJCQlkZXZfbmFtZShk
ZXYpLA0KPiA+ID4+ICsJCQkJaW9tbXVfZ3JvdXBfaWQoZGV2LT5pb21tdV9ncm91cCkpOw0KPiA+
ID4+ICsJCXJldHVybiAtRUJVU1k7DQo+ID4gPj4gKwl9DQo+ID4gPiBbc25pcF0NCj4gPiA+PiAr
c3RhdGljIGludCBfX2luaXQgdGNlX2lvbW11X2luaXQodm9pZCkgew0KPiA+ID4+ICsJc3RydWN0
IHBjaV9kZXYgKnBkZXYgPSBOVUxMOw0KPiA+ID4+ICsNCj4gPiA+PiArCUJVSUxEX0JVR19PTihQ
QUdFX1NJWkUgPCBJT01NVV9QQUdFX1NJWkUpOw0KPiA+ID4+ICsNCj4gPiA+PiArCWZvcl9lYWNo
X3BjaV9kZXYocGRldikNCj4gPiA+PiArCQlpb21tdV9hZGRfZGV2aWNlKCZwZGV2LT5kZXYpOw0K
PiA+ID4+ICsNCj4gPiA+PiArCWJ1c19yZWdpc3Rlcl9ub3RpZmllcigmcGNpX2J1c190eXBlLCAm
dGNlX2lvbW11X2J1c19uYik7DQo+ID4gPj4gKwlyZXR1cm4gMDsNCj4gPiA+PiArfQ0KPiA+ID4+
ICsNCj4gPiA+PiArc3Vic3lzX2luaXRjYWxsX3N5bmModGNlX2lvbW11X2luaXQpOw0KPiA+ID4N
Cj4gPiA+IFRoaXMgaXMgbWlzc2luZyBhIGNoZWNrIHRvIHNlZSB3aGV0aGVyIHRoZSBhcHByb3By
aWF0ZSBoYXJkd2FyZSBpcw0KPiA+ID4gcHJlc2VudC4gIFRoaXMgZmlsZSBzaG91bGQgYWxzbyBi
ZSByZW5hbWVkIHRvIHNvbWV0aGluZyBsZXNzDQo+ID4gPiBnZW5lcmljLCBhbmQgZGVwZW5kIG9u
IGEga2NvbmZpZyBzeW1ib2wgbW9yZSBzcGVjaWZpYyB0aGFuIENPTkZJR19QUEM2NC4NCj4gPiA+
DQo+ID4gPiBXaGVuIHRoaXMgaXMgY29tYmluZWQgd2l0aCBDT05GSUdfRlNMX1BBTVUgb24gaGFy
ZHdhcmUgd2l0aCBhIFBBTVUsDQo+ID4gPiBJIGdldCBhIGJ1bmNoIG9mIHRob3NlICJXQVJOX09O
KGRldi0+aW9tbXVfZ3JvdXApIiBkdW1wcyBiZWNhdXNlDQo+ID4gPiBQQU1VIGFscmVhZHkgZ290
IHRvIHRoZW0uICBQcmVzdW1hYmx5IHdpdGhvdXQgUEFNVSBpdCBzaWxlbnRseSAob3INCj4gPiA+
IHdpdGgganVzdCBwcl9kZWJ1ZykgYmFpbHMgb3V0IGF0IHNvbWUgb3RoZXIgcG9pbnQuDQo+ID4N
Cj4gPg0KPiA+IEkgcG9zdGVkICh5ZXQgYWdhaW4pIHllc3RlcmRheSAiW1BBVENIIHYxMV0gUFBD
OiBQT1dFUk5WOiBtb3ZlDQo+ID4gaW9tbXVfYWRkX2RldmljZSBlYXJsaWVyIiB3aGljaCBzaG91
bGQgZml4IHRoaXMuIEFuZCBCaGFyYXQgYXNrZWQgbWFueQ0KPiA+IHRpbWVzIGZvciB0aGlzIHRv
IGdldCBhY2NlcHRlZCA6KQ0KPiANCj4gSSBzdGlsbCBnZXQgdGhlIFdBUk5fT05zIGV2ZW4gd2l0
aCB0aGF0IHBhdGNoLiAgWW91J3JlIHN0aWxsIHJlZ2lzdGVyaW5nIHRoZSBidXMNCj4gbm90aWZp
ZXIgdW5jb25kaXRpb25hbGx5Lg0KDQpJIGhhdmUgbm90IHRyaWVkIHYxMSBidXQgdGVzdGVkIFY5
IHZlcnNpb24gb2YgdGhhdCBwYXRjaC4gQW5kIHllcywgaW4gdGhhdCB2ZXJzaW9uIHRoZSBidXMg
bm90aWZpZXIgd2FzIG5vdCByZWdpc3RlcmVkIHVuY29uZGl0aW9uYWxseSBpbiBrZXJuZWwvaW9t
bXUuYyAuDQoNClRoYW5rcw0KLUJoYXJhdA0KDQo+IA0KPiAtU2NvdHQNCj4gDQoNCg==
