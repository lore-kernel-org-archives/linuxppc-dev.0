Return-Path: <r61911@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 611AA2C0238
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 May 2013 16:20:53 +1000 (EST)
From: Zang Roy-R61911 <r61911@freescale.com>
To: tiejun.chen <tiejun.chen@windriver.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Subject: RE: SATA FSL and upstreaming
Date: Thu, 16 May 2013 06:20:45 +0000
Message-ID: <3E027F8168735B46AC006B1D0C7BB0020B1E0461@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1368679657.9603.32.camel@pasglop>
 <1368683156.9603.34.camel@pasglop>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0701C307@039-SN2MPN1-012.039d.mgd.msft.net>
 <3E027F8168735B46AC006B1D0C7BB0020B1E040F@039-SN2MPN1-011.039d.mgd.msft.net>
 <1368684547.9603.38 <51947A00.9010504@windriver.com>
In-Reply-To: <51947A00.9010504@windriver.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Liu Qiang-B32616 <B32616@freescale.com>,
 Fleming Andy-AFLEMING <afleming@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Xie Shaohui-B21989 <B21989@freescale.com>,
 Bhushan Bharat-R65777 <R65777@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogdGllanVuLmNoZW4gW21h
aWx0bzp0aWVqdW4uY2hlbkB3aW5kcml2ZXIuY29tXQ0KPiBTZW50OiBUaHVyc2RheSwgTWF5IDE2
LCAyMDEzIDI6MTggUE0NCj4gVG86IEJlbmphbWluIEhlcnJlbnNjaG1pZHQNCj4gQ2M6IFphbmcg
Um95LVI2MTkxMTsgTGl1IFFpYW5nLUIzMjYxNjsgRmxlbWluZyBBbmR5LUFGTEVNSU5HOyBsaW51
eHBwYy0NCj4gZGV2QGxpc3RzLm96bGFicy5vcmc7IFhpZSBTaGFvaHVpLUIyMTk4OTsgQmh1c2hh
biBCaGFyYXQtUjY1Nzc3DQo+IFN1YmplY3Q6IFJlOiBTQVRBIEZTTCBhbmQgdXBzdHJlYW1pbmcN
Cj4gDQo+IE9uIDA1LzE2LzIwMTMgMDI6MDkgUE0sIEJlbmphbWluIEhlcnJlbnNjaG1pZHQgd3Jv
dGU6DQo+ID4gT24gVGh1LCAyMDEzLTA1LTE2IGF0IDA2OjA1ICswMDAwLCBaYW5nIFJveS1SNjE5
MTEgd3JvdGU6DQo+ID4+IEkgZG8gbm90IHN1Z2dlc3QgY2hhbmdpbmcgdGhlIFJDVy4gSWYgdGhl
IFJDVyBpcyBicm9rZW4gb24gQmVuJ3MNCj4gPj4gc2lkZSwgaXQgaXMgbm90IGVhc3kgdG8gcmVj
b3ZlciBmb3IgaGltLg0KPiA+PiBMZXQncyBjaGVjayB0aGUgVS1ib290IG91dHB1dCBmaXJzdC4N
Cj4gPg0KPiA+IFUtQm9vdCAyMDEzLjAxLTAwMDA5LWc3YmNkN2Y0IChNYXIgMTQgMjAxMyAtIDE0
OjIzOjE2KQ0KPiA+DQo+ID4gQ1BVMDogIFA1MDIwRSwgVmVyc2lvbjogMS4wLCAoMHg4MjI4MDAx
MCkNCj4gPiBDb3JlOiAgRTU1MDAsIFZlcnNpb246IDEuMCwgKDB4ODAyNDAwMTApIENsb2NrIENv
bmZpZ3VyYXRpb246DQo+ID4gICAgICAgICBDUFUwOjIwMDAgTUh6LCBDUFUxOjIwMDAgTUh6LA0K
PiA+ICAgICAgICAgQ0NCOjgwMCAgTUh6LA0KPiA+ICAgICAgICAgRERSOjY2Ni42NjcgTUh6ICgx
MzMzLjMzMyBNVC9zIGRhdGEgcmF0ZSkgKEFzeW5jaHJvbm91cyksDQo+IExCQzoxMDAgIE1Ieg0K
PiA+ICAgICAgICAgRk1BTjE6IDYwMCBNSHoNCj4gPiAgICAgICAgIFFNQU46ICA0MDAgTUh6DQo+
ID4gICAgICAgICBQTUU6ICAgNDAwIE1Ieg0KPiA+IEwxOiAgICBELWNhY2hlIDMyIGtCIGVuYWJs
ZWQNCj4gPiAgICAgICAgIEktY2FjaGUgMzIga0IgZW5hYmxlZA0KPiA+IEJvYXJkOiBQNTAyMERT
LCBTeXMgSUQ6IDB4MWMsIFN5cyBWZXI6IDB4MTIsIEZQR0EgVmVyOiAweDA1LCB2QmFuazogMA0K
PiA+IFJlc2V0IENvbmZpZ3VyYXRpb24gV29yZCAoUkNXKToNCj4gPiAgICAgICAgIDAwMDAwMDAw
OiAwYzU0MDAwMCAwMDAwMDAwMCAxZTEyMDAwMCAwMDAwMDAwMA0KPiA+ICAgICAgICAgMDAwMDAw
MTA6IGQ4OTg0YTAxIDAzMDAyMDAwIGRlODAwMDAwIDQxMDAwMDAwDQo+ID4gICAgICAgICAwMDAw
MDAyMDogMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMTAwNzAwMDANCj4gPiAgICAgICAgIDAw
MDAwMDMwOiAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMA0KPiANCj4gSSB0aGlu
ayB5b3UgY2FuIHVzZSBCaGFyYXQncyBSQ1csIHdoaWNoIHNlZW1zIFJSX0hYQVBOU1BfMHgzNiwg
dGhlbg0KPiBwbGVhc2UgdGFrZSBhIGxvb2sgYXQgdGhpczoNCldoeT8NCkJlbidzIG9uIGJvYXJk
IFJDVyBwcm90b2NvbCBpcyAweDM2LCB3aGljaCBzaG91bGQgd29yayBmb3IgUENJZTEgKHNsb3Qg
NykgYW5kIFBDSWUzIChzbG90NCkuDQpSb3kNCg==
