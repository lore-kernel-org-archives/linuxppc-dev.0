Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.189])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BD6541A02D1
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Aug 2015 21:20:08 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Laurent Dufour' <ldufour@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jslaby@suse.cz>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] powerpc/hvsi: Fix endianness issues in the HVSI driver
Date: Mon, 3 Aug 2015 11:00:18 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CB71D3E@AcuExch.aculab.com>
References: <1438334990-11765-1-git-send-email-ldufour@linux.vnet.ibm.com>
In-Reply-To: <1438334990-11765-1-git-send-email-ldufour@linux.vnet.ibm.com>
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

RnJvbTogTGF1cmVudCBEdWZvdXINCj4gU2VudDogMzEgSnVseSAyMDE1IDEwOjMwDQo+IFRoaXMg
cGF0Y2ggZml4ZXMgc2V2ZXJhbCBlbmRpYW5uZXNzIGlzc3VlcyBkZXRlY3RlZCB3aGVuIHJ1bm5p
bmcgdGhlIEhWU0kNCj4gZHJpdmVyIGluIGxpdHRsZSBlbmRpYW4gbW9kZS4NCj4gDQo+IFRoZXNl
IGlzc3VlcyBhcmUgcmFpc2VkIGluIGxpdHRsZSBlbmRpYW4gbW9kZSBiZWNhdXNlIHRoZSBkYXRh
IGV4Y2hhbmdlZCBpbg0KPiBtZW1vcnkgYmV0d2VlbiB0aGUga2VybmVsIGFuZCB0aGUgaHlwZXJ2
aXNvciBoYXMgdG8gYmUgaW4gYmlnIGVuZGlhbg0KPiBmb3JtYXQuDQouLi4NCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdHR5L2h2Yy9odnNpLmMgYi9kcml2ZXJzL3R0eS9odmMvaHZzaS5jDQo+IGlu
ZGV4IDQxOTAxOTk3YzBkNi4uYTc1MTQ2ZjYwMGNiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3R0
eS9odmMvaHZzaS5jDQo+ICsrKyBiL2RyaXZlcnMvdHR5L2h2Yy9odnNpLmMNCj4gQEAgLTI0MCw5
ICsyNDAsOSBAQCBzdGF0aWMgdm9pZCBodnNpX3JlY3ZfY29udHJvbChzdHJ1Y3QgaHZzaV9zdHJ1
Y3QgKmhwLCB1aW50OF90ICpwYWNrZXQsDQo+ICB7DQo+ICAJc3RydWN0IGh2c2lfY29udHJvbCAq
aGVhZGVyID0gKHN0cnVjdCBodnNpX2NvbnRyb2wgKilwYWNrZXQ7DQo+IA0KPiAtCXN3aXRjaCAo
aGVhZGVyLT52ZXJiKSB7DQo+ICsJc3dpdGNoIChiZTE2X3RvX2NwdShoZWFkZXItPnZlcmIpKSB7
DQo+ICAJCWNhc2UgVlNWX01PREVNX0NUTF9VUERBVEU6DQo+IC0JCQlpZiAoKGhlYWRlci0+d29y
ZCAmIEhWU0lfVFNDRCkgPT0gMCkgew0KPiArCQkJaWYgKChiZTMyX3RvX2NwdShoZWFkZXItPndv
cmQpICYgSFZTSV9UU0NEKSA9PSAwKSB7DQoNCkl0IGlzIGdlbmVyYWxseSBiZXN0IHRvIGJ5dGVz
d2FwIGNvbnN0YW50cy4NCg0KCURhdmlkDQoNCg==
