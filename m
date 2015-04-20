Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.182])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 233671A0E65
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 21:41:29 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Christophe Leroy' <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Michael
 Ellerman" <mpe@ellerman.id.au>, "scottwood@freescale.com"
 <scottwood@freescale.com>
Subject: RE: [PATCH 07/11] powerpc/8xx: macro for handling CPU15 errata
Date: Mon, 20 Apr 2015 11:40:10 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CB22366@AcuExch.aculab.com>
References: <20150420052637.185801A242C@localhost.localdomain>
In-Reply-To: <20150420052637.185801A242C@localhost.localdomain>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RnJvbTogQ2hyaXN0b3BoZSBMZXJveQ0KPiBTZW50OiAyMCBBcHJpbCAyMDE1IDA2OjI3DQo+IEhh
dmluZyBhIG1hY3JvIHdpbGwgaGVscCBrZWVwIGNsZWFyIGNvZGUuDQouLi4NCj4gICAqIFdlIGhh
dmUgdG8gdXNlIHRoZSBNRF94eHggcmVnaXN0ZXJzIGZvciB0aGUgdGFibGV3YWxrIGJlY2F1c2Ug
dGhlDQo+ICAgKiBlcXVpdmFsZW50IE1JX3h4eCByZWdpc3RlcnMgb25seSBwZXJmb3JtIHRoZSBh
dHRyaWJ1dGUgZnVuY3Rpb25zLg0KPiAgICovDQo+ICsNCj4gKyNpZmRlZiBDT05GSUdfOHh4X0NQ
VTE1DQo+ICsjZGVmaW5lIERPXzh4eF9DUFUxNSh0bXAsIGFkZHIpCVwNCj4gKwlhZGRpCXRtcCwg
YWRkciwgUEFHRV9TSVpFOwlcDQo+ICsJdGxiaWUJdG1wOwkJCVwNCj4gKwlhZGRpCXRtcCwgYWRk
ciwgUEFHRV9TSVpFOwlcDQo+ICsJdGxiaWUJdG1wDQo+ICsjZWxzZQ0KPiArI2RlZmluZSBET184
eHhfQ1BVMTUodG1wLCBhZGRyKQ0KPiArI2VuZGlmDQoNCkknbSBzdXJlIEkndmUgc3BvdHRlZCB0
aGUgc2FtZSBvYnZpb3VzIGVycm9yIGluIHRoZSBhYm92ZSBiZWZvcmUuDQoNCkknZCBhbHNvIHN1
Z2dlc3QgY2FsbGluZyBpdCAnaW52YWxpZGF0ZV9hZGphY2VudF9wYWdlcycgLSBzaW5jZSB0aGF0
IGl0DQp3aGF0IGl0IGRvZXMuDQoNCkkgYWxzbyBndWVzcyB0aGF0IHRoZSBleGVjdXRpb24gdGlt
ZSBvZiAndGxiaWUnIGlzIG5vbi10cml2aWFsLg0KU28geW91IG1pZ2h0IGFzIHdlbGwgZ2V0IHJp
ZCBvZiB0aGUgdGVtcG9yYXJ5IHJlZ2lzdGVyIGFuZCBwdXQgYW4NCidhZGRpJyB0byByZXNldCAn
YWRkcicgYXQgdGhlIGVuZC4NCg0KCURhdmlkDQoNCg==
