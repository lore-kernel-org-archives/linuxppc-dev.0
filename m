Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.183])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0E9691A38D0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 21:45:21 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Christophe Leroy' <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Michael
 Ellerman" <mpe@ellerman.id.au>, "scottwood@freescale.com"
 <scottwood@freescale.com>
Subject: RE: [PATCH v2 0/6] powerpc32: replace memcpy and memset by
 cacheable alternatives
Date: Tue, 19 May 2015 11:43:13 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CB39783@AcuExch.aculab.com>
References: <cover.1432012060.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1432012060.git.christophe.leroy@c-s.fr>
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

RnJvbTogQ2hyaXN0b3BoZSBMZXJveQ0KPiBTZW50OiAxOSBNYXkgMjAxNSAxMTowOA0KPg0KPiBU
aGlzIHBhdGNoc2V0IGltcGxlbWVudHMgdXNlIG9mIGNhY2hlYWJsZSB2ZXJzaW9ucyBvZiBtZW1z
ZXQgYW5kDQo+IG1lbWNweSBzaW5jZSB3aGVuIHRoZSBkZXN0aW5hdGlvbiBpcyBub3QgY2FjaGVh
YmxlLCBtZW1zZXRfaW8NCj4gYW5kIG1lbWNweV90b2lvIGFyZSB1c2VkLg0KDQpUaGlzIGlzbid0
IHRoZSByaWdodCBsaXN0IHRvIGFzaywgYnV0Og0KDQpDYW4gc29tZW9uZSBmaXggdGhlIHg4NiB2
ZXJzaW9ucyBvZiBtZW1zZXQvbWVtY3B5IChhbmQgdGhlIF9pbyB2YXJpYW50cykNCnNvIHRoYXQg
dGhleSBkb24ndCBlbmQgdXAgYmVpbmcgJ3JlcCBtb3ZzYicgb24gbmV3IGludGVsIGNwdXM/DQoN
CkkndmUgYSBDMjU1OCBBdG9tIHdoaWNoIGhhcyB0aGUgb3B0aW1pc2VkICdyZXAgbW92c2InIGhh
cmR3YXJlLg0KQ29waWVzIHRvL2Zyb20gdW5jYWNoZWQgbG9jYXRpb25zIGFyZSBub3cgZG9uZSAn
Ynl0ZSBieSBieXRlJy4NCkFzIHdlbGwgYXMga2VybmVsIGNvZGUgdGhpcyBhZmZlY3RzIHVzZXJw
YWNlIGNvcHlpbmcgdG8vZnJvbQ0KbW1hcCgpZWQgUENJZSBzcGFjZS4NCjY0Yml0IHJlYWRzIGFy
ZSBzbG93IGVub3VnaCwgbWFraW5nIGl0IDggdGltZXMgc2xvd2VyIGlzIGhvcnJpZC4NCg0KSSBz
dXNwZWN0IHRoaXMgYWZmZWN0IHNvbWUgbmV0d29yayBkcml2ZXJzIGFzIHdlbGwuDQoNCglEYXZp
ZA0KDQo=
