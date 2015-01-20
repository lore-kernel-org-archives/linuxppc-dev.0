Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.184])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 585641A0CFB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 22:44:13 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'leroy christophe' <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Michael
 Ellerman" <mpe@ellerman.id.au>, "scottwood@freescale.com"
 <scottwood@freescale.com>
Subject: RE: [PATCH v2 07/11] powerpc/8xx: macro for handling CPU15 errata
Date: Tue, 20 Jan 2015 11:43:16 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CACF0E4@AcuExch.aculab.com>
References: <20150120095735.A55671A5E86@localhost.localdomain>
 <063D6719AE5E284EB5DD2968C1650D6D1CACEFD9@AcuExch.aculab.com>
 <54BE3CD7.4040208@c-s.fr>
In-Reply-To: <54BE3CD7.4040208@c-s.fr>
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

RnJvbTogbGVyb3kgDQo+IExlIDIwLzAxLzIwMTUgMTI6MDksIERhdmlkIExhaWdodCBhIMOpY3Jp
dCA6DQo+ID4gIEZyb20gQ2hyaXN0b3BoZSBMZXJveQ0KPiA+PiBIYXZpbmcgYSBtYWNybyB3aWxs
IGhlbHAga2VlcCBjbGVhciBjb2RlLg0KPiA+IEl0IG1pZ2h0IHJlbW92ZSBhbiAjaWYgYnV0IGl0
IGRvZXNuJ3QgcmVhbGx5IGhlbHAuDQo+ID4gQWxsIGl0IG1lYW5zIGlzIHRoYXQgYW55b25lIHJl
YWRpbmcgdGhlIGNvZGUgaGFzIHRvIGh1bnQgZm9yDQo+ID4gdGhlIGRlZmluaXRpb24gYmVmb3Jl
IHByb2NlZWRpbmcuDQo+ID4NCj4gPiBTb21lIGNvbW1lbnQgYWJvdXQgd2hhdCAoYW5kIHdoeSkg
dGhlIGV4dHJhIGNvZGUgaXMgbmVlZGVkDQo+ID4gbWlnaHQgaGVscC4NCj4gVGhlIG1haW4gcmVh
c29uIGlzIGJlY2F1c2Ugb2YgcGF0Y2ggMDkvMTEgd2hlcmUgd2UgaGF2ZSB0byBkdXBsaWNhdGUN
Cj4gdGhpcyBjb2RlLiBJIHByZWZlciB0byBqdXN0IGR1cGxpY2F0ZSBvbmUgbGluZSByYXRoZXIg
dGhhbiBkdXBsaWNhdGUgdGhlDQo+IHdob2xlIGNvZGUgKGVzcGVjaWFsbHkgYmVjYXVzZSBpbiB2
MSBvZiB0aGUgUEFUQ0hzZXQsIGl0IHdhcyBkdXBsaWNhdGVkDQo+IHR3aWNlKToNCj4gDQo+IC0g
ICAgRE9fOHh4X0NQVTE1KHIxMSwgcjEwKQ0KPiBbLi4uXQ0KPiAjaWZkZWYgQ09ORklHX01PRFVM
RVMNCj4gWy4uLl0NCj4gKyAgICBET184eHhfQ1BVMTUocjEwLCByMTEpDQo+IFsuLi5dDQo+ICsj
ZWxzZQ0KPiArICAgIG1mc3ByICAgIHIxMCwgU1BSTl9TUlIwICAgIC8qIEdldCBlZmZlY3RpdmUg
YWRkcmVzcyBvZiBmYXVsdCAqLw0KPiArICAgIERPXzh4eF9DUFUxNShyMTEsIHIxMCkNCj4gDQo+
IElzIHRoaXMgYXBwcm9hY2ggd3JvbmcgPw0KDQpJJ2QgY2FsbCBpdCBzb21ldGhpbmcgdGhhdCBp
bmZlcnMgJ2ludmFsaWRhdGUgYWRqYWNlbnQgcGFnZXMnDQphbmQgdGhlbiBtZW50aW9uIHRoYXQg
dGhpcyBpcyBuZWVkZWQgZHVlIHRvIGEgY3B1IGVycmF0YS4NCg0KCURhdmlkDQoNCg==
