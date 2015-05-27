Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.187])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ABACD1A0D57
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 18:42:48 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Scott Wood' <scottwood@freescale.com>
CC: 'Christophe Leroy' <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Michael
 Ellerman" <mpe@ellerman.id.au>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] powerpc: add support for csum_add()
Date: Wed, 27 May 2015 08:41:01 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CB40893@AcuExch.aculab.com>
References: <cover.1432047904.git.christophe.leroy@c-s.fr>
 <1d1362c8aa696e316d3ba97dce2342df6f6ee6cf.1432047904.git.christophe.leroy@c-s.fr>
 <063D6719AE5E284EB5DD2968C1650D6D1CB3D471@AcuExch.aculab.com>
 <1432323162.27761.274.camel@freescale.com>
 <063D6719AE5E284EB5DD2968C1650D6D1CB3EB5F@AcuExch.aculab.com>
 <1432669355.7862.16.camel@freescale.com>
In-Reply-To: <1432669355.7862.16.camel@freescale.com>
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

RnJvbTogU2NvdHQgV29vZA0KPiBTZW50OiAyNiBNYXkgMjAxNSAyMDo0Mw0KLi4uDQo+ID4gSSB3
YXMgdGhpbmtpbmcgb2YgYWxsIDY0Yml0IHRhcmdldHMsIG5vdCAzMmJpdCBvbmVzLg0KPiANCj4g
T2gsIHlvdSBtZWFuIG1vdmUgaXQgb3V0IG9mIGFyY2gvcG93ZXJwYz8gIFNvdW5kcyByZWFzb25h
YmxlLCBidXQNCj4gc29tZW9uZSBzaG91bGQgcHJvYmFibHkgY2hlY2sgd2hhdCB0aGUgcmVzdWx0
aW5nIGNvZGUgbG9va3MgbGlrZSBvbg0KPiBvdGhlciBjb21tb24gYXJjaGVzLiAgT1RPSCwgaWYg
d2UncmUgZ29pbmcgdG8gbW9kaWZ5IG5vbi1hcmNoIGNvZGUsDQo+IHRoYXQgbWlnaHQgYmUgYSBn
b29kIG9wcG9ydHVuaXR5IHRvIGltcGxlbWVudCBTZWdoZXIncyBzdWdnZXN0aW9uIGFuZA0KPiBt
b3ZlIHRvIGEgNjQtYml0IGFjY3VtdWxhdG9yLg0KDQpPciBtb3JlIGxpa2VseTogYWRkaW5nIGFs
dGVybmF0ZSAzMmJpdCB3b3JkcyB0byBkaWZmZXJlbnQgNjQtYml0DQpyZWdpc3RlcnMgaW4gb3Jk
ZXIgdG8gcmVkdWNlIHRoZSBkZXBlbmRlbmN5IGNoYWlucyBmdXJ0aGVyLg0KSSdtIHN1cmUgSSd2
ZSBzZWVuIGEgdmVyc2lvbiB0aGF0IGRvZXMgdGhhdCBzb21ld2hlcmUuDQoNCglEYXZpZA0KDQo=
