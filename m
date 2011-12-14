Return-Path: <r58472@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 292A81007D5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Dec 2011 22:14:03 +1100 (EST)
From: Li Yang-R58472 <r58472@freescale.com>
To: "dedekind1@gmail.com" <dedekind1@gmail.com>, Kumar Gala
 <galak@kernel.crashing.org>
Subject: RE: [PATCH v2] Integrated Flash Controller support
Date: Wed, 14 Dec 2011 11:13:53 +0000
Message-ID: <94F013E7935FF44C83EBE7784D62AD3F056964B0@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1320053901-23801-1-git-send-email-b35362@freescale.com>
 <CCF7C6DB-437C-4140-894F-2F497AD610DC@kernel.crashing.org>
 <8EDB3DC6-63E5-4D5C-BB52-15F32B85C5DD@kernel.crashing.org>
 <1322602860.2150.10.camel@koala> <4ED5531C.6030104@freescale.com>
 <EFF451D9-552A-4820-90D3-BF3156D5B25F@kernel.crashing.org>
 <1322643080.24797.413.camel@sauron.fi.intel.com>
In-Reply-To: <1322643080.24797.413.camel@sauron.fi.intel.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 Liu Shuo-B35362 <B35362@freescale.com>,
 "linux-kernel@vger.kernel.org Kernel" <linux-kernel@vger.kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQXJ0ZW0gQml0eXV0c2tpeSBbbWFp
bHRvOmRlZGVraW5kMUBnbWFpbC5jb21dDQo+U2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciAzMCwg
MjAxMSA0OjUxIFBNDQo+VG86IEt1bWFyIEdhbGENCj5DYzogV29vZCBTY290dC1CMDc0MjE7IExp
IFlhbmctUjU4NDcyOyBMaXUgU2h1by1CMzUzNjI7IGxpbnV4LQ0KPmtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmcgS2VybmVsOyBsaW51eC1tdGRAbGlzdHMuaW5mcmFkZWFkLm9yZzsgQW5kcmV3DQo+TW9y
dG9uOyBEYXZpZCBXb29kaG91c2U7IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnIGxpc3QN
Cj5TdWJqZWN0OiBSZTogW1BBVENIIHYyXSBJbnRlZ3JhdGVkIEZsYXNoIENvbnRyb2xsZXIgc3Vw
cG9ydA0KPg0KPk9uIFR1ZSwgMjAxMS0xMS0yOSBhdCAxOTo0NyAtMDYwMCwgS3VtYXIgR2FsYSB3
cm90ZToNCj4+IEFzIFNjb3R0IHNhaWQsIEkgd2FzIG1vcmUgYXNraW5nIGFib3V0IHRoZSAybmQg
cGF0Y2ggaW4gdGhlIHNlcXVlbmNlDQo+PiB3aGljaCBkaWQgdG91Y2ggTVRELiAgU2luY2UgdGhh
dCBvbmUgaXMgZGVwZW5kZW50IG9uIHRoaXMgcGF0Y2gsDQo+PiB3b25kZXJpbmcgaG93IHdlIHdh
bnRlZCB0byBoYW5kbGUgdGhlbS4NCj4NCj5JIGRvIG5vdCBoYXZlIHRpbWUgdG8gcmV2aWV3IGl0
LCBidXQgaXQgbG9va3MgT0ssIHNvIEknZCBzdWdnZXN0IHRvDQo+bWVyZ2UgaXQgdmllIHRoZSBz
YW1lIHRyZWUgYXMgdGhlIHJlc3Qgb2YgdGhlIHBhdGNoZXMuDQoNCkhpIEFydGVtLA0KDQpTbyB3
aGF0IGlzIHlvdXIgc3VnZ2VzdGlvbiBvbiB0aGlzIHBhdGNoPyAgQ2FuIHdlIHJlZ2FyZCB5b3Vy
IHByZXZpb3VzIGVtYWlsIGFzIGFuIEFDSyBhbmQgbWVyZ2UgaXQgdGhyb3VnaCB0aGUgcG93ZXJw
YyB0cmVlPyAgT3IgZG8geW91IHByZWZlciB0byBtZXJnZSB0aGVtIHRocm91Z2ggdGhlIE1URCB0
cmVlIHdpdGggS3VtYXIncyBBQ0sgaW5zdGVhZD8NCg0KLSBMZW8NCg==
