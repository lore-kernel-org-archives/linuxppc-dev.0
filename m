Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wfMFx6gWnzDqMH
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jun 2017 21:20:37 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Benjamin Herrenschmidt' <benh@kernel.crashing.org>, Frederic Barrat
 <fbarrat@linux.vnet.ibm.com>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "mikey@neuling.org" <mikey@neuling.org>, "brking@linux.vnet.ibm.com"
 <brking@linux.vnet.ibm.com>, "clsoto@linux.vnet.ibm.com"
 <clsoto@linux.vnet.ibm.com>
Subject: RE: [PATCH] powerpc/powernv: Enable PCI peer-to-peer
Date: Fri, 2 Jun 2017 11:20:24 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD0007A82@AcuExch.aculab.com>
References: <20170530135818.19291-1-fbarrat@linux.vnet.ibm.com>
 <1496197542.3354.22.camel@kernel.crashing.org>
In-Reply-To: <1496197542.3354.22.camel@kernel.crashing.org>
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

RnJvbTogQmVuamFtaW4gSGVycmVuc2NobWlkdA0KPiBTZW50OiAzMSBNYXkgMjAxNyAwMzoyNg0K
Li4uDQo+IFdlIG1pZ2h0IGFsc28gbmVlZCBhIHdheSB0byBwcm92aWRlIHRoZSAiaW5pdGlhdG9y
IiB3aXRoIHRyYW5zbGF0ZWQgRE1BDQo+IGFkZHJlc3NlcyB0aGF0IGFsbG93IHRvIHRhcmdldCB0
aGUgcmVjZWl2ZXIuDQoNClJlbGF0ZWQgdG8gdGhhdCBpcyB0aGUgYWJpbGl0eSB0byBhbGxvY2F0
ZSBtZW1vcnkgdGhhdCB0d28gKG9yIG1vcmUpDQpQQ0llIGRldmljZXMgY2FuIERNQSB0by9mcm9t
Lg0KVGhhdCBjYW4gYmUgdXNlZnVsIGlmIHBlZXItdG8tcGVlciB0cmFuc2ZlcnMgYXJlIG5vdCBh
dmFpbGFibGUuDQoNCglEYXZpZA0KDQo=
