Return-Path: <alexander.steffen@infineon.com>
Received: from smtp2.infineon.com (smtp2.infineon.com
 [IPv6:2a00:18f0:1e00:4::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yGYg91RRrzDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 23:00:52 +1100 (AEDT)
From: <Alexander.Steffen@infineon.com>
To: <andriy.shevchenko@linux.intel.com>, <elfring@users.sourceforge.net>,
 <linux-integrity@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <benh@kernel.crashing.org>, <clabbe.montjoie@gmail.com>,
 <jarkko.sakkinen@linux.intel.com>, <jgunthorpe@obsidianresearch.com>,
 <jsnitsel@redhat.com>, <kgold@linux.vnet.ibm.com>, <mpe@ellerman.id.au>,
 <nayna@linux.vnet.ibm.com>, <paulus@samba.org>, <PeterHuewe@gmx.de>,
 <stefanb@linux.vnet.ibm.com>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH 3/4] char/tpm: Improve a size determination in nine
 functions
Date: Tue, 17 Oct 2017 11:50:05 +0000
Message-ID: <c8d37c0407a949c1abb35cfd79c17f58@infineon.com>
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
 <83a166af-aecc-649d-dfe3-a72245345209@users.sourceforge.net>
 <1508238182.16112.475.camel@linux.intel.com>
In-Reply-To: <1508238182.16112.475.camel@linux.intel.com>
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

PiA+IFJlcGxhY2UgdGhlIHNwZWNpZmljYXRpb24gb2YgZGF0YSBzdHJ1Y3R1cmVzIGJ5IHBvaW50
ZXIgZGVyZWZlcmVuY2VzDQo+ID4gYXMgdGhlIHBhcmFtZXRlciBmb3IgdGhlIG9wZXJhdG9yICJz
aXplb2YiIHRvIG1ha2UgdGhlIGNvcnJlc3BvbmRpbmcNCj4gPiBzaXplDQo+ID4gZGV0ZXJtaW5h
dGlvbiBhIGJpdCBzYWZlciBhY2NvcmRpbmcgdG8gdGhlIExpbnV4IGNvZGluZyBzdHlsZQ0KPiA+
IGNvbnZlbnRpb24uDQo+IA0KPiANCj4gVGhpcyBwYXRjaCBkb2VzIG9uZSBzdHlsZSBpbiBmYXZv
ciBvZiB0aGUgb3RoZXIuDQoNCkkgYWN0dWFsbHkgcHJlZmVyIHRoYXQgc3R5bGUsIHNvIEknZCB3
ZWxjb21lIHRoaXMgY2hhbmdlIDopDQoNCj4gQXQgdGhlIGVuZCBpdCdzIEphcmtrbydzIGNhbGws
IHRob3VnaCBJIHdvdWxkIE5BSyB0aGlzIGFzIEkgdGhpbmsgc29tZQ0KPiBvbmUgYWxyZWFkeSB0
b2xkIHRoaXMgdG8geW91IGZvciBzb21lIG90aGVyIHNpbWlsYXIgcGF0Y2goZXMpLg0KPiANCj4g
DQo+IEkgZXZlbiB3b3VsZCBzdWdnZXN0IHRvIHN0b3AgZG9pbmcgdGhpcyBub2lzeSBzdHVmZiwg
d2hpY2gga2VlcHMgcGVvcGxlDQo+IGJ1c3kgZm9yIG5vdGhpbmcuDQoNCkNsZWFuaW5nIHVwIG9s
ZCBjb2RlIGlzIGFsc28gd29ydGggc29tZXRoaW5nLCBldmVuIGlmIGRvZXMgbm90IGNoYW5nZSBv
bmUgYml0IGluIHRoZSBhc3NlbWJseSBvdXRwdXQgaW4gdGhlIGVuZC4uLg0KDQpBbGV4YW5kZXIN
Cg==
