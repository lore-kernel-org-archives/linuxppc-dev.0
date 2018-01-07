Return-Path: <Joakim.Tjernlund@infinera.com>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on0067.outbound.protection.outlook.com [104.47.36.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zF6W76xczzF0RH
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Jan 2018 05:34:11 +1100 (AEDT)
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "christophe.leroy@c-s.fr" <christophe.leroy@c-s.fr>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "scottwood@freescale.com"
 <scottwood@freescale.com>, "paulus@samba.org" <paulus@samba.org>,
 "segher@kernel.crashing.org" <segher@kernel.crashing.org>,
 "joakim.tjernlund@transmode.se" <joakim.tjernlund@transmode.se>
Subject: Re: Time to get rid of CPU6 ERRATA on powerpc/8xx ?
Date: Sun, 7 Jan 2018 18:34:07 +0000
Message-ID: <1515350044.32342.37.camel@infinera.com>
References: <26b73379-141c-a705-a552-6ee2b94f4961@c-s.fr>
In-Reply-To: <26b73379-141c-a705-a552-6ee2b94f4961@c-s.fr>
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

T24gU3VuLCAyMDE4LTAxLTA3IGF0IDE3OjIzICswMTAwLCBjaHJpc3RvcGhlIGxlcm95IHdyb3Rl
Og0KPiBDQVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBv
cmdhbml6YXRpb24uIERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVz
cyB5b3UgcmVjb2duaXplIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4N
Cj4gDQo+IA0KPiBUb2RheSwgTGludXgga2VybmVsIGluY2x1ZGVzIGEgd29ya2Fyb3VuZCBmb3Ig
Q1BVNiBFUlJBVEEgb24gdGhlIDh4eA0KPiBwb3dlcnBjLg0KPiANCj4gVGhpcyBFUlJBVEEgZXhp
c3RzIG9uIHRoZSA4MDEsIHRoZSA4MjMsIHRoZSA4NTUvODYwIGJlZm9yZSByZXZpc2lvbiBDLjAN
Cj4gSXQgZG9lc24ndCBjb25jZXJuIGFueSBtb2Rlcm4gdmVyc2lvbnMgb2YgdGhlIDh4eCwgbmVp
dGhlciB0aGUgODYwIHBhc3QNCj4gYW5kIGluY2x1ZGluZyByZXYgQy4wLCBub3IgdGhlIDg2NiBu
b3IgdGhlIDg4NQ0KPiANCj4gVGhpcyB3b3JrYXJvdW5kIGNvbXBsaWNhdGVzIHRoZSBUTEJtaXNz
IGFuZCBUTEJlcnJvciBoYW5kbGVycyBhbmQgbWFrZQ0KPiB0aGUgY29kZSBtb3JlIGFuZCBtb3Jl
IHVucmVhZGFibGUuDQo+IA0KPiBTaW5jZSB0aGlzIHdvcmthcm91bmQgYWRkcmVzc2VzIHZlcnkg
b2xkIHZlcnNpb25zIG9mIHRoZSA4eHgsIEknZCBsaWtlDQo+IHRvIGdldCByaWQgb2YgaXQuIERv
IHlvdSBzZWUgYW55IGdvb2QgcmVhc29uIHRvIGtlZXAgaXQgdG9kYXkgPyBJZiBub3QgSQ0KPiB3
aWxsIGNvbWUgd2l0aCBhIGNsZWFudXAgcGF0Y2ggaW4gdGhlIGNvbWluZyB3ZWVrcy4NCj4gDQo+
IEFub3RoZXIgYWx0ZXJuYXRpdmUgd291bGQgYmUgdG8ga2VlcCB0aGF0IHdvcmthcm91bmQgc2Vw
YXJhdGVkIGZyb20gdGhlDQo+IHJlc3Qgb2YgdGhlIGNvZGUgKGllIHVzaW5nIGRpZmZlcmVudCBy
ZWdpc3RlcnMgdG8gYXZvaWQvbGltaXQgY29kZQ0KPiBuZXN0aW5nKSwgaXQgd291bGQgYWRkIGEg
ZmV3IGN5Y2xlcyBidXQgd291bGQgaW5jcmVhc2UgcmVhZGFiaWxpdHkgd2hpbGUNCj4ga2VlcGlu
ZyB0aGUgRVJSQVRBIGluLCBhbGx0aG91Z2h0IG15IHByZWZlcmVuY2UgZ29lcyB0byBhIGNvbXBs
ZXRlDQo+IHJlbW92YWwgb2YgdGhlIHdvcmthcm91bmQuDQo+IA0KPiBTbywgdGhhbmtzIHRvIGxl
dCBtZSBrbm93IHlvdXIgb3BpbmlvbiBvbiB0aGF0Lg0KDQpIYXZpbmcgZG9uZSB3b3JrIG9uIFRM
QiBNaXNzL0Vycm9yLCBJIGFncmVlIHRoZSBDUFU2IGVycmF0YSBpcyBhIHBhaW4uDQpPbiBhbGwg
b3VyIDh4eCAoODZ4Lzg1MCkgd2UgbmV2ZXIgaGFkIHRvIHVzZSB0aGlzIGVycmF0YSBzbyBJIGFt
IGluIGZhdm91ciBmb3INCnJlbW92aW5nIENQVTYgRXJyYXRhIGZyb20gcmVjZW50IGtlcm5lbHMu
DQoNCiAgSm9ja2UNCg0K
