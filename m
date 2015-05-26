Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.192])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6F0CD1A0FE1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 00:25:20 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Scott Wood' <scottwood@freescale.com>
CC: 'Christophe Leroy' <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Michael
 Ellerman" <mpe@ellerman.id.au>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] powerpc: add support for csum_add()
Date: Tue, 26 May 2015 13:57:32 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CB3EB5F@AcuExch.aculab.com>
References: <cover.1432047904.git.christophe.leroy@c-s.fr>
 <1d1362c8aa696e316d3ba97dce2342df6f6ee6cf.1432047904.git.christophe.leroy@c-s.fr>
 <063D6719AE5E284EB5DD2968C1650D6D1CB3D471@AcuExch.aculab.com>
 <1432323162.27761.274.camel@freescale.com>
In-Reply-To: <1432323162.27761.274.camel@freescale.com>
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

RnJvbTogU2NvdHQgV29vZCAuLi4NCj4gPiBJJ2QgYWxzbyBoYXZlIHRob3VnaHQgdGhhdCB0aGUg
NjRiaXQgQyB2ZXJzaW9uIGFib3ZlIHdvdWxkIGJlIGdlbmVyYWxseSAnZ29vZCcuDQo+IA0KPiBJ
dCBkb2Vzbid0IGdlbmVyYXRlIHRoZSBhZGRjL2FkZHplIHNlcXVlbmNlLiAgQXQgbGVhc3Qgd2l0
aCBHQ0MgNC44LjIsDQo+IGl0IGRvZXMgc29tZXRoaW5nIGxpa2U6DQo+IA0KPiAJbXIJdG1wMCwg
Y3N1bQ0KPiAJbGkJdG1wMSwgMA0KPiAJbGkJdG1wMiwgMA0KPiAJYWRkYwl0bXAzLCBhZGRlbmQs
IHRtcDANCj4gCWFkZGUJY3N1bSwgdG1wMiwgdG1wMQ0KPiAJYWRkCWNzdW0sIGNzdW0sIHRtcDMN
Cg0KSSB3YXMgdGhpbmtpbmcgb2YgYWxsIDY0Yml0IHRhcmdldHMsIG5vdCAzMmJpdCBvbmVzLg0K
DQoJRGF2aWQNCg0K
