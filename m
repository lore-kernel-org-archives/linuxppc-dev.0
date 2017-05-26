Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.192])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wZBFQ2fNFzDqVD
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 May 2017 02:20:41 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Michael Ellerman' <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, christophe leroy <christophe.leroy@c-s.fr>
CC: Scott Wood <oss@buserror.net>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH 3/3] powerpc/8xx: xmon compile fix
Date: Fri, 26 May 2017 16:20:33 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD0000223@AcuExch.aculab.com>
References: <20170511151522.4772-1-npiggin@gmail.com>
 <20170511151522.4772-3-npiggin@gmail.com>
 <b84f2d89-fc2f-d25f-1871-8fcd7b133fcf@c-s.fr>
 <fdb9e787-e397-a46e-467c-066d51d73131@c-s.fr>
 <20170512104707.5393eaa1@roar.ozlabs.ibm.com>
 <87o9ug84ia.fsf@concordia.ellerman.id.au>
In-Reply-To: <87o9ug84ia.fsf@concordia.ellerman.id.au>
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

RnJvbTogIE1pY2hhZWwgRWxsZXJtYW4NCj4gU2VudDogMjYgTWF5IDIwMTcgMDg6MjQNCj4gTmlj
aG9sYXMgUGlnZ2luIDxucGlnZ2luQGdtYWlsLmNvbT4gd3JpdGVzOg0KPiA+IGRpZmYgLS1naXQg
YS9hcmNoL3Bvd2VycGMveG1vbi94bW9uLmMgYi9hcmNoL3Bvd2VycGMveG1vbi94bW9uLmMNCj4g
PiBpbmRleCBmMTFmNjU2MzRhYWIuLjQzOGZkYjBmYjE0MiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNo
L3Bvd2VycGMveG1vbi94bW9uLmMNCj4gPiArKysgYi9hcmNoL3Bvd2VycGMveG1vbi94bW9uLmMN
Cj4gPiBAQCAtMTI0MiwxNCArMTI0MiwxNiBAQCBicHRfY21kcyh2b2lkKQ0KPiA+ICB7DQo+ID4g
IAlpbnQgY21kOw0KPiA+ICAJdW5zaWduZWQgbG9uZyBhOw0KPiA+IC0JaW50IG1vZGUsIGk7DQo+
ID4gKwlpbnQgaTsNCj4gPiAgCXN0cnVjdCBicHQgKmJwOw0KPiA+IC0JY29uc3QgY2hhciBiYWRh
ZGRyW10gPSAiT25seSBrZXJuZWwgYWRkcmVzc2VzIGFyZSBwZXJtaXR0ZWQgIg0KPiA+IC0JCSJm
b3IgYnJlYWtwb2ludHNcbiI7DQo+ID4NCj4gPiAgCWNtZCA9IGluY2hhcigpOw0KPiA+ICAJc3dp
dGNoIChjbWQpIHsNCj4gPiAtI2lmbmRlZiBDT05GSUdfOHh4DQo+ID4gKyNpZm5kZWYgQ09ORklH
X1BQQ184eHgNCj4gPiArCWludCBtb2RlOw0KPiA+ICsJY29uc3QgY2hhciBiYWRhZGRyW10gPSAi
T25seSBrZXJuZWwgYWRkcmVzc2VzIGFyZSBwZXJtaXR0ZWQgIg0KPiA+ICsJCSJmb3IgYnJlYWtw
b2ludHNcbiI7DQo+ID4gKw0KPiA+ICAJY2FzZSAnZCc6CS8qIGJkIC0gaGFyZHdhcmUgZGF0YSBi
cmVha3BvaW50ICovDQo+ID4gIAkJbW9kZSA9IDc7DQo+ID4gIAkJY21kID0gaW5jaGFyKCk7DQo+
IA0KPiBHQ0MgNyByZWplY3RzIHRoaXM6DQo+IA0KPiAgIGFyY2gvcG93ZXJwYy94bW9uL3htb24u
YzogSW4gZnVuY3Rpb24gYnB0X2NtZHM6DQo+ICAgYXJjaC9wb3dlcnBjL3htb24veG1vbi5jOjEy
NTI6MTM6IGVycm9yOiBzdGF0ZW1lbnQgd2lsbCBuZXZlciBiZSBleGVjdXRlZCBbLVdlcnJvcj1z
d2l0Y2gtDQo+IHVucmVhY2hhYmxlXQ0KPiAgICAgY29uc3QgY2hhciBiYWRhZGRyW10gPSAiT25s
eSBrZXJuZWwgYWRkcmVzc2VzIGFyZSBwZXJtaXR0ZWQgZm9yIGJyZWFrcG9pbnRzXG4iOw0KPiAg
ICAgICAgICAgICAgICBefn5+fn5+DQoNClRyeSAnc3RhdGljJyA/DQoNCglEYXZpZA0KDQo=
