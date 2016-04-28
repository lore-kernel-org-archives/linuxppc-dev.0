Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwfrH5L61zDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 00:50:06 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Chris Smart' <chris@distroguy.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH] powerpc: Add support for userspace P9 copy paste
Date: Thu, 28 Apr 2016 14:48:24 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D5F4AFB5C@AcuExch.aculab.com>
References: <20160426002844.GA9198@x1.distroguy.com>
 <063D6719AE5E284EB5DD2968C1650D6D5F4AB9A0@AcuExch.aculab.com>
 <20160427235151.GA5362@distroguy.com>
In-Reply-To: <20160427235151.GA5362@distroguy.com>
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

RnJvbTogQ2hyaXMgU21hcnQNCj4gU2VudDogMjggQXByaWwgMjAxNiAwMDo1Mg0KLi4uDQo+ID5J
biB0aGF0IGNhc2Ugd2hhdCBhY3R1YWxseSBjb21wbGV0ZXMgdGhlIGNvcHk/DQo+ID5JIHRoaW5r
IHlvdSdkIG5lZWQgdG8gYmUgaW5zaWRlIGEgJ3Jlc3RhcnRhYmxlIGF0b21pYyBzZXF1ZW5jZScN
Cj4gPmluIHdoaWNoIGNhc2UgdGhlIGNwX2Fib3J0IG5lZWQgb25seSBiZSBkb25lIHdoZW4gdGhl
L2EgUkFTDQo+ID5ibG9jayBpcyBkZXRlY3RlZC4NCj4gPg0KPiA+T3IgaGF2ZSBJIG1pc3NlZCBz
b21ldGhpbmc/Pw0KPiANCj4gSXQncyB1cCB0byB0aGUgdXNlcnNwYWNlIHByb2Nlc3MgdGhhdCdz
IGRvaW5nIHRoZSBjb3B5IHBhc3RlIHRvIGNoZWNrDQo+IHRoZSBDUiBmaWVsZCBhZnRlciB0aGUg
cGFzdGUgdG8gc2VlIHdoZXRoZXIgaXQgaGFzIHN1Y2NlZWRlZC4gSWYgaXQgaGFzDQo+IG5vdCBz
dWNjZWVkZWQsIHRoZW4gdGhlIHByb2Nlc3MgY2FuIGNob29zZSB0byByZS1kbyB0aGUgY29weSBh
bmQgcGFzdGUuDQo+DQo+IEhvcGUgdGhhdCBtYWtlcyBzZW5zZS4NCg0KWWVzLCB0aGFua3MuDQoN
CglEYXZpZA0KDQo=
