Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.181])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 990441A0BEA
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Apr 2015 01:15:27 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Christophe Leroy' <christophe.leroy@c-s.fr>, Kim Phillips
 <kim.phillips@freescale.com>, Herbert Xu <herbert@gondor.apana.org.au>, David
 S Miller <davem@davemloft.net>
Subject: RE: [PATCH v3 03/17] crypto: talitos - talitos_ptr renamed ptr for
 more lisibility
Date: Fri, 17 Apr 2015 15:14:18 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CB21235@AcuExch.aculab.com>
References: <20150417142356.797BC1A242C@localhost.localdomain>
In-Reply-To: <20150417142356.797BC1A242C@localhost.localdomain>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RnJvbTogQ2hyaXN0b3BoZSBMZXJveQ0KPiBMaW51eCBDb2R5aW5nU3R5bGUgcmVjb21tZW5kcyB0
byB1c2Ugc2hvcnQgdmFyaWFibGVzIGZvciBsb2NhbA0KPiB2YXJpYWJsZXMuIHB0ciBpcyBqdXN0
IGdvb2QgZW5vdWdoIGZvciB0aG9zZSAzIGxpbmVzIGZ1bmN0aW9ucy4NCj4gSXQgaGVscHMga2Vl
cCBzaW5nbGUgbGluZXMgc2hvcnRlciB0aGFuIDgwIGNoYXJhY3RlcnMuDQouLi4NCj4gLXN0YXRp
YyB2b2lkIHRvX3RhbGl0b3NfcHRyKHN0cnVjdCB0YWxpdG9zX3B0ciAqdGFsaXRvc19wdHIsIGRt
YV9hZGRyX3QgZG1hX2FkZHIpDQo+ICtzdGF0aWMgdm9pZCB0b190YWxpdG9zX3B0cihzdHJ1Y3Qg
dGFsaXRvc19wdHIgKnB0ciwgZG1hX2FkZHJfdCBkbWFfYWRkcikNCj4gIHsNCj4gLQl0YWxpdG9z
X3B0ci0+cHRyID0gY3B1X3RvX2JlMzIobG93ZXJfMzJfYml0cyhkbWFfYWRkcikpOw0KPiAtCXRh
bGl0b3NfcHRyLT5lcHRyID0gdXBwZXJfMzJfYml0cyhkbWFfYWRkcik7DQo+ICsJcHRyLT5wdHIg
PSBjcHVfdG9fYmUzMihsb3dlcl8zMl9iaXRzKGRtYV9hZGRyKSk7DQo+ICsJcHRyLT5lcHRyID0g
dXBwZXJfMzJfYml0cyhkbWFfYWRkcik7DQo+ICB9DQouLi4NCg0KTWF5YmUsIGJ1dCAncHRyJyBp
c24ndCBhIGdvb2QgY2hvaWNlLg0KDQoJRGF2aWQNCg0K
