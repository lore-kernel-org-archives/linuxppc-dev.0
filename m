Return-Path: <mihai.caraman@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0207.outbound.protection.outlook.com [207.46.163.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6A4DA1A06CD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 May 2014 17:59:39 +1000 (EST)
From: "mihai.caraman@freescale.com" <mihai.caraman@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH 2/2] powerpc/e6500: hw tablewalk: fix recursive tlb lock
 on cpu 0
Date: Fri, 30 May 2014 07:59:31 +0000
Message-ID: <65f51156027a4c8a90c670d0ba72df3c@BY2PR03MB508.namprd03.prod.outlook.com>
References: <1400795101-8737-1-git-send-email-scottwood@freescale.com>
 <1400795101-8737-2-git-send-email-scottwood@freescale.com>
In-Reply-To: <1400795101-8737-2-git-send-email-scottwood@freescale.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW51eHBwYy1kZXYgW21haWx0
bzpsaW51eHBwYy1kZXYtDQo+IGJvdW5jZXMrbWloYWkuY2FyYW1hbj1mcmVlc2NhbGUuY29tQGxp
c3RzLm96bGFicy5vcmddIE9uIEJlaGFsZiBPZiBTY290dA0KPiBXb29kDQo+IFNlbnQ6IEZyaWRh
eSwgTWF5IDIzLCAyMDE0IDEyOjQ1IEFNDQo+IFRvOiBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJz
Lm9yZw0KPiBDYzogV29vZCBTY290dC1CMDc0MjENCj4gU3ViamVjdDogW1BBVENIIDIvMl0gcG93
ZXJwYy9lNjUwMDogaHcgdGFibGV3YWxrOiBmaXggcmVjdXJzaXZlIHRsYiBsb2NrDQo+IG9uIGNw
dSAwDQo+IA0KPiBDb21taXQgODJkODZkZTI1YjljOTlkYjU0NmUxN2M2ZjdlYmY5YTY5MWRhNTU3
ZSAiVExCIGxvY2sgcmVjdXJzaXZlIg0KPiBpbnRyb2R1Y2VkIGEgYnVnIHdoZXJlYnkgY3B1IDAg
dXNlcyB0aGUgc2FtZSB2YWx1ZSBmb3IgImxvY2sgaGVsZCIgYXMNCj4gaXMgdXNlZCB0byBpbmRp
Y2F0ZSB0aGF0IHRoZSBsb2NrIGlzIGZyZWUuDQoNCklzbid0IGhpcyB3aGF0IHNwaW4gbG9jayBp
bXBsZW1lbnRhdGlvbiBzb2x2ZXMgYnkgY29tYmluZXMgcGFjYV9pbmRleA0Kd2l0aCBsb2NrX3Rv
a2VuPyBDYW4ndCB3ZSBoYXZlIGEgY29tbW9uIGFwcHJvYWNoPw0KDQo+IEFkZCBvbmUgdG8gdGhl
IENQVSB2YWx1ZSB0byBlbnN1cmUgd2UgZG8gbm90IHVzZSB6ZXJvIGFzIGEgImxvY2sgaGVsZCIN
Cj4gdmFsdWUuDQoNClRoZSBDUFUgdmFsdWUgaXMgbG9hZGVkIGluIHIxMCBmcm9tIHRsYl9taXNz
X2NvbW1vbl9lNjUwMC4gIlRMQiBsb2NrIHJlY3Vyc2l2ZSINCmNvbW1pdCBhbHNvIGludHJvZHVj
ZWQgdGhpcyBtaXNsZWFkaW5nIGNvbW1lbnQ6DQoNCiAgICBXZSBhcmUgZW50ZXJlZCB3aXRoOg0K
ICAgIHIxMCA9IGNwdSBudW1iZXINCg0KLU1pa2UNCg==
