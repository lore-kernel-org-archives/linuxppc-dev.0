Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v8JqZ0W4NzDq75
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2017 22:00:40 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Anton Blanchard' <anton@samba.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Paul Mackerras" <paulus@samba.org>, "rric@kernel.org" <rric@kernel.org>
CC: "oprofile-list@lists.sf.net" <oprofile-list@lists.sf.net>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: gcc trunk fails to build kernel on PowerPC64 due to oprofile
 warnings
Date: Thu, 26 Jan 2017 11:00:33 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DB026EBC6@AcuExch.aculab.com>
References: <20170126100044.7e439f72@kryten>
In-Reply-To: <20170126100044.7e439f72@kryten>
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

RnJvbTogQW50b24gQmxhbmNoYXJkDQo+IFNlbnQ6IDI1IEphbnVhcnkgMjAxNyAyMzowMQ0KPiBn
Y2MgdHJ1bmsgaGFzIGZhaWxlZCB0byBidWlsZCBQb3dlclBDNjQga2VybmVscyBmb3IgYSBtb250
aCBvciBzby4gVGhlIGlzc3VlDQo+IGlzIGluIG9wcm9maWxlLCB3aGljaCBpcyBjb21tb24gY29k
ZSBidXQgZW5kcyB1cCBiZWluZyBzdWNrZWQgaW50bw0KPiBhcmNoL3Bvd2VycGMgYW5kIHRoZXJl
Zm9yZSBzdWJqZWN0IHRvIHRoZSAtV2Vycm9yIGFwcGxpZWQgdG8gYXJjaC9wb3dlcnBjOg0KLi4u
DQo+IGxpbnV4L2FyY2gvcG93ZXJwYy9vcHJvZmlsZS8uLi8uLi8uLi9kcml2ZXJzL29wcm9maWxl
L29wcm9maWxlX3N0YXRzLmM6NTU6MjU6IGVycm9yOiAlZCBkaXJlY3RpdmUNCj4gb3V0cHV0IG1h
eSBiZSB0cnVuY2F0ZWQgd3JpdGluZyBiZXR3ZWVuIDEgYW5kIDExIGJ5dGVzIGludG8gYSByZWdp
b24gb2Ygc2l6ZSA3IFstV2Vycm9yPWZvcm1hdC0NCj4gdHJ1bmNhdGlvbj1dDQo+ICAgIHNucHJp
bnRmKGJ1ZiwgMTAsICJjcHUlZCIsIGkpOw0KDQpGRlMgdGhlc2Ugd2FybmluZ3MgYXJlIGdldHRp
bmcgT1RULg0KVGhlIGNvbXBpbGVyIG5lZWRzIHRvIGJlIGFibGUgdG8gdHJhY2sgdGhlIGRvbWFp
biBvZiBpbnRlZ2VycyBiZWZvcmUgYXBwbHlpbmcNCnNvbWUgb2YgdGhlc2Ugd2FybmluZ3MuDQoN
CglEYXZpZA0KDQo=
