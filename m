Return-Path: <roy.pledge@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0124.outbound.protection.outlook.com [65.55.169.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D23941A0429
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jul 2015 06:58:02 +1000 (AEST)
From: Roy Pledge <roy.pledge@freescale.com>
To: Scott Wood <scottwood@freescale.com>, Paul Bolle <pebolle@tiscali.nl>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 02/11] soc/fsl: Introduce DPAA BMan device management
 driver
Date: Fri, 10 Jul 2015 20:57:53 +0000
Message-ID: <BN3PR0301MB12673A340E327986F0BC39E58C9F0@BN3PR0301MB1267.namprd03.prod.outlook.com>
References: <1436473322-21247-1-git-send-email-Roy.Pledge@freescale.com>
 <1436473322-21247-3-git-send-email-Roy.Pledge@freescale.com>
 <1436528160.20619.159.camel@tiscali.nl>
 <1436549595.2658.159.camel@freescale.com>
In-Reply-To: <1436549595.2658.159.camel@freescale.com>
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

PiANCj4gT24gRnJpLCAyMDE1LTA3LTEwIGF0IDEzOjM2ICswMjAwLCBQYXVsIEJvbGxlIHdyb3Rl
Og0KPiA+IE9uIGRvLCAyMDE1LTA3LTA5IGF0IDE2OjIxIC0wNDAwLCBSb3kgUGxlZGdlIHdyb3Rl
Og0KPiA+ID4gKyNpZmRlZiBDT05GSUdfRlNMX0RQQV9DSEVDS0lORw0KPiA+ID4gKyNkZWZpbmUg
RFBBX0FTU0VSVCh4KSBcDQo+ID4gPiArICAgZG8geyBcDQo+ID4gPiArICAgICAgICAgICBpZiAo
ISh4KSkgeyBcDQo+ID4gPiArICAgICAgICAgICAgICAgICAgIHByX2NyaXQoIkFTU0VSVDogKCVz
OiVkKSAlc1xuIiwgX19GSUxFX18sIF9fTElORV9fLCBcDQo+ID4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgX19zdHJpbmdpZnlfMSh4KSk7IFwNCj4gPiA+ICsgICAgICAgICAgICAgICAg
ICAgZHVtcF9zdGFjaygpOyBcDQo+ID4gPiArICAgICAgICAgICAgICAgICAgIHBhbmljKCJhc3Nl
cnRpb24gZmFpbHVyZSIpOyBcDQo+ID4NCj4gPiBOb3QgbXkgY2FsbCwgYnV0IHdoeSBwYW5pYygp
IGhlcmU/DQo+IA0KPiBJJ20gcHJldHR5IHN1cmUgSSd2ZSBjb21wbGFpbmVkIGFib3V0IHRoaXMg
YmVmb3JlIChhcyB3ZWxsIGFzIGFsbCB0aGUNCj4gQlVHX09OcykuDQo+IA0KSXMgdGhlIGNvbmNl
cm4gaGVyZSBqdXN0IHRoZSBjYWxsIHRvIHBhbmljKCk/ICBJJ20gaGFwcHkgdG8gY2hhbmdlIHdo
YXQgaGFwcGVucyB3aGVuIGFuIGlzc3VlIGlzIGRldGVjdGVkIGJ1dCB0aGUgRFBBX0FTU0VSVCgp
IGNhbGxzIGFyZSB2ZXJ5IHVzZWZ1bCB3aGVuIHRlc3RpbmcgY2hhbmdlcyB0byB0aGUgZHJpdmVy
IGFuZCB3aGVuIGJyaW5naW5nIHVwIHRoZSBkcml2ZXJzIG9uIG5ldyBzaWxpY29uIHZhcmlhbnRz
LiANCg==
