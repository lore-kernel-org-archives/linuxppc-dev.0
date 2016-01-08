Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.189])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9D7271A01E3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jan 2016 21:17:41 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Michael Ellerman' <mpe@ellerman.id.au>, Brian Norris
 <computersforpeace@gmail.com>, Ian Munsie <imunsie@au1.ibm.com>
CC: Michael Neuling <mikey@neuling.org>, Arnd Bergmann <arnd@arndb.de>,
 "Anton Blanchard" <anton@au1.ibm.com>, linux-kernel
 <linux-kernel@vger.kernel.org>, Michal Marek <mmarek@suse.com>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, Daniel Axtens <dja@axtens.net>
Subject: RE: Build failure: -Wno-unused-const-variable DNE on old GCC
Date: Fri, 8 Jan 2016 10:14:52 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CCC0040@AcuExch.aculab.com>
References: <20160107185406.GA65420@google.com>
 <10821353.mAlCTdTQBC@wuerfel> <87oacx6m14.fsf@gamma.ozlabs.ibm.com>
 <20160107230225.GA126548@google.com>
 <1452216163-sup-7558@delenn.ozlabs.ibm.com>
 <20160108020743.GA118336@google.com>
 <1452219390.18702.2.camel@ellerman.id.au>
In-Reply-To: <1452219390.18702.2.camel@ellerman.id.au>
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

RnJvbTogTWljaGFlbCBFbGxlcm1hbg0KPiBTZW50OiAwOCBKYW51YXJ5IDIwMTYgMDI6MTcNCj4g
PiBJIGRvdWJ0IHlvdSBwbGFuIHRvIGZpeCBhbGwgdGhvc2UuIFNvIG1ha2luZyAtV2Vycm9yIGNv
bmZpZ3VyYWJsZSBzZWVtcyBsaWtlDQo+ID4gdGhlIG9ubHkgd2F5IGZvcndhcmQsIHRoZW4uIChH
bGFkIHlvdSBhZ3JlZWQhKQ0KPiANCj4gWWVwLCBJJ20gaGFwcHkgdG8gbWFrZSBXZXJyb3IgY29u
ZmlndXJhYmxlLg0KPiANCj4gY3hsIGNhbiBwcm9iYWJseSBqdXN0IHVzZSB0aGUgZXhpc3Rpbmcg
UFBDX1dFUlJPUi4NCg0KUGVyc29uYWxseSBJIHRoaW5rIHRoZSBkZXZlbG9wbWVudCBidWlsZHMg
c2hvdWxkIGJlIGRvbmUgd2l0aA0KYm90aCBlcnJvciAtV2Vycm9yIGFuZCBoaWdoZXIgbGV2ZWxz
IG9mIHdhcm5pbmdzLCBldmVuIGlmIHRoZQ0Kb25lcyB0aGF0IHVzZXJzIHRlbmQgdG8gZG8gaWdu
b3JlIG1vcmUgd2FybmluZ3MuDQoNCkNsZWFybHkgc29tZSB3YXJuaW5ncyB0aGF0IHNvbWUgdmVy
c2lvbnMgb2YgZ2NjIGhhdmUgaW5jbHVkZWQNCmluIC1XYWxsIGFyZSBqdXN0IGEgUElUQSAobGlr
ZSB3YXJuaW5nIGZvciBfX0RBVEVfXyBhbmQgX19USU1FX18pLg0KDQpUaGUga2VybmVsIGhlYWRl
cnMgZG8gbmVlZCBmaXhpbmcgc28gdGhhdCB0aGV5IHBhc3MgY29tcGlsYXRpb24NCndpdGggb3B0
aW9ucyBsaWtlIC1Xd3JpdGUtc3RyaW5ncyAobGludXgvbW0uaCBkb2Vzbid0KS4NCg0KCURhdmlk
DQoNCg==
