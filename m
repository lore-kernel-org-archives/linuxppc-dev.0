Return-Path: <r39252@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 59FF0B7011
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jun 2012 21:33:44 +1000 (EST)
From: Wrobel Heinz-R39252 <r39252@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Gabriel Paubert
 <paubert@iram.es>
Subject: RE: kernel panic during kernel module load (powerpc specific part)
Date: Fri, 1 Jun 2012 11:33:37 +0000
Message-ID: <192298D25D96A042975E372855100DB70FF0E2@039-SN2MPN1-011.039d.mgd.msft.net>
References: <4FC62FB9.8010701@nsn.com> <1338420242.27402.2.camel@concordia>
 <192298D25D96A042975E372855100DB70FEA87@039-SN2MPN1-011.039d.mgd.msft.net>
 <20120531110439.GA17373@visitor2.iram.es>
 <1338542315.16119.50.camel@pasglop>
In-Reply-To: <1338542315.16119.50.camel@pasglop>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Michael Ellerman <michael@ellerman.id.au>,
 Steffen Rumler <steffen.rumler.ext@nsn.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiA+IEkgYmVsaWV2ZSB0aGF0IHRoZSBiYXNpYyBwcmVtaXNlIGlzIHRoYXQgeW91IHNob3VsZCBw
cm92aWRlIGEgZGlyZWN0bHkNCj4gPiByZWFjaGFibGUgY29weSBvZiB0aGUgc2F2ZS9yc3RvcmUg
ZnVuY3Rpb25zLCBldmVuIGlmIHRoaXMgbWVhbnMgdGhhdA0KPiB5b3UgbmVlZCBzZXZlcmFsIGNv
cGllcyBvZiB0aGUgZnVuY3Rpb25zLg0KPiANCj4gSSBqdXN0IGZpeGVkIGEgdmVyeSBzaW1pbGFy
IHByb2JsZW0gd2l0aCBncnViMiBpbiBmYWN0LiBJdCB3YXMgdXNpbmcgcjANCj4gYW5kIHRyYXNo
aW5nIHRoZSBzYXZlZCBMUiB0aGF0IHdheS4NCj4gDQo+IFRoZSByZWFsIGZpeCBpcyBpbmRlZWQg
dG8gc3RhdGljYWxseSBsaW5rIHRob3NlIGdjYyAiaGVscGVycyIsIHdlDQo+IHNob3VsZG4ndCBn
ZW5lcmF0ZSB0aGluZ3MgbGlrZSBjcm9zcy1tb2R1bGUgY2FsbHMgaW5zaWRlIGZ1bmN0aW9uIHBy
b2xvZ3MNCj4gYW5kIGVwaWxvZ3Vlcywgd2hlbiBzdGFja2ZyYW1lcyBhcmVuJ3QgZXZlbiBndWFy
YW50ZWVkIHRvIGJlIHJlbGlhYmxlLg0KPiANCj4gSG93ZXZlciwgaW4gdGhlIGdydWIyIGNhc2Us
IGl0IHdhcyBlYXNpZXIgdG8ganVzdCB1c2UgcjEyIDotKQ0KDQpGb3Igbm90IGp1c3QgdGhlIG1v
ZHVsZSBsb2FkaW5nIGNhc2UsIEkgYmVsaWV2ZSByMTIgaXMgdGhlIG9ubHkgcmVhbCBzb2x1dGlv
biBub3cuIEkgY2hlY2tlZCBvbmUgZGVidWdnZXIgY2FwYWJsZSBvZiBkb2luZyBFTEYgZG93bmxv
YWQuIEl0IGFsc28gdXNlcyByMTIgZm9yIHRyYW1wb2xpbmUgY29kZS4gSSBhbSBndWVzc2luZyBm
b3IgdGhlIHJlYXNvbiB0aGF0IHByb21wdGVkIHRoaXMgZGlzY3Vzc2lvbi4NCg0KV2l0aG91dCBy
MTIgd2UnZCBoYXZlIHRvIGNoYW5nZSBzdGFuZGFyZCBsaWJyYXJpZXMgdG8gYXV0b21hZ2ljYWxs
eSBsaW5rIGluIGdjYyBoZWxwZXJzIGZvciBhbnkgY29uY2VpdmFibGUgbm9uLS50ZXh0IHNlY3Rp
b24sIHdoaWNoIEkgYW0gbm90IHN1cmUgaXMgZmVhc2libGUuIEhvdyB3b3VsZCB5b3Ugd3JpdGUg
c2VjdGlvbiBpbmRlcGVuZGVudCBoZWxwZXIgZnVuY3Rpb25zIHdoaWNoIGxpbmsgdG8gYW55IHNl
Y3Rpb24gbmVlZGluZyB0aGVtPyENCkFza2luZyB1c2VycyB0byBjcmVhdGUgdGhlaXIgb3duIHNl
Y3Rpb24gc3BlY2lmaWMgY29weSBvZiBoZWxwZXIgZnVuY3Rpb25zIGlzIGRlZmluaXRlbHkgbm90
IHBvcnRhYmxlIGlmIHRoZSBtb2R1bGUgb3Igb3RoZXIgY29kZSBpcyBub3QgYXJjaGl0ZWN0dXJl
IGRlcGVuZGVudC4NCkl0IGlzIGEgbm9ybWFsIGdjYyBmZWF0dXJlIHRoYXQgeW91IGNhbiBhc3Np
Z24gc3BlY2lmaWMgY29kZSB0byBub24tLnRleHQgc2VjdGlvbnMgYW5kIGl0IGlzIG5vdCBkb2N1
bWVudGVkIHRoYXQgaXQgbWF5IGNyYXNoIGRlcGVuZGluZyBvbiB0aGUgT1MgYXJjaCB0aGUgRUxG
IGlzIGJ1aWx0IGZvciwgc28gYXNraW5nIGZvciBhIFBvd2VyIEFyY2hpdGVjdHVyZSBzcGVjaWZp
YyBjaGFuZ2Ugb24gdG9vbCBsaWJzIHRvIG1ha2UgUG93ZXIgQXJjaGl0ZWN0dXJlIExpbnV4IGhh
cHB5IHNlZW1zIGEgYml0IG11Y2ggdG8gYXNrLg0KDQpVc2luZyByMTIgaW4gYW55IExpbnV4IHJl
bGF0ZWQgdHJhbXBvbGluZSBjb2RlIHNlZW1zIGEgcmVhY2hhYmxlIGdvYWwsIGFuZCBpdCB3b3Vs
ZCBlbGltaW5hdGUgdGhlIGNvbmZsaWN0IHRvIHRoZSBBQkkuDQoNClJlZ2FyZHMsDQoNCkhlaW56
DQo=
