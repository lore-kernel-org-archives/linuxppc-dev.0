Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 21B552C00DF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2013 22:31:31 +1000 (EST)
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: Jean Delvare <jdelvare@suse.de>
Subject: RE: [PATCH 5/7] rapidio: add modular build option for the subsystem
 core
Date: Fri, 26 Jul 2013 12:17:25 +0000
Message-ID: <8D983423E7EDF846BB3056827B8CC5D14BC3D462@corpmail1.na.ads.idt.com>
References: <1372447136-5751-1-git-send-email-alexandre.bounine@idt.com>
 <1372447136-5751-6-git-send-email-alexandre.bounine@idt.com>
 <1374836454.4361.2.camel@chaos.site>
In-Reply-To: <1374836454.4361.2.camel@chaos.site>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Stef van Os <stef.van.os@Prodrive.nl>,
 Micha Nelissen <micha.nelissen@Prodrive.nl>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andre van Herk <andre.van.herk@Prodrive.nl>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

SGkgSmVhbiwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKZWFuIERl
bHZhcmUgW21haWx0bzpqZGVsdmFyZUBzdXNlLmRlXQ0KPiBTZW50OiBGcmlkYXksIEp1bHkgMjYs
IDIwMTMgNzowMSBBTQ0KDQouLi4gc2tpcCAuLi4uDQoNCj4gQEAgLTIyNDYsMTEgKzIyNDYsMTEg
QEAgc291cmNlICJkcml2ZXJzL3BjbWNpYS9LY29uZmlnIg0KPiA+ICBzb3VyY2UgImRyaXZlcnMv
cGNpL2hvdHBsdWcvS2NvbmZpZyINCj4gPg0KPiA+ICBjb25maWcgUkFQSURJTw0KPiA+IC0JYm9v
bCAiUmFwaWRJTyBzdXBwb3J0Ig0KPiA+ICsJdHJpc3RhdGUgIlJhcGlkSU8gc3VwcG9ydCINCj4g
DQo+IElzIHRoZXJlIGEgcmVhc29uIHdoeSB0aGlzIHdhcyBvbmx5IGRvbmUgZm9yIHg4NiBhbmQg
bm90IGZvciBtaXBzIGFuZA0KPiBwb3dlcnBjPw0KPiANCg0KSSBuZWVkIHRvIG1ha2UgYSBjb25m
aWd1cmF0aW9uIHBhdGNoIGZvciBNSVBTIGFuZCBQb3dlclBDIHBsYXRmb3JtcyB0aGF0IGRlYWxz
DQp3aXRoIGJ1aWx0LWluIFJhcGlkSU8gY29udHJvbGxlcnMgYXZhaWxhYmxlIGluIHNvbWUgZW1i
ZWRkZWQgU29Dcy4NCkZvciBnZW5lcmljIHBsYXRmb3JtcyB3aXRoIFBDSWUgY29udHJvbGxlcnMg
J3RyaXN0YXRlJyBjaGFuZ2VzIHNpbWlsYXIgdG8geDg2IGFyZSBnb29kIGVub3VnaC4NCkkgdGhp
bmsgaXQgd2FzIG1lbnRpb25lZCBpbiBQQVRDSCAwLzcgdGhhdCB3ZSB3aWxsIGhhdmUgYSBmb2xs
b3ctdXAgcGF0Y2ggYSBiaXQgbGF0ZXIuICAgICAgDQoNCj4gPiAgCWRlcGVuZHMgb24gUENJDQo+
ID4gIAlkZWZhdWx0IG4NCj4gPiAgCWhlbHANCj4gPiAtCSAgSWYgeW91IHNheSBZIGhlcmUsIHRo
ZSBrZXJuZWwgd2lsbCBpbmNsdWRlIGRyaXZlcnMgYW5kDQo+ID4gKwkgIElmIGVuYWJsZWQgdGhp
cyBvcHRpb24gd2lsbCBpbmNsdWRlIGRyaXZlcnMgYW5kIHRoZSBjb3JlDQo+ID4gIAkgIGluZnJh
c3RydWN0dXJlIGNvZGUgdG8gc3VwcG9ydCBSYXBpZElPIGludGVyY29ubmVjdCBkZXZpY2VzLg0K
PiA+DQo+IA0KPiAtLQ0KPiBKZWFuIERlbHZhcmUNCj4gU3VzZSBMMw0KDQpBbGV4Lg0KDQo=
