Return-Path: <B48286@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0138.outbound.protection.outlook.com [207.46.100.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 076541A0153
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 19:26:09 +1000 (AEST)
From: Hou Zhiqiang <B48286@freescale.com>
To: Hou Zhiqiang <B48286@freescale.com>, "galak@kernel.crashing.org"
 <galak@kernel.crashing.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, Scott Wood <scottwood@freescale.com>
CC: Hu Vincent <Mingkai.Hu@freescale.com>, Wang Dongsheng
 <Dongsheng.Wang@freescale.com>
Subject: RE: [PATCH V2] powerpc/85xx: Remove unused pci fixup hooks on c293pcie
Date: Tue, 18 Aug 2015 09:26:03 +0000
Message-ID: <CY1PR0301MB0780D0F57AED04231C73C3438B780@CY1PR0301MB0780.namprd03.prod.outlook.com>
References: <1439199585-37464-1-git-send-email-B48286@freescale.com>
In-Reply-To: <1439199585-37464-1-git-send-email-B48286@freescale.com>
Content-Type: text/plain; charset="gb2312"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

SGkgU2NvdHQsDQoNClJlbW92ZWQgYm90aCBwY2liaW9zX2ZpeHVwX3BoYiBhbmQgcGNpYmlvc19m
aXh1cF9idXMuDQpDb3VsZCB5b3UgcGxlYXNlIGhlbHAgdG8gYXBwbHkgaXQ/DQoNCj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWmhpcWlhbmcgSG91IFttYWlsdG86QjQ4Mjg2
QGZyZWVzY2FsZS5jb21dDQo+IFNlbnQ6IDIwMTXE6jjUwjEwyNUgMTc6NDANCj4gVG86IGdhbGFr
QGtlcm5lbC5jcmFzaGluZy5vcmc7IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnOyBXb29k
IFNjb3R0LQ0KPiBCMDc0MjENCj4gQ2M6IEh1IE1pbmdrYWktQjIxMjg0OyBXYW5nIERvbmdzaGVu
Zy1CNDA1MzQ7IEhvdSBaaGlxaWFuZy1CNDgyODYNCj4gU3ViamVjdDogW1BBVENIIFYyXSBwb3dl
cnBjLzg1eHg6IFJlbW92ZSB1bnVzZWQgcGNpIGZpeHVwIGhvb2tzIG9uDQo+IGMyOTNwY2llDQo+
IA0KPiBGcm9tOiBIb3UgWmhpcWlhbmcgPEI0ODI4NkBmcmVlc2NhbGUuY29tPg0KPiANCj4gVGhl
IGMyOTNwY2llIGJvYXJkIGlzIGFuIGVuZHBvaW50IGRldmljZSBhbmQgaXQgZG9lc24ndCBuZWVk
IFBNLCBzbw0KPiByZW1vdmUgaG9va3MgcGNpYmlvc19maXh1cF9waGIgYW5kIHBjaWJpb3NfZml4
dXBfYnVzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSG91IFpoaXFpYW5nIDxCNDgyODZAZnJlZXNj
YWxlLmNvbT4NCj4gLS0tDQo+IFRlc3Qgb24gYzI5M3BjaWUgYm9hcmQ6DQo+IFYyOg0KPiAgICAg
UmVuYW1lIHRoZSB0aXRsZSBvZiB0aGlzIHBhdGNoLg0KPiAgICAgUmVtb3ZlIHBjaWJpb3NfZml4
dXBfYnVzIHRoYXQgaXNuJ3QgdXNlZCBpbiBFUC4NCj4gDQo+ICBhcmNoL3Bvd2VycGMvcGxhdGZv
cm1zLzg1eHgvYzI5M3BjaWUuYyB8IDQgLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy84NXh4L2My
OTNwY2llLmMNCj4gYi9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zLzg1eHgvYzI5M3BjaWUuYw0KPiBp
bmRleCA4NDQ3NmI2Li42MWJjODUxIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3Bvd2VycGMvcGxhdGZv
cm1zLzg1eHgvYzI5M3BjaWUuYw0KPiArKysgYi9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zLzg1eHgv
YzI5M3BjaWUuYw0KPiBAQCAtNjYsMTAgKzY2LDYgQEAgZGVmaW5lX21hY2hpbmUoYzI5M19wY2ll
KSB7DQo+ICAJLnByb2JlCQkJPSBjMjkzX3BjaWVfcHJvYmUsDQo+ICAJLnNldHVwX2FyY2gJCT0g
YzI5M19wY2llX3NldHVwX2FyY2gsDQo+ICAJLmluaXRfSVJRCQk9IGMyOTNfcGNpZV9waWNfaW5p
dCwNCj4gLSNpZmRlZiBDT05GSUdfUENJDQo+IC0JLnBjaWJpb3NfZml4dXBfYnVzCT0gZnNsX3Bj
aWJpb3NfZml4dXBfYnVzLA0KPiAtCS5wY2liaW9zX2ZpeHVwX3BoYiAgICAgID0gZnNsX3BjaWJp
b3NfZml4dXBfcGhiLA0KPiAtI2VuZGlmDQo+ICAJLmdldF9pcnEJCT0gbXBpY19nZXRfaXJxLA0K
PiAgCS5yZXN0YXJ0CQk9IGZzbF9yc3Rjcl9yZXN0YXJ0LA0KPiAgCS5jYWxpYnJhdGVfZGVjcgkJ
PSBnZW5lcmljX2NhbGlicmF0ZV9kZWNyLA0KPiAtLQ0KPiAyLjEuMC4yNy5nOTZkYjMyNA0KDQpU
aGFua3MsDQpaaGlxaWFuZw0KDQo=
