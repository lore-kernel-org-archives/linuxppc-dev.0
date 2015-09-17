Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D37EF1A104D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 19:48:19 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Segher Boessenkool' <segher@kernel.crashing.org>, Michael Ellerman
 <mpe@ellerman.id.au>
CC: Scott Wood <scottwood@freescale.com>, Thomas Gleixner
 <tglx@linutronix.de>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, Steven Rostedt <rostedt@goodmis.org>
Subject: RE: [BUG] Revert 0b05e2d671c4 'powerpc/32: cacheable_memcpy becomes
 memcpy'
Date: Thu, 17 Sep 2015 09:47:39 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CB98ADF@AcuExch.aculab.com>
References: <alpine.DEB.2.11.1509161816310.3951@nanos>
 <1442420984.2909.179.camel@freescale.com>
 <alpine.DEB.2.11.1509162159110.3951@nanos>
 <20150916215435.48bee4d3@grimm.local.home>
 <1442458212.8456.2.camel@ellerman.id.au>
 <20150917031854.GA31437@gate.crashing.org>
In-Reply-To: <20150917031854.GA31437@gate.crashing.org>
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

RnJvbTogU2VnaGVyIEJvZXNzZW5rb29sDQo+IFNlbnQ6IDE3IFNlcHRlbWJlciAyMDE1IDA0OjE5
DQo+IE9uIFRodSwgU2VwIDE3LCAyMDE1IGF0IDEyOjUwOjEyUE0gKzEwMDAsIE1pY2hhZWwgRWxs
ZXJtYW4gd3JvdGU6DQo+ID4gT24gV2VkLCAyMDE1LTA5LTE2IGF0IDIxOjU0IC0wNDAwLCBTdGV2
ZW4gUm9zdGVkdCB3cm90ZToNCj4gPiA+IFRoaXMgY291bGQgYmUgYSBzeW1wdG9tIGFuZCBub3Qg
dGhlIHByb2JsZW0uIFdoYXQgdGhlIGFib3ZlIHNob3dzIGlzDQo+ID4gPiB0aGF0IGZ0cmFjZSB0
cmllZCB0byBjb252ZXJ0IHRoZSBtY291bnQgYXQgY2hhbmdlX3Byb3RlY3Rpb24gYnV0IHdoYXQN
Cj4gPiA+IGl0IGV4cGVjdGVkIHdhcyB0aGVyZSB3YXNuJ3QuIFVuZm9ydHVuYXRlbHksIGl0IGRv
ZXNuJ3Qgc3RhdGUgZXhhY3RseQ0KPiA+ID4gd2hhdCBpdCB3YW50cyAodGhhdCB3b3VsZCB0YWtl
IGEgYXJjaCBzcGVjaWZpYyBmdW5jdGlvbiB0byBkbyB0aGF0LCBhbmQNCj4gPiA+IHRoaXMgaXMg
aW4gZ2VuZXJpYyBjb2RlKS4gQnV0IHdoYXQgaXQgZm91bmQgd2FzICI3NCA2NiA3NCA3MCIsIHdo
aWNoIEkNCj4gPiA+IGhhdmUgbm8gaWRlYSB3aGF0IHR5cGUgb2YgY29tbWFuZCB0aGF0IGlzLg0K
PiA+DQo+ID4gVGhpcyBpcyBiaWcgZW5kaWFuLCBzbyBJIHRoaW5rIHRoYXQnczoNCj4gPg0KPiA+
ICAgYW5kaXMuICByNixyMywyOTgwOA0KPiA+DQo+ID4gV2hpY2ggaXMgZmVhc2libGUuDQo+IA0K
PiBJdCBhbHNvIHNheXMgInRmdHAiLCB3aGljaCBpcyBpbnRyaWd1aW5nIGlmIG5vdGhpbmcgZWxz
ZSA6LSkNCg0KTXVjaCBtb3JlIGxpa2VseSB0aGFuIHRoZSBhYm92ZSBpbnN0cnVjdGlvbi4NCklm
IHRoZSBhZGRyZXNzIGl0IHdhc3MgcmVhZCBmcm9tIGlzIGluIHRoZSBkdW1wLCBsb29rIGF0IHRo
ZSBlbnRpcmUgc3RyaW5nLg0KDQoJRGF2aWQNCg0K
