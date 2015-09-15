Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.188])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 51CEC1A2C32
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 20:37:55 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Colin Ian King' <colin.king@canonical.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
CC: "cbe-oss-dev@lists.ozlabs.org" <cbe-oss-dev@lists.ozlabs.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH 2/3] drivers/ps3: Fix ps3-vuart null dereference
Date: Tue, 15 Sep 2015 10:37:21 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CB94413@AcuExch.aculab.com>
References: <cover.1442259101.git.geoff@infradead.org>
 <497c718e763173b28ffe4e50258cb257c362d404.1442259101.git.geoff@infradead.org>
In-Reply-To: <497c718e763173b28ffe4e50258cb257c362d404.1442259101.git.geoff@infradead.org>
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

RnJvbTogQ29saW4gSWFuIEtpbmcNCj4gU2VudDogMTQgU2VwdGVtYmVyIDIwMTUgMjA6MzUNCj4g
T24gdGhlIHVubGlrZWx5IGV2ZW50IHRoYXQgZHJ2IGlzIG51bGwsIHRoZSBjdXJyZW50IGNvZGUg
d2lsbA0KPiBwZXJmb3JtIGEgbnVsbCBwb2ludGVyIGRlcmVmZXJlbmNlIHdpdGggaXQgd2hlbiBw
cmludGluZyBhIGRldl9kYmcNCj4gbWVzc2FnZS4gIEluc3RlYWQsIHRoZSBCVUdfT04gY2hlY2sg
b24gZHJ2IHNob3VsZCBiZSBwZXJmb3JtZWQNCj4gYmVmb3JlIHdlIGVtaXQgdGhlIGRldl9kYmcg
bWVzc2FnZS4NCi4uLg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wczMvcHMzLXZ1YXJ0LmMgYi9k
cml2ZXJzL3BzMy9wczMtdnVhcnQuYw0KPiBpbmRleCBkNmRiODIyLi42MzI3MDFhIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL3BzMy9wczMtdnVhcnQuYw0KPiArKysgYi9kcml2ZXJzL3BzMy9wczMt
dnVhcnQuYw0KPiBAQCAtMTAwMCwxMiArMTAwMCwxMSBAQCBzdGF0aWMgaW50IHBzM192dWFydF9w
cm9iZShzdHJ1Y3QgcHMzX3N5c3RlbV9idXNfZGV2aWNlICpkZXYpDQo+ICAJZGV2X2RiZygmZGV2
LT5jb3JlLCAiJXM6JWRcbiIsIF9fZnVuY19fLCBfX0xJTkVfXyk7DQo+IA0KPiAgCWRydiA9IHBz
M19zeXN0ZW1fYnVzX2Rldl90b192dWFydF9kcnYoZGV2KTsNCj4gKwlCVUdfT04oIWRydik7DQo+
IA0KPiAgCWRldl9kYmcoJmRldi0+Y29yZSwgIiVzOiVkOiAoJXMpXG4iLCBfX2Z1bmNfXywgX19M
SU5FX18sDQo+ICAJCWRydi0+Y29yZS5jb3JlLm5hbWUpOw0KPiANCj4gLQlCVUdfT04oIWRydik7
DQo+IC0NCg0KSnVzdCBkZWxldGUgdGhlIEJVR19PTigpLCBpdCBpcyBqdXN0IGFzIGVhc3kgdG8g
ZGVidWcgdGhlIGRlcmVmZXJlbmNlLg0KDQoJRGF2aWQNCg0K
