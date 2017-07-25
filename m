Return-Path: <gabriele.paoloni@huawei.com>
Received: from lhrrgout.huawei.com (lhrrgout.huawei.com [194.213.3.17])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xH2ty0M1dzDqm0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 01:57:28 +1000 (AEST)
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Laszlo Ersek <lersek@redhat.com>, Daniel Axtens <dja@axtens.net>, "Ard
 Biesheuvel" <ard.biesheuvel@linaro.org>,
 Hans de Goede <hdegoede@redhat.com>
CC: linux-pci <linux-pci@vger.kernel.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, David Airlie <airlied@linux.ie>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, Will Deacon
 <will.deacon@arm.com>, "Liuxinliang (Matthew Liu)"
 <z.liuxinliang@hisilicon.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Zou Rongrong
 <zourongrong@gmail.com>,
 "daniel.vetter@intel.com" <daniel.vetter@intel.com>
Subject: RE: [PATCH 0/4] Allow non-legacy cards to be vgaarb default
Date: Tue, 25 Jul 2017 15:56:20 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40B76A1A@FRAEML521-MBX.china.huawei.com>
References: <20170719012839.20124-1-dja@axtens.net>
 <CAKv+Gu-SgeLXVEj_VtZHchaNmOwWO+GmfTg5CYcnOF43AJZGnA@mail.gmail.com>
 <87pocusm2x.fsf@linkitivity.dja.id.au>
 <CAKv+Gu-O7cyJSgDrqSNi6F_n9eBnFEgz==aqowMqhy+81YK=CQ@mail.gmail.com>
 <87r2x6vj7t.fsf@linkitivity.dja.id.au>
 <a61222c6-e548-1e3b-f6f7-63952b90ac13@redhat.com>
In-Reply-To: <a61222c6-e548-1e3b-f6f7-63952b90ac13@redhat.com>
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

