Return-Path: <B21284@freescale.com>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7AC4BB70AA
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Oct 2010 17:35:33 +1100 (EST)
Received: from mail151-tx2 (localhost.localdomain [127.0.0.1])	by
	mail151-tx2-R.bigfish.com (Postfix) with ESMTP id AD52787806A	for
	<linuxppc-dev@ozlabs.org>; Fri,  8 Oct 2010 06:35:29 +0000 (UTC)
Received: from TX2EHSMHS026.bigfish.com (unknown [10.9.14.253])	by
	mail151-tx2.bigfish.com (Postfix) with ESMTP id 6D727110804C	for
	<linuxppc-dev@ozlabs.org>; Fri,  8 Oct 2010 06:35:29 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
	o986ZSZO004887	for
	<linuxppc-dev@ozlabs.org>; Thu, 7 Oct 2010 23:35:28 -0700 (MST)
Received: from zmy16exm20.fsl.freescale.net (zmy16exm20.ap.freescale.net
	[10.211.3.23])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o986oOOA023438	for <linuxppc-dev@ozlabs.org>;
	Fri, 8 Oct 2010 01:50:25 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: RE: [PATCH v3 3/7] eSPI: add eSPI controller support
Date: Fri, 8 Oct 2010 14:35:50 +0800
Message-ID: <73839B4A0818E747864426270AC332C3057F626D@zmy16exm20.fsl.freescale.net>
In-Reply-To: <20101001112204.GA16783@oksana.dev.rtsoft.ru>
References: <1285833646-12006-1-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-2-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-3-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-4-git-send-email-Mingkai.hu@freescale.com>
	<20101001112204.GA16783@oksana.dev.rtsoft.ru>
From: Hu Mingkai-B21284 <B21284@freescale.com>
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Gala Kumar-B11780 <B11780@freescale.com>,
	linux-mtd@lists.infradead.org, spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW50b24gVm9yb250c292
