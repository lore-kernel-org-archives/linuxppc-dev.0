Return-Path: <r61911@freescale.com>
Received: from AM1EHSOBE002.bigfish.com (am1ehsobe002.messaging.microsoft.com
	[213.199.154.205])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B2397B6F8A
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 15 Aug 2011 14:46:34 +1000 (EST)
From: Zang Roy-R61911 <r61911@freescale.com>
To: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: RE: [PATCH 2/2 v2] eSDHC: Fix errors when booting kernel with fsl
	esdhc
Date: Mon, 15 Aug 2011 04:46:25 +0000
Message-ID: <2239AC579C7D3646A720227A37E0268119077A@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1311329717-13954-1-git-send-email-tie-fei.zang@freescale.com>
	<1311329717-13954-2-git-send-email-tie-fei.zang@freescale.com>
	<20110722101512.GA1576@oksana.dev.rtsoft.ru>
	<2239AC579C7D3646A720227A37E0268118FD3B@039-SN1MPN1-005.039d.mgd.msft.net>
	<20110812100450.GA23333@oksana.dev.rtsoft.ru>
In-Reply-To: <20110812100450.GA23333@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
	Xu Lei-B33228 <B33228@freescale.com>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW50b24gVm9yb250c292
IFttYWlsdG86Y2JvdWF0bWFpbHJ1QGdtYWlsLmNvbV0NCj4gU2VudDogRnJpZGF5LCBBdWd1c3Qg
MTIsIDIwMTEgMTg6MDUgUE0NCj4gVG86IFphbmcgUm95LVI2MTkxMQ0KPiBDYzogbGludXgtbW1j
QHZnZXIua2VybmVsLm9yZzsgbGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmc7IGFrcG1AbGlu
dXgtDQo+IGZvdW5kYXRpb24ub3JnOyBYdSBMZWktQjMzMjI4OyBLdW1hciBHYWxhOyBXb29kIFNj
b3R0LUIwNzQyMQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvMiB2Ml0gZVNESEM6IEZpeCBlcnJv
cnMgd2hlbiBib290aW5nIGtlcm5lbCB3aXRoIGZzbCBlc2RoYw0KPiANCj4gSGVsbG8sDQo+IA0K
PiBPbiBGcmksIEF1ZyAxMiwgMjAxMSBhdCAwOTo0NDoyNkFNICswMDAwLCBaYW5nIFJveS1SNjE5
MTEgd3JvdGU6DQo+IFsuLi5dDQo+ID4gPiBXZSB0cnkgdG8gbm90IHBvbGx1dGUgZ2VuZXJpYyBz
ZGhjaS5jIGRyaXZlciB3aXRoIGNoaXAtc3BlY2lmaWMNCj4gPiA+IHF1aXJrcy4NCj4gPiA+DQo+
ID4gPiBNYXliZSB5b3UgY2FuIGRvIHRoZSBmaXh1cHMgdmlhIElPIGFjY2Vzc29ycz8gT3IgYnkg
aW50cm9kdWNpbmcNCj4gPiA+IHNvbWUgYWRkaXRpb25hbCBzZGhjaSBvcD8NCj4gPiBBbnRvbiwN
Cj4gPiB0aGFua3MgZm9yIHRoZSBjb21tZW50LCBhcyB3ZSBkaXNjdXNzZWQsIHRoZSBvcmlnaW5h
bCBjb2RlIHVzZSA4IGJpdCBieXRlDQo+IG9wZXJhdGlvbiwNCj4gPiB3aGlsZSBpbiBmYWN0LCBv
biBzb21lIHBvd2VycGMgcGxhdGZvcm0sIDMyIGJpdCBvcGVyYXRpb24gaXMgbmVlZGVkLg0KPiA+
IHNob3VsZCBpdCBiZSBwb3NzaWJsZSBmaXhlZCBieSBhZGRpbmcgc29tZSB3cmFwcGVyIGluIElP
IGFjY2Vzc29ycyBvcg0KPiBpbnRyb2R1Y2UgYWRkaXRpb25hbCBzZGhjaSBvcD8NCj4gDQo+IEkg
d291bGQgZG8gaXQgaW4gdGhlIElPIGFjY2Vzc29ycy4NCkkgYW0gbG9va2luZyBmb3J3YXJkIHRv
IHlvdXIgcGF0Y2guDQpSb3kNCg==
