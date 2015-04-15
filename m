Return-Path: <Igal.Liberman@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0103.outbound.protection.outlook.com [157.56.111.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 025E31A0B8D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 18:43:38 +1000 (AEST)
From: "Igal.Liberman@freescale.com" <Igal.Liberman@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: [v2] dt/bindings: fsl/guts: Added global-utilities compatibles
Date: Wed, 15 Apr 2015 08:43:28 +0000
Message-ID: <DM2PR03MB3837B6B30125C77F1C6F89EE6E50@DM2PR03MB383.namprd03.prod.outlook.com>
References: <1429006329-24597-1-git-send-email-igal.liberman@freescale.com>
 <1429042131.22867.682.camel@freescale.com>
In-Reply-To: <1429042131.22867.682.camel@freescale.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNClJlZ2FyZHMsDQpJZ2FsIExpYmVybWFuLg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+IEZyb206IFdvb2QgU2NvdHQtQjA3NDIxDQo+IFNlbnQ6IFR1ZXNkYXksIEFwcmlsIDE0
LCAyMDE1IDExOjA5IFBNDQo+IFRvOiBMaWJlcm1hbiBJZ2FsLUIzMTk1MA0KPiBDYzogZGV2aWNl
dHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnDQo+IFN1
YmplY3Q6IFJlOiBbdjJdIGR0L2JpbmRpbmdzOiBmc2wvZ3V0czogQWRkZWQgZ2xvYmFsLXV0aWxp
dGllcyBjb21wYXRpYmxlcw0KPiANCj4gT24gVHVlLCAyMDE1LTA0LTE0IGF0IDEzOjEyICswMzAw
LCBJZ2FsLkxpYmVybWFuIHdyb3RlOg0KPiA+IEZyb206IElnYWwgTGliZXJtYW4gPElnYWwuTGli
ZXJtYW5AZnJlZXNjYWxlLmNvbT4NCj4gPg0KPiA+IHYyIC0gQWRkcmVzc2VkIFNjb3R0J3MgZmVl
ZGJhY2sNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IElnYWwgTGliZXJtYW4gPElnYWwuTGliZXJt
YW5AZnJlZXNjYWxlLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3Mv
cG93ZXJwYy9mc2wvZ3V0cy50eHQgICAgICAgfCAgICA0ICsrKysNCj4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9wb3dlcnBjL2ZzbC9ndXRzLnR4dA0KPiBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9wb3dlcnBjL2ZzbC9ndXRzLnR4dA0KPiA+IGluZGV4IDdm
MTUwYjUuLjY5NjQ0ZTYgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3Bvd2VycGMvZnNsL2d1dHMudHh0DQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3Bvd2VycGMvZnNsL2d1dHMudHh0DQo+ID4gQEAgLTksNiArOSwx
MCBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiA+DQo+ID4gICAtIGNvbXBhdGlibGUgOiBTaG91
bGQgZGVmaW5lIHRoZSBjb21wYXRpYmxlIGRldmljZSB0eXBlIGZvcg0KPiA+ICAgICBnbG9iYWwt
dXRpbGl0aWVzLg0KPiA+ICsgICBQb3NzaWJsZSBjb21wYXRpYmxlczoNCj4gPiArCSJmc2wscW9y
aXEtZGV2aWNlLWNvbmZpZy0xLjAiDQo+ID4gKwkiZnNsLHFvcmlxLWRldmljZS1jb25maWctMi4w
Ig0KPiA+ICsJImZzbCw8Y2hpcD4tZGV2aWNlLWNvbmZpZyINCj4gDQo+IGZzbCw8Y2hpcD4tZ3V0
cyBpcyBhbHNvIHBvc3NpYmxlIG9uIG5vbi1jb3JlbmV0IGNoaXBzLg0KPiANCg0KSSBhZGRlZCBj
b21wYXRpYmxlcyB3aGljaCBhcmUgdXNlZCBmb3IgRk1hbiBDbG9jayBvbmx5Lg0KRG8geW91IHdh
bnQgdG8gYWRkIG90aGVyIGNvbXBhdGlibGVzIHRvbz8gV2hpY2g/IE9yIGp1c3QgbWVudGlvbiB0
aGF0IHRoZSAzIGNvbXBhdGlibGVzIEkndmUgYWRkZWQgZG9lc24ndCBjb3ZlciBhbGwgYXZhaWxh
YmxlIG9wdGlvbnM/DQoNCj4gLVNjb3R0DQo+IA0KDQpJZ2FsDQoNCg==
