Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.185])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 480F81A09D9
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Feb 2015 22:55:29 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'David Gibson' <david@gibson.dropbear.id.au>, "benh@kernel.crashing.org"
 <benh@kernel.crashing.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "paulus@samba.org" <paulus@samba.org>, "agraf@suse.de" <agraf@suse.de>
Subject: RE: [PATCH 0/5] powerpc: Get rid of redundant arch specific swab
 functions
Date: Wed, 4 Feb 2015 11:54:39 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CADA5A5@AcuExch.aculab.com>
References: <1422941785-22557-1-git-send-email-david@gibson.dropbear.id.au>
In-Reply-To: <1422941785-22557-1-git-send-email-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "aik@ozlabs.ru" <aik@ozlabs.ru>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mdroth@us.ibm.com" <mdroth@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RnJvbTogRGF2aWQgR2lic29uDQo+IGFyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9zd2FiLmggaW5j
bHVkZXMgc29tZSBwb3dlcnBjIHNwZWNpZmljDQo+IGJ5dGVzd2FwcGluZyBmdW5jdGlvbnMsIHdo
aWNoIGFyZSBpbXBsZW1lbnRlZCBpbiB0ZXJtcyBvZiBwb3dlcnBjJ3MNCj4gYnVpbHQgaW4gYnl0
ZSByZXZlcnNlZCBsb2FkL3N0b3JlIGluc3RydWN0aW9ucy4gIFRoZXJlIGFyZSB0d28gcHJvYmxl
bXMgd2l0aCB0aGlzOg0KPiANCj4gMSkgVGhleSdyZSBub3QgbmVjZXNzYXJ5IC0gZ2NjIGlzIHBl
cmZlY3RseSBjYXBhYmxlIG9mIGdlbmVyYXRpbmcgdGhlDQo+ICAgIGJ5dGUtcmV2ZXJzZWQgbG9h
ZCBhbmQgc3RvcmUgaW5zdHJ1Y3Rpb25zIHdoZW4gdXNpbmcgdGhlIG5vcm1hbCwNCj4gICAgZ2Vu
ZXJpYyBieXRlc3dhcHBpbmcgZnVuY3Rpb25zICh0ZXN0ZWQgd2l0aCBnY2MgKEdDQykgNC44LjMN
Cj4gICAgMjAxNDA5MTEgKFJlZCBIYXQgNC44LjMtOSkpDQoNClNob3VsZCB5b3UgYmUgd29ycnlp
bmcgYWJvdXQgb2xkZXIgdmVyc2lvbnMgb2YgZ2NjPw0KSUlSQyB0aGUgaW50ZXJuYWwgYnl0ZXN3
YXAgJ3N0dWZmJyBpcyByZWxhdGl2ZWx5IHJlY2VudCAobGlrZQ0KdGhlIGxhc3QgY291cGxlIG9m
IHllYXJzKSBzbyBwZW9wbGUgYnVpbGRpbmcgY3VycmVudCBrZXJuZWxzDQpvbiBvbGRlciBkaXN0
cmlidXRpb25zIG1pZ2h0IGhhdmUgaXNzdWVzLg0KDQoJRGF2aWQNCg0K
