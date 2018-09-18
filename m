Return-Path: <andy.tang@nxp.com>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0040.outbound.protection.outlook.com [104.47.0.40])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Dkkx06G8zDsRY
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2018 10:43:49 +1000 (AEST)
From: Andy Tang <andy.tang@nxp.com>
To: Andy Tang <andy.tang@nxp.com>, "oss@buserror.net" <oss@buserror.net>
CC: "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "benh@kernel.crashing.org"
 <benh@kernel.crashing.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH] powerpc/mpc85xx: fix issues in clock node
Date: Tue, 18 Sep 2018 00:43:42 +0000
Message-ID: <DB5PR0401MB22130D7DA4C0AC850AD54909F31D0@DB5PR0401MB2213.eurprd04.prod.outlook.com>
References: <20180911021224.30558-1-andy.tang@nxp.com>
In-Reply-To: <20180911021224.30558-1-andy.tang@nxp.com>
Content-Type: text/plain; charset="gb2312"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

SGkgU2NvdHQsDQoNCkNvdWxkIHlvdSBwbGVhc2UgdGFrZSBhIGxvb2sgYXQgdGhpcyBwYXRjaD8N
Cg0KVGhhbmtzLA0KQW5keQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IGFuZHkudGFuZ0BueHAuY29tIDxhbmR5LnRhbmdAbnhwLmNvbT4NCj4gU2VudDogMjAxOMTqOdTC
MTHI1SAxMDoxMg0KPiBUbzogb3NzQGJ1c2Vycm9yLm5ldA0KPiBDYzogcm9iaCtkdEBrZXJuZWwu
b3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsNCj4gYmVuaEBrZXJuZWwuY3Jhc2hpbmcub3JnOyBk
ZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5v
cmc7IEFuZHkgVGFuZyA8YW5keS50YW5nQG54cC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSF0gcG93
ZXJwYy9tcGM4NXh4OiBmaXggaXNzdWVzIGluIGNsb2NrIG5vZGUNCj4gDQo+IEZyb206IFl1YW50
aWFuIFRhbmcgPGFuZHkudGFuZ0BueHAuY29tPg0KPiANCj4gVGhlIGNvbXBhdGlibGUgc3RyaW5n
IGlzIG5vdCBjb3JyZWN0IGluIHRoZSBjbG9jayBub2RlLg0KPiBUaGUgY2xvY2tzIHByb3BlcnR5
IHJlZmVycyB0byB0aGUgd3Jvbmcgbm9kZSB0b28uDQo+IFRoaXMgcGF0Y2ggaXMgdG8gZml4IHRo
ZW0uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBUYW5nIFl1YW50aWFuIDxhbmR5LnRhbmdAbnhwLmNv
bT4NCj4gLS0tDQo+ICBhcmNoL3Bvd2VycGMvYm9vdC9kdHMvZnNsL3QxMDIzc2ktcG9zdC5kdHNp
IHwgICAgOCArKysrLS0tLQ0KPiAgMSBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL2Jvb3QvZHRzL2Zz
bC90MTAyM3NpLXBvc3QuZHRzaQ0KPiBiL2FyY2gvcG93ZXJwYy9ib290L2R0cy9mc2wvdDEwMjNz
aS1wb3N0LmR0c2kNCj4gaW5kZXggNDkwOGFmNS4uNzYzY2FmNCAxMDA2NDQNCj4gLS0tIGEvYXJj
aC9wb3dlcnBjL2Jvb3QvZHRzL2ZzbC90MTAyM3NpLXBvc3QuZHRzaQ0KPiArKysgYi9hcmNoL3Bv
d2VycGMvYm9vdC9kdHMvZnNsL3QxMDIzc2ktcG9zdC5kdHNpDQo+IEBAIC0zNDgsNyArMzQ4LDcg
QEANCj4gIAkJbXV4MDogbXV4MEAwIHsNCj4gIAkJCSNjbG9jay1jZWxscyA9IDwwPjsNCj4gIAkJ
CXJlZyA9IDwweDAgND47DQo+IC0JCQljb21wYXRpYmxlID0gImZzbCxjb3JlLW11eC1jbG9jayI7
DQo+ICsJCQljb21wYXRpYmxlID0gImZzbCxxb3JpcS1jb3JlLW11eC0yLjAiOw0KPiAgCQkJY2xv
Y2tzID0gPCZwbGwwIDA+LCA8JnBsbDAgMT47DQo+ICAJCQljbG9jay1uYW1lcyA9ICJwbGwwXzAi
LCAicGxsMF8xIjsNCj4gIAkJCWNsb2NrLW91dHB1dC1uYW1lcyA9ICJjbXV4MCI7DQo+IEBAIC0z
NTYsOSArMzU2LDkgQEANCj4gIAkJbXV4MTogbXV4MUAyMCB7DQo+ICAJCQkjY2xvY2stY2VsbHMg
PSA8MD47DQo+ICAJCQlyZWcgPSA8MHgyMCA0PjsNCj4gLQkJCWNvbXBhdGlibGUgPSAiZnNsLGNv
cmUtbXV4LWNsb2NrIjsNCj4gLQkJCWNsb2NrcyA9IDwmcGxsMCAwPiwgPCZwbGwwIDE+Ow0KPiAt
CQkJY2xvY2stbmFtZXMgPSAicGxsMF8wIiwgInBsbDBfMSI7DQo+ICsJCQljb21wYXRpYmxlID0g
ImZzbCxxb3JpcS1jb3JlLW11eC0yLjAiOw0KPiArCQkJY2xvY2tzID0gPCZwbGwxIDA+LCA8JnBs
bDEgMT47DQo+ICsJCQljbG9jay1uYW1lcyA9ICJwbGwxXzAiLCAicGxsMV8xIjsNCj4gIAkJCWNs
b2NrLW91dHB1dC1uYW1lcyA9ICJjbXV4MSI7DQo+ICAJCX07DQo+ICAJfTsNCj4gLS0NCj4gMS43
LjENCg0K
