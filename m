Return-Path: <laurentiu.tudor@nxp.com>
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00067.outbound.protection.outlook.com [40.107.0.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vykfL0706zDqLS
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Apr 2017 21:49:45 +1000 (AEST)
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: Michael Ellerman <mpe@ellerman.id.au>, =?utf-8?B?SG9yaWEgR2VhbnTEgw==?=
 <horia.geanta@nxp.com>, Herbert Xu <herbert@gondor.apana.org.au>, Scott Wood
 <oss@buserror.net>, Roy Pledge <roy.pledge@nxp.com>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Cristian Stoica
 <cristian.stoica@nxp.com>, Dan Douglass <dan.douglass@nxp.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Vakul Garg <vakul.garg@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "David S.
 Miller" <davem@davemloft.net>, Alexandru Porosanu
 <alexandru.porosanu@nxp.com>, "linux-crypto@vger.kernel.org"
 <linux-crypto@vger.kernel.org>
Subject: Re: [7/7] crypto: caam/qi - add ablkcipher and authenc algorithms
Date: Wed, 5 Apr 2017 11:49:24 +0000
Message-ID: <58E4D9C3.4070406@nxp.com>
References: <20170317100602.2837-8-horia.geanta@nxp.com>
 <87vaqkvk6c.fsf@concordia.ellerman.id.au> <58E39F90.6050408@nxp.com>
 <87lgrftbgl.fsf@concordia.ellerman.id.au>
In-Reply-To: <87lgrftbgl.fsf@concordia.ellerman.id.au>
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

DQoNCk9uIDA0LzA1LzIwMTcgMDE6MDYgUE0sIE1pY2hhZWwgRWxsZXJtYW4gd3JvdGU6DQo+IExh
dXJlbnRpdSBUdWRvciA8bGF1cmVudGl1LnR1ZG9yQG54cC5jb20+IHdyaXRlczoNCj4NCj4+IEhp
IE1pY2hhZWwsDQo+Pg0KPj4gSnVzdCBhIGNvdXBsZSBvZiBiYXNpYyB0aGluZ3MgdG8gY2hlY2s6
DQo+PiAgICAtIHdhcyB0aGUgZHRiIHVwZGF0ZWQgdG8gdGhlIG5ld2VzdD8NCj4NCj4gUG9zc2li
bHkgbm90LCBpdCdzIGFuIGF1dG9tYXRlZCBidWlsZC9ib290LCBJJ2xsIGhhdmUgdG8gY2hlY2sg
d2hhdCBpdA0KPiBkb2VzIHdpdGggdGhlIGR0Yi4NCj4NCj4+ICAgIC0gaXMgdGhlIHFtYW4gbm9k
ZSBwcmVzZW50PyBUaGlzIHNob3VsZCBiZSBlYXNpbHkgdmlzaWJsZSBpbg0KPj4gL3Byb2MvZGV2
aWNlLXRyZWUvc29jQGZmZTAwMDAwMC9xbWFuQDMxODAwMC4NCj4NCj4gTm8gaXQncyBub3QgdGhl
cmUuDQo+DQo+IFRoYXQncyBydW5uaW5nIGxpbnV4LW5leHQgd2l0aDoNCj4NCj4gQ09ORklHX0NS
WVBUT19ERVZfRlNMX0NBQU1fQ1JZUFRPX0FQSV9RST1uDQo+DQo+DQo+IERvZXMgdGhhdCBtZWFu
IEkgZGlkbid0IHVwZGF0ZSB0aGUgZGV2aWNlIHRyZWU/DQo+DQoNCkkgdGhpbmsgc28uIEFsc28s
IEkganVzdCBjaGVja2VkIHRoYXQgdGhlIG5vZGUgaXMgYWN0dWFsbHkgdGhlcmUgYnkgDQpjb21w
aWxpbmcgcDUwMjBkcy5kdHMgYW5kIHRoZW4gZGVjb21waWxpbmcgdGhlIGR0Yi4NCg0KLS0tDQpC
ZXN0IFJlZ2FyZHMsIExhdXJlbnRpdQ==
