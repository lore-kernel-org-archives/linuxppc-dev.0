Return-Path: <qiang.zhao@nxp.com>
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00066.outbound.protection.outlook.com [40.107.0.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yS77c4QMnzDqlM
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Nov 2017 12:40:09 +1100 (AEDT)
From: Qiang Zhao <qiang.zhao@nxp.com>
To: Julien Thierry <julien.thierry@arm.com>, "oss@buserror.net"
 <oss@buserror.net>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [Patch v10] QE: remove PPCisms for QE
Date: Thu, 2 Nov 2017 01:40:04 +0000
Message-ID: <AM3PR04MB11855D1C194163038E1E34F8915C0@AM3PR04MB1185.eurprd04.prod.outlook.com>
References: <20171101020133.27966-1-qiang.zhao@nxp.com>
 <b9a491c9-c7f9-3062-8c85-468c1a94ba0d@arm.com>
In-Reply-To: <b9a491c9-c7f9-3062-8c85-468c1a94ba0d@arm.com>
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

T24gMDEvMTEvMTcgMDU6MTlQTSwgSnVsaWVuIFRoaWVycnkgPGp1bGllbi50aGllcnJ5QGFybS5j
b20+IHdyb3RlOg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKdWxpZW4g
VGhpZXJyeSBbbWFpbHRvOmp1bGllbi50aGllcnJ5QGFybS5jb21dDQo+IFNlbnQ6IFdlZG5lc2Rh
eSwgTm92ZW1iZXIgMDEsIDIwMTcgNToxOSBQTQ0KPiBUbzogUWlhbmcgWmhhbyA8cWlhbmcuemhh
b0BueHAuY29tPjsgb3NzQGJ1c2Vycm9yLm5ldA0KPiBDYzogbGludXhwcGMtZGV2QGxpc3RzLm96
bGFicy5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0
OiBSZTogW1BhdGNoIHYxMF0gUUU6IHJlbW92ZSBQUENpc21zIGZvciBRRQ0KPiANCj4gSGkgWmhh
bywNCj4gDQo+IEkganVzdCBub3RpY2VkIGEgc21hbGwgbml0Lg0KPiANCj4gPiAgIAkvKiB3YWl0
IGZvciB0aGUgUUVfQ1JfRkxHIHRvIGNsZWFyICovDQo+ID4gLQlyZXQgPSBzcGluX2V2ZW50X3Rp
bWVvdXQoKGluX2JlMzIoJnFlX2ltbXItPmNwLmNlY3IpICYgUUVfQ1JfRkxHKQ0KPiA9PSAwLA0K
PiA+IC0JCQkgICAxMDAsIDApOw0KPiA+ICsJcmV0ID0gLUVJTzsNCj4gPiArCWZvciAoaSA9IDA7
IGkgPCAxMDA7IGkrKykgew0KPiA+ICsJCWlmICgoaW9yZWFkMzJiZSgmcWVfaW1tci0+Y3AuY2Vj
cikgJiBRRV9DUl9GTEcpID09IDApIHsNCj4gPiArCQkJcmV0ID0gMDsNCj4gPiArCQkJYnJlYWs7
DQo+ID4gKwkJfQ0KPiA+ICsJCXVkZWxheSgxKTsNCj4gPiArCX0NCj4gPiArDQo+ID4gICAJLyog
T24gdGltZW91dCAoZS5nLiBmYWlsdXJlKSwgdGhlIGV4cHJlc3Npb24gd2lsbCBiZSBmYWxzZSAo
cmV0ID09IDApLA0KPiA+ICAgCSAgIG90aGVyd2lzZSBpdCB3aWxsIGJlIHRydWUgKHJldCA9PSAx
KS4gKi8NCj4gDQo+IG5pdDoNCj4gVGhlIGNvbW1lbnQgaGVyZSBpcyBubyBsb25nZXIgdmFsaWQs
IG9uIHRpbWVvdXQgcmV0ID09IC1FSU8gYW5kIG9uIHN1Y2Nlc3MgMC4gSXQNCj4gc2hvdWxkIHBy
b2JhYmx5IGJlIHJlbW92ZWQgdG8gYXZvaWQgY29uZnVzaW9uLg0KDQpTbyB0aGFuayB5b3UgZm9y
IHlvdSByZW1pbmRlciwgSSBpZ25vcmVkIGl0LCBhbmQgd2lsbCBmaXggaW4gdGhlIG5leHQgdmVy
c2lvbi4NCiANCkJSDQotUWlhbmcgWmhhbw0K
