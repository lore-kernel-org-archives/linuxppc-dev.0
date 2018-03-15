Return-Path: <madalin.bucur@nxp.com>
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00053.outbound.protection.outlook.com [40.107.0.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4023KR42F6zF12j
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2018 20:32:41 +1100 (AEDT)
From: Madalin-cristian Bucur <madalin.bucur@nxp.com>
To: "jocke@infinera.com" <joakim.tjernlund@infinera.com>,
 "davem@davemloft.net" <davem@davemloft.net>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Leo Li
 <leoyang.li@nxp.com>, Camelia Alexandra Groza <camelia.groza@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 0/5] DPAA Ethernet fixes
Date: Thu, 15 Mar 2018 09:32:35 +0000
Message-ID: <AM5PR04MB3267BC402A80D9E772BC8903ECD00@AM5PR04MB3267.eurprd04.prod.outlook.com>
References: <20180314133732.24068-1-madalin.bucur@nxp.com>
 <1521052994.4790.148.camel@infinera.com>
In-Reply-To: <1521052994.4790.148.camel@infinera.com>
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb2FraW0gVGplcm5sdW5kIFtt
YWlsdG86Sm9ha2ltLlRqZXJubHVuZEBpbmZpbmVyYS5jb21dDQo+IFNlbnQ6IFdlZG5lc2RheSwg
TWFyY2ggMTQsIDIwMTggODo0MyBQTQ0KPiBUbzogZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgTWFkYWxp
bi1jcmlzdGlhbiBCdWN1cg0KPiA8bWFkYWxpbi5idWN1ckBueHAuY29tPg0KPiANCj4gT24gV2Vk
LCAyMDE4LTAzLTE0IGF0IDA4OjM3IC0wNTAwLCBNYWRhbGluIEJ1Y3VyIHdyb3RlOg0KPiA+IEhp
LA0KPiA+DQo+ID4gVGhpcyBwYXRjaCBzZXQgaXMgYWRkcmVzc2luZyBzZXZlcmFsIGlzc3VlcyBp
biB0aGUgRFBBQSBFdGhlcm5ldA0KPiA+IGRyaXZlciBzdWl0ZToNCj4gPg0KPiA+ICAtIG1vZHVs
ZSB1bmxvYWQgY3Jhc2ggY2F1c2VkIGJ5IHdyb25nIHJlZmVyZW5jZSB0byBkZXZpY2UgYmVpbmcg
bGVmdA0KPiA+ICAgIGluIHRoZSBjbGVhbnVwIGNvZGUgYWZ0ZXIgdGhlIERTQSByZWxhdGVkIGNo
YW5nZXMNCj4gPiAgLSBzY2hlZHVsaW5nIHdpbGUgYXRvbWljIGJ1ZyBpbiBRTWFuIGNvZGUgcmV2
ZWFsZWQgZHVyaW5nIGRwYWFfZXRoDQo+ID4gICAgbW9kdWxlIHVubG9hZA0KPiA+ICAtIGEgY291
cGxlIG9mIGVycm9yIGNvdW50ZXIgZml4ZXMsIGEgZHVwbGljYXRlZCBpbml0IGluIGRwYWFfZXRo
Lg0KPiANCj4gaG1tLCBzb21lIG9mIHRoZXNlKGFsbD8pIGJ1Z3MgYXJlIGluIHN0YWJsZSB0b28s
IENDOiBzdGFibGUgcGVyaGFwcz8NCg0KSGkgSm9ja2UsDQoNCkkgZGlkIG5vdCBjaGVjayB0aGF0
LCB0aGV5IHNob3VsZCBiZSBhZGRlZC4NCg0KVGhhbmtzLA0KTWFkYWxpbg0KDQo+ID4NCj4gPiBN
YWRhbGluDQo+ID4NCj4gPiBDYW1lbGlhIEdyb3phICgzKToNCj4gPiAgIGRwYWFfZXRoOiByZW1v
dmUgZHVwbGljYXRlIGluaXRpYWxpemF0aW9uDQo+ID4gICBkcGFhX2V0aDogaW5jcmVtZW50IHRo
ZSBSWCBkcm9wcGVkIGNvdW50ZXIgd2hlbiBuZWVkZWQNCj4gPiAgIGRwYWFfZXRoOiByZW1vdmUg
ZHVwbGljYXRlIGluY3JlbWVudCBvZiB0aGUgdHhfZXJyb3JzIGNvdW50ZXINCj4gPg0KPiA+IE1h
ZGFsaW4gQnVjdXIgKDIpOg0KPiA+ICAgc29jL2ZzbC9xYm1hbjogZml4IGlzc3VlIGluIHFtYW5f
ZGVsZXRlX2Nncl9zYWZlKCkNCj4gPiAgIGRwYWFfZXRoOiBmaXggZXJyb3IgaW4gZHBhYV9yZW1v
dmUoKQ0KPiA+DQo+ID4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9kcGFhL2RwYWFf
ZXRoLmMgfCAgOCArKysrLS0tLQ0KPiA+ICBkcml2ZXJzL3NvYy9mc2wvcWJtYW4vcW1hbi5jICAg
ICAgICAgICAgICAgICAgIHwgMjggKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgMiBm
aWxlcyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDI3IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4g
LS0NCj4gPiAyLjEuMA0KPiA+DQo=
