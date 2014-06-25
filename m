Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by lists.ozlabs.org (Postfix) with SMTP id 0FC7F1A0008
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 18:45:32 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 26764-07 for <linuxppc-dev@lists.ozlabs.org>;
 Wed, 25 Jun 2014 09:45:21 +0100 (BST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Zhao Qiang' <B45475@freescale.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "broonie@kernel.org" <broonie@kernel.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "B07421@freescale.com" <B07421@freescale.com>
Subject: RE: [PATCH] spi: include "int ret" with macro
Date: Wed, 25 Jun 2014 08:44:49 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D17264A4B@AcuExch.aculab.com>
References: <1403661276-16598-1-git-send-email-B45475@freescale.com>
In-Reply-To: <1403661276-16598-1-git-send-email-B45475@freescale.com>
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

RnJvbTogWmhhbyBRaWFuZw0KPiByZXQgaXMgdW51c2VkIHdoZW4gQ09ORklHX0ZTTF9TT0MgZGVm
aW5lZCwNCj4gc28gaW5jbHVkZSBpdCB3aXRoICIjaWZuZGVmIENPTkZJR19GU0xfU09DIi4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IFpoYW8gUWlhbmcgPEI0NTQ3NUBmcmVlc2NhbGUuY29tPg0KPiAt
LS0NCj4gIGRyaXZlcnMvc3BpL3NwaS1mc2wtbGliLmMgfCAzICsrLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvc3BpL3NwaS1mc2wtbGliLmMgYi9kcml2ZXJzL3NwaS9zcGktZnNsLWxpYi5jDQo+IGlu
ZGV4IGU1ZDQ1ZmMuLjQ0YWFjZTEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc3BpL3NwaS1mc2wt
bGliLmMNCj4gKysrIGIvZHJpdmVycy9zcGkvc3BpLWZzbC1saWIuYw0KPiBAQCAtMTk4LDggKzE5
OCw5IEBAIGludCBvZl9tcGM4eHh4X3NwaV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpv
ZmRldikNCj4gIAlzdHJ1Y3QgbXBjOHh4eF9zcGlfcHJvYmVfaW5mbyAqcGluZm87DQo+ICAJc3Ry
dWN0IGZzbF9zcGlfcGxhdGZvcm1fZGF0YSAqcGRhdGE7DQo+ICAJY29uc3Qgdm9pZCAqcHJvcDsN
Cj4gKyNpZm5kZWYgQ09ORklHX0ZTTF9TT0MNCj4gIAlpbnQgcmV0ID0gLUVOT01FTTsNCj4gLQ0K
PiArI2VuZGlmDQoNCllvdSBhcmUgcmVtb3ZpbmcgdGhlIGJsYW5rIGxpbmUgYWZ0ZXIgdGhlIGRl
ZmluaXRpb24gb2YgdGhlIGxvY2FscywNCmFuZCB0aGUgaW5pdGlhbGlzZXIgaXNuJ3QgbmVlZGVk
Lg0KDQo+ICAJcGluZm8gPSBkZXZtX2t6YWxsb2MoJm9mZGV2LT5kZXYsIHNpemVvZigqcGluZm8p
LCBHRlBfS0VSTkVMKTsNCj4gIAlpZiAoIXBpbmZvKQ0KPiAgCQlyZXR1cm4gLUVOT01FTTsNCj4g
LS0NCg0KSSB0aGluayBpdCBtaWdodCBiZSBwcmVmZXJhYmxlIHRvIGRlZmluZSAncmV0JyBpbnNp
ZGUgdGhlIGNvbmRpdGlvbmFsDQp3aGVyZSBpdCBpcyB1c2VkIC0gd2hpY2ggcmVxdWlyZXMgYW4g
ZXh0cmEgey4uLn0gYmxvY2suDQoNCkEgJ3NuZWFreScgd2F5IHRvIGF2b2lkIHRoZSB3YXJuaW5n
IGlzIHRvICdyZXR1cm4gcmV0JyB3aGVuIHRoZSBremFsbG9jKCkgZmFpbHMuDQoNCglEYXZpZA0K
DQoNCg==
