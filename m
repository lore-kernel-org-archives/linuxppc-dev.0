Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by lists.ozlabs.org (Postfix) with SMTP id 106F11A0057
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Oct 2014 02:15:05 +1100 (AEDT)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 21390-08 for <linuxppc-dev@lists.ozlabs.org>;
 Mon, 27 Oct 2014 15:07:33 +0000 (GMT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'leroy christophe' <christophe.leroy@c-s.fr>, LinuxPPC-dev
 <linuxppc-dev@lists.ozlabs.org>, Scott Wood <scottwood@freescale.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: RE: What is the reel purpose of in_beXX() and out_beXX() fonctions ?
Date: Mon, 27 Oct 2014 15:05:25 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1C9DFACE@AcuExch.aculab.com>
References: <544E3FF6.7090300@c-s.fr>
In-Reply-To: <544E3FF6.7090300@c-s.fr>
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

RnJvbTogbGVyb3kgY2hyaXN0b3BoZQ0KPiBNYW55IGRyaXZlcnMgdXNlIGluX2JlMTYoKSwgaW5f
YmUzMigpLCBvdXRfYmUxNigpLCBvdXRfYmUzMigpLCBldGMgLi4uLg0KPiB0byBhY2Nlc3MgdG8g
cmVnaXN0cmVycyBpbiBJTyBtYXBwZWQgbWVtb3J5Lg0KPiANCj4gV2hhdCBpcyB0aGUgcmVhbCBw
dXJwb3NlIG9mIHRob3NlIGZ1bmN0aW9ucywgYW5kIGFyZSB0aGV5IHJlYWxseSBuZWVkZWQgPw0K
PiANCj4gaW9yZW1hcCgpIG1hcHMgdGhlIHJlbGF0ZWQgYXJlYXMgYXMgR1VBUkRFRCwgd2hpY2gg
bWVhbnMgdGhhdCBhY2Nlc3Nlcw0KPiBjYW4ndCBiZSBzcGVjdWxhdGl2ZS4gU28gd2hhdCBpcyB0
aGUgYmVuZWZpdCBvZiB1c2luZyBpbl9iZVhYKCkgYW5kDQo+IG91dF9iZVhYKCkgb3ZlciBzaW1w
bGUgbWVtb3J5IGFjY2Vzc2VzIGluIHRoZSBhcmVhID8NCg0KU29tZSBhcmNoaXRlY3R1cmVzIG1p
Z2h0IG5lZWQgdG8gdXNlIHNwZWNpZmljIGluc3RydWN0aW9uIHRvIGFjY2Vzcw0KaW8gc3BhY2Ug
KGVnIHNwYXJjIG1pZ2h0IG5lZWQgdG8gc3VwcGx5IGEgc3BlY2lmaWMgJ2FkZHJlc3MgbW9kaWZp
ZXInKS4NCg0KU3BlY2lhbCBpbnN0cnVjdGlvbnMgbWlnaHQgYmUgbmVlZGVkIHRvIHBlcmZvcm0g
YSAnYmlnIGVuZGlhbicgYWNjZXNzLg0KDQpVbmZvcnR1bmF0ZWx5IHRoZSBmdW5jdGlvbnMgc29t
ZXRpbWVzIGNvbnRhaW4gYWRkaXRpb25hbCAob2Z0ZW4gdW5uZWVkZWQpDQpzZXF1ZW5jaW5nIGlu
c3RydWN0aW9ucyAtIHRoZSBkcml2ZXIgbWF5IGJlIGFibGUgdG8gcGVyZm9ybSBtdWx0aXBsZQ0K
b3BlcmF0aW9ucyBiZXR3ZWVuIHRoZSBzZXF1ZW5jaW5nIGluc3RydWN0aW9ucy4NCg0KCURhdmlk
DQoNCg==