IFttYWlsdG86Y2JvdWF0bWFpbHJ1QGdtYWlsLmNvbV0NCj4gU2VudDogRnJpZGF5LCBPY3RvYmVy
IDAxLCAyMDEwIDc6MjIgUE0NCj4gVG86IEh1IE1pbmdrYWktQjIxMjg0DQo+IENjOiBsaW51eHBw
Yy1kZXZAb3psYWJzLm9yZzsgc3BpLWRldmVsLWdlbmVyYWxAbGlzdHMuc291cmNlZm9yZ2UubmV0
OyBsaW51eC0NCj4gbXRkQGxpc3RzLmluZnJhZGVhZC5vcmc7IEdhbGEgS3VtYXItQjExNzgwDQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMy83XSBlU1BJOiBhZGQgZVNQSSBjb250cm9sbGVyIHN1
cHBvcnQNCj4gDQo+IEhlbGxvIE1pbmdrYWksDQo+IA0KPiBUaGVyZSBhcmUgbW9zdGx5IGNvc21l
dGljIGNvbW1lbnRzIGRvd24gYmVsb3cuDQo+IA0KPiA+ICsJCS8qIHNwaW4gdW50aWwgVFggaXMg
ZG9uZSAqLw0KPiA+ICsJCXdoaWxlICgoKGV2ZW50cyA9IG1wYzh4eHhfc3BpX3JlYWRfcmVnKCZy
ZWdfYmFzZS0+ZXZlbnQpKQ0KPiA+ICsJCQkJCSYgU1BJRV9ORikgPT0gMCkNCj4gPiArCQkJY3B1
X3JlbGF4KCk7DQo+IA0KPiBUaGlzIGlzIGRhbmdlcm91cy4gVGhlcmUncyBhIGhhbmR5IHNwaW5f
ZXZlbnRfdGltZW91dCgpIGluIGFzbS9kZWxheS5oLg0KPiANCg0KV2hlbiB0aW1lb3V0LCBjYW4g
SSB1c2UgcmV0dXJuIGluIHRoZSBpbnRlcnJ1cHQgZnVuY3Rpb24gZGlyZWN0bHkgbGlrZSB0aGlz
Pw0KDQppZiAoIShldmVudHMgJiBTUElFX05GKSkgew0KICAgICAgICBpbnQgcmV0Ow0KICAgICAg
ICAvKiBzcGluIHVudGlsIFRYIGlzIGRvbmUgKi8NCiAgICAgICAgcmV0ID0gc3Bpbl9ldmVudF90
aW1lb3V0KCgoZXZlbnRzID0gbXBjOHh4eF9zcGlfcmVhZF9yZWcoDQogICAgICAgICAgICAgICAg
ICAgICAgICAmcmVnX2Jhc2UtPmV2ZW50KSkgJiBTUElFX05GKSA9PSAwLCAxMDAwLCAwKTsNCiAg
ICAgICAgaWYgKCFyZXQpIHsNCiAgICAgICAgICAgICAgICBkZXZfZXJyKG1zcGktPmRldiwgInRp
cmVkIHdhaXRpbmcgZm9yIFNQSUVfTkZcbiIpOw0KICAgICAgICAgICAgICAgIHJldHVybjsNCiAg
ICAgICAgfQ0KfQ0KDQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb2Zf
ZGV2aWNlX2lkIG9mX2ZzbF9lc3BpX21hdGNoW10gPSB7DQo+ID4gKwl7IC5jb21wYXRpYmxlID0g
ImZzbCxtcGM4NTM2LWVzcGkiIH0sDQo+ID4gKwl7fQ0KPiA+ICt9Ow0KPiA+ICtNT0RVTEVfREVW
SUNFX1RBQkxFKG9mLCBvZl9mc2xfZXNwaV9tYXRjaCk7DQo+ID4gKw0KPiA+ICtzdGF0aWMgc3Ry
dWN0IG9mX3BsYXRmb3JtX2RyaXZlciBmc2xfZXNwaV9kcml2ZXIgPSB7DQo+ID4gKwkuZHJpdmVy
ID0gew0KPiA+ICsJCS5uYW1lID0gImZzbF9lc3BpIiwNCj4gPiArCQkub3duZXIgPSBUSElTX01P
RFVMRSwNCj4gPiArCQkub2ZfbWF0Y2hfdGFibGUgPSBvZl9mc2xfZXNwaV9tYXRjaCwNCj4gPiAr
CX0sDQo+ID4gKwkucHJvYmUJCT0gb2ZfZnNsX2VzcGlfcHJvYmUsDQo+ID4gKwkucmVtb3ZlCQk9
IF9fZGV2ZXhpdF9wKG9mX2ZzbF9lc3BpX3JlbW92ZSksDQo+ID4gK307DQo+ID4gKw0KPiA+ICtz
dGF0aWMgaW50IF9faW5pdCBmc2xfZXNwaV9pbml0KHZvaWQpIHsNCj4gPiArCXJldHVybiBvZl9y
ZWdpc3Rlcl9wbGF0Zm9ybV9kcml2ZXIoJmZzbF9lc3BpX2RyaXZlcik7DQo+ID4gK30NCj4gPiAr
bW9kdWxlX2luaXQoZnNsX2VzcGlfaW5pdCk7DQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCBfX2V4
aXQgZnNsX2VzcGlfZXhpdCh2b2lkKSB7DQo+ID4gKwlvZl91bnJlZ2lzdGVyX3BsYXRmb3JtX2Ry
aXZlcigmZnNsX2VzcGlfZHJpdmVyKTsNCj4gPiArfQ0KPiA+ICttb2R1bGVfZXhpdChmc2xfZXNw
aV9leGl0KTsNCj4gPiArDQo+ID4gK01PRFVMRV9BVVRIT1IoIk1pbmdrYWkgSHUiKTsNCj4gPiAr
TU9EVUxFX0RFU0NSSVBUSU9OKCJFbmhhbmNlZCBGcmVlc2NhbGUgU1BJIERyaXZlciIpOw0KPiAN
Cj4gVGhpcyBzb3VuZHMgbGlrZSB0aGF0IHRoaXMgaXMgYW4gZW5oYW5jZWQgdmVyc2lvbiBvZiB0
aGUgRnJlZXNjYWxlIFNQSSBkcml2ZXIsDQo+IHdoaWNoIGl0IGlzIG5vdC4gOy0pDQo+IA0KDQpJ
IHF1b3RlZCBmcm9tIHRoZSBVTSwgbWF5YmUgdGhlIGVuaGFuY2VtZW50IGlzIHRoZSBjb250cm9s
bGVyIHRha2VzIG92ZXIgdGhlDQpDUyBzaWduYWwgZnJvbSB0aGUgSFcgcG9pbnQgdmlldy4NCg0K
SSBjaGFuZ2VkIGFsbCB0aGUgb3RoZXIgY29kZSBhY2NvcmRpbmcgdG8geW91ciBjb21tZW50cy4N
Cg0KVGhhbmtzLA0KTWluZ2thaQ0KDQo=
