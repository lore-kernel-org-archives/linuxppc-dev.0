Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.185])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 85ED91A0145
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2015 00:47:58 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Scott Wood' <scottwood@freescale.com>
CC: 'Christophe Leroy' <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Michael
 Ellerman" <mpe@ellerman.id.au>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 08/25] powerpc/8xx: Map IMMR area with 512k page at a
 fixed address
Date: Fri, 25 Sep 2015 14:46:40 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CBA2CBE@AcuExch.aculab.com>
References: <cover.1442939410.git.christophe.leroy@c-s.fr>
 <bfa8400abd8b5174942616aae5876a55242f5468.1442939410.git.christophe.leroy@c-s.fr>
 <063D6719AE5E284EB5DD2968C1650D6D1CBA15B8@AcuExch.aculab.com>
 <1443125663.32298.32.camel@freescale.com>
In-Reply-To: <1443125663.32298.32.camel@freescale.com>
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

RnJvbTogU2NvdHQgV29vZA0KPiBTZW50OiAyNCBTZXB0ZW1iZXIgMjAxNSAyMToxNA0KPiA+IElz
bid0IHRoaXMgYSBtb3JlIGdlbmVyYWwgcHJvYmxlbT8NCj4gPg0KPiA+IElmIHRoZXJlIGFyZSBt
dWx0aXBsZSByZW1hcCByZXF1ZXN0cyBmb3IgdGhlIHNhbWUgcGh5c2ljYWwgcGFnZQ0KPiA+IHNo
b3VsZG4ndCB0aGUga2VybmVsIGJlIGp1c3QgaW5jcmVhc2luZyBhIHJlZmVyZW5jZSBjb3VudCBz
b21ld2hlcmUNCj4gPiBhbmQgcmV0dXJuaW5nIGFkZHJlc3MgaW4gdGhlIHNhbWUgdmlydHVhbCBw
YWdlPw0KPiA+IFRoaXMgc2hvdWxkIHByb2JhYmx5IGhhcHBlbiByZWdhcmRsZXNzIG9mIHRoZSBh
ZGRyZXNzLg0KPiA+IEkgcHJlc3VtZSBpdCBtdXN0IGJlIGRvbmUgZm9yIGNhY2hlYWJsZSBtYXBw
aW5ncy4NCj4gDQo+IFdoeSB3b3VsZCB5b3UgYXNzdW1lIHRoYXQ/DQoNCkJlY2F1c2UgJ3JlYWxs
eSBob3JyaWQgKHRtKScgdGhpbmdzIGhhcHBlbiBvbiBzb21lIGNhY2hlDQphcmNoaXRlY3R1cmVz
IGlmIHlvdSBtYXAgdGhlIHNhbWUgcGh5c2ljYWwgYWRkcmVzcyB0bw0KbXVsdGlwbGUgdmlydHVh
bCBhZGRyZXNzZXMuDQoNCglEYXZpZA0KDQo=