SGkgTGFzemxvDQoNClsuLi5dDQoNCj4gDQo+IEhhdmluZyBwcmFjdGljYWxseSB6ZXJvIGJhY2tn
cm91bmQgaW4gZ2Z4IGRldmVsb3BtZW50IChlaXRoZXIga2VybmVsIG9yDQo+IFhvcmcpLCBJIHRo
aW5rIHRoZSBwcm9ibGVtIGlzIHRoYXQgdmdhX2RlZmF1bHRfZGV2aWNlKCkgLw0KPiB2Z2Ffc2V0
X2RlZmF1bHRfZGV2aWNlKCksIHdoaWNoIC0tIGFwcGFyZW50bHkgLS0gImJvb3RfdmdhIiBpcyBi
YXNlZA0KPiB1cG9uLCBjb21lIGZyb20gImRyaXZlcnMvZ3B1L3ZnYS92Z2FhcmIuYyIuIE5hbWVs
eSwgdGhlIGNvbmNlcHQgb2YNCj4gInByaW1hcnkgLyBib290IGRpc3BsYXkgZGV2aWNlIiBpcyB0
aWVkIHRvIHRoZSBWR0EgYXJiaXRlciwgcGx1cyBvbmx5IGENCj4gUENJIGRldmljZSBjYW4gY3Vy
cmVudGx5IGJlIG1hcmtlZCBhcyBwcmltYXJ5L2Jvb3QgZGlzcGxheSBkZXZpY2UuDQo+IA0KPiBD
YW4gdGhlc2UgY29uY2VwdHMgYmUgc3BsaXQgZnJvbSBlYWNoIG90aGVyPyAoSSBjYW4gZnVsbHkg
aW1hZ2luZSB0aGF0DQo+IHRoaXMgd291bGQgcmVzdWx0IGluIGEgdXNlcnNwYWNlIHZpc2libGUg
aW50ZXJmYWNlIGNoYW5nZSAob3INCj4gYWRkaXRpb24pLA0KPiBzbyB0aGF0IGUuZy4gIi9zeXMv
ZGV2aWNlcy8qKi9ib290X2dwdSIgd291bGQgaGF2ZSB0byBiZSBjb25zdWx0ZWQgYnkNCj4gZGlz
cGxheSBzZXJ2ZXJzLikNCj4gDQo+IChTb3JyeSBpZiBJJ20gdG90YWxseSB3cm9uZy4pDQo+IA0K
PiAuLi4gSG0sIHJlYWRpbmcgdGhlIHRocmVhZCBzdGFydGVyIGF0DQo+IDxodHRwczovL3d3dy5t
YWlsLWFyY2hpdmUuY29tL2xpbnV4cHBjLQ0KPiBkZXZAbGlzdHMub3psYWJzLm9yZy9tc2cxMjA4
NTEuaHRtbD4sDQo+IGFuZCB0aGUgcmVmZXJlbmNlcyB3aXRoaW4uLi4gSXQgbG9va3MgbGlrZSB0
aGlzIHdvcmsgaXMgbW90aXZhdGVkIGJ5DQo+IGhhcmR3YXJlIHRoYXQgaXMgc3VwcG9zZWQgdG8g
YmUgUENJLCBidXQgYWN0dWFsbHkgYnJlYWtzIHRoZSBzcGVjcy4gSXMNCj4gdGhhdCBjb3JyZWN0
PyBJZiBzbywgdGhlbiBJIGRvbid0IHRoaW5rIEkgY2FuIHN1Z2dlc3QgYW55dGhpbmcgdXNlZnVs
Lg0KDQpNeSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgdGhlIGN1cnJlbnQgUENJZSBIVyBpcyBzcGVj
cyBjb21wbGlhbnQgYnV0IHRoZQ0KdmdhYXJiLCBpbiBvcmRlciB0byBtYWtlIGEgVkdBIGRldmlj
ZSB0aGUgZGVmYXVsdCBvbmUsIHJlcXVpcmVzIGFsbCB0aGUNCmJyaWRnZXMgb24gdG9wIG9mIHN1
Y2ggZGV2aWNlIHRvIGhhdmUgdGhlICJWR0EgRW5hYmxlIiBiaXQgc2V0IChvcHRpb25hbA0KYml0
IGluIHRoZSBQQ0kgRXhwcmVzc+KEoiB0byBQQ0kvUENJLVggQnJpZGdlIFNwZWMpLiBJLmUuIGFs
bCB0aGUgYnJpZGdlcw0Kb24gdG9wIGhhdmUgdG8gc3VwcG9ydCBsZWdhY3kgVkdBIGRldmljZXM7
IGFuZCB0aGlzIGlzIG5vdCBtYW5kYXRvcnkNCmZyb20gdGhlIHNwZWNzLi4ucmlnaHQ/DQoNCkJU
VyBteSBWR0EgZXhwZXJpZW5jZSBpcyBsaW1pdGVkIHRvby4uLnRoaXMgaXMganVzdCBteSB1bmRl
cnN0YW5kaW5nLi4uDQoNCkdhYg0KDQo+IFNwZWNzIGV4aXN0IHNvIHRoYXQgaGFyZHdhcmUgdmVu
ZG9ycyBhbmQgc29mdHdhcmUgYXV0aG9ycyBmb2xsb3cgdGhlbS4NCj4gSWYgaGFyZHdhcmUgZG9l
cyBub3QgY29uZm9ybSwgdGhlbiBzb2Z0d2FyZSBzaG91bGQgZWl0aGVyIHJlZnVzZSB0bw0KPiB3
b3JrDQo+IHdpdGggaXQsIG9yIGhhbmRsZSBpdCB3aXRoIHF1aXJrcywgb24gYSBjYXNlLWJ5LWNh
c2UgYmFzaXMuIEkgZ3Vlc3MNCj4gdGhpcw0KPiBtZWFucyB0aGF0IEkgZG9uJ3QgYWdyZWUgd2l0
aCB0aGUNCj4gDQo+ICAgYnJvYWRbXSBzdWdnZXN0W2lvbl0gdGhhdCBhIG1vcmUgZ2VuZXJpYyBz
b2x1dGlvbiB3b3VsZCBiZSBiZXR0ZXINCj4gDQo+IHdoaWNoIHNlZW1zIHRvIGRpc3F1YWxpZnkg
bWUgZnJvbSB0aGUgZGlzY3Vzc2lvbiwgYXMgaXQgbXVzdCBoYXZlIGJlZW4NCj4gc3VnZ2VzdGVk
IGJ5IHBlb3BsZSB3aXRoIGluY29tcGFyYWJseSBtb3JlIGV4cGVyaWVuY2UgdGhhbiB3aGF0IEkg
aGF2ZQ0KPiA6KQ0KPiANCj4gVGhhbmtzDQo+IExhc3psbw0K
