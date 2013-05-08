Return-Path: <B02008@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 387BA2C010F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 May 2013 19:20:19 +1000 (EST)
From: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
To: tiejun.chen <tiejun.chen@windriver.com>, Wood Scott-B07421
 <B07421@freescale.com>
Subject: RE: [v1][KVM][PATCH 1/1] kvm:ppc:booehv: direct ISI exception to Guest
Date: Wed, 8 May 2013 09:20:10 +0000
Message-ID: <300B73AA675FCE4A93EB4FC1D42459FF3EFA26@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1367970043.3398.39@snotra> <5189B02E.3000109@windriver.com>
In-Reply-To: <5189B02E.3000109@windriver.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "agraf@suse.de" <agraf@suse.de>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBrdm0tb3duZXJAdmdlci5rZXJu
ZWwub3JnIFttYWlsdG86a3ZtLW93bmVyQHZnZXIua2VybmVsLm9yZ10gT24NCj4gQmVoYWxmIE9m
IHRpZWp1bi5jaGVuDQo+IFNlbnQ6IFdlZG5lc2RheSwgTWF5IDA4LCAyMDEzIDQ6NTQgQU0NCj4g
VG86IFdvb2QgU2NvdHQtQjA3NDIxDQo+IENjOiBhZ3JhZkBzdXNlLmRlOyBrdm0tcHBjQHZnZXIu
a2VybmVsLm9yZzsga3ZtQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXhwcGMtZGV2QGxpc3RzLm96
bGFicy5vcmcNCj4gU3ViamVjdDogUmU6IFt2MV1bS1ZNXVtQQVRDSCAxLzFdIGt2bTpwcGM6Ym9v
ZWh2OiBkaXJlY3QgSVNJIGV4Y2VwdGlvbiB0bw0KPiBHdWVzdA0KPiANCj4gT24gMDUvMDgvMjAx
MyAwNzo0MCBBTSwgU2NvdHQgV29vZCB3cm90ZToNCj4gPiBPbiAwNS8wNy8yMDEzIDA2OjA2OjMw
IEFNLCBUaWVqdW4gQ2hlbiB3cm90ZToNCj4gPj4gV2UgYWxzbyBjYW4gZGlyZWN0IElTSSBleGNl
cHRpb24gdG8gR3Vlc3QgbGlrZSBEU0kuDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IFRpZWp1
biBDaGVuIDx0aWVqdW4uY2hlbkB3aW5kcml2ZXIuY29tPg0KPiA+PiAtLS0NCj4gPj4gIGFyY2gv
cG93ZXJwYy9rdm0vYm9va2VfZW11bGF0ZS5jIHwgICAgMyArKysNCj4gPj4gIGFyY2gvcG93ZXJw
Yy9rdm0vZTUwMG1jLmMgICAgICAgIHwgICAgMyArKy0NCj4gPj4gIDIgZmlsZXMgY2hhbmdlZCwg
NSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBBcmUgeW91IHNlZWluZyBh
IHJlYWwgcGVyZm9ybWFuY2UgaW1wcm92ZW1lbnQgZnJvbSB0aGlzPyAgVGhpcyB3aWxsDQo+IGlu
dGVyZmVyZQ0KPiANCj4gTm8uIEJ1dCBhZnRlciB3ZSByZWR1Y2UgdGhlIGV4aXQgdG8gaG9zdCwg
c2hvdWxkbid0IHRoaXMgaW1wcm92ZQ0KPiBwZXJmb3JtYW5jZT8NCg0KV2UgbG9zZSBzb21lIGZs
ZXhpYmlsaXR5IGZvciB0aGlzIHNvIGl0IG1ha2Ugc2Vuc2Ugb25seSBpZiB3ZSBnYWluDQptZWFz
dXJhYmxlIGltcHJvdmVtZW50cy4NCg0KPiANCj4gPiBzb21ld2hhdCB3aXRoIHVzaW5nIHRoZSBW
RiBiaXQsIGlmIHdlIHdlcmUgdG8gZXZlciBkbyBzbywgc2luY2UgVkYgb25seQ0KPiBhZmZlY3Rz
DQo+IA0KPiBTb3JyeSwgd2hhdCBpcyB0aGUgVkYgeW91IHNhaWQ/DQoNClZGIHN0YW5kcyBmb3Ig
dmlydHVhbGl6YXRpb24gZmF1bHQgc2VlIE1BUzhbVkZdIGFuZCB3ZSBtYXkgdXNlIGl0IGZvciB2
aXJ0dWFsaXplZA0KTU1JTy4gVGhlIGh5cGVydmlzb3Igc2hvdWxkIGRlbnkgZXhlY3V0ZSBhY2Nl
c3Mgb24gcGFnZXMgbWFya2VkIHdpdGggVkYuIEFjY29yZGluZ2x5DQppbiB0aGlzIGNhc2UgZ3Vl
c3QgSVNJIGV4Y2VwdGlvbnMgc2hvdWxkIGJlIGhhbmRsZWQgYnkgdGhlIGh5cGVydmlzb3IuDQoN
Ci1NaWtlDQoNCg==
