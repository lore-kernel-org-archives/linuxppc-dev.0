Return-Path: <B48286@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0147.outbound.protection.outlook.com [65.55.169.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3BF391A0C92
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 14:16:14 +1100 (AEDT)
From: Hou Zhiqiang <B48286@freescale.com>
To: Scott Wood <scottwood@freescale.com>, Zhiqiang Hou
 <Zhiqiang.Hou@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "galak@kernel.crashing.org" <galak@kernel.crashing.org>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "paulus@samba.org"
 <paulus@samba.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com"
 <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "Harninder
 Rai" <harninder.rai@freescale.com>, Lian M.H. <Minghuan.Lian@freescale.com>,
 Hu Vincent <Mingkai.Hu@freescale.com>
Subject: RE: [PATCH V3 1/2] powerpc/fsl: Add PCI node in device tree of
 bsc9132qds
Date: Thu, 5 Nov 2015 03:16:06 +0000
Message-ID: <CY1PR0301MB078078CD2D681D7D15D15D0E8B290@CY1PR0301MB0780.namprd03.prod.outlook.com>
References: <1446691975-8965-1-git-send-email-Zhiqiang.Hou@freescale.com>
 <1446692954.12676.42.camel@freescale.com>
In-Reply-To: <1446692954.12676.42.camel@freescale.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29vZCBTY290dC1CMDc0
MjENCj4gU2VudDogMjAxNeW5tDEx5pyINeaXpSAxMTowOQ0KPiBUbzogWmhpcWlhbmcgSG91DQo+
IENjOiBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZzsgZ2FsYWtAa2VybmVsLmNyYXNoaW5n
Lm9yZzsNCj4gYmVuaEBrZXJuZWwuY3Jhc2hpbmcub3JnOyBwYXVsdXNAc2FtYmEub3JnOyBtcGVA
ZWxsZXJtYW4uaWQuYXU7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyByb2JoK2R0QGtl
cm5lbC5vcmc7IHBhd2VsLm1vbGxAYXJtLmNvbTsNCj4gbWFyay5ydXRsYW5kQGFybS5jb207IGlq
YytkZXZpY2V0cmVlQGhlbGxpb24ub3JnLnVrOyBSYWkgSGFybmluZGVyLUIwMTA0NDsNCj4gTGlh
biBNaW5naHVhbi1CMzE5Mzk7IEh1IE1pbmdrYWktQjIxMjg0OyBIb3UgWmhpcWlhbmctQjQ4Mjg2
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMS8yXSBwb3dlcnBjL2ZzbDogQWRkIFBDSSBub2Rl
IGluIGRldmljZSB0cmVlIG9mDQo+IGJzYzkxMzJxZHMNCj4gDQo+IE9uIFRodSwgMjAxNS0xMS0w
NSBhdCAxMDo1MiArMDgwMCwgWmhpcWlhbmcgSG91IHdyb3RlOg0KPiA+IEZyb206IEhhcm5pbmRl
ciBSYWkgPGhhcm5pbmRlci5yYWlAZnJlZXNjYWxlLmNvbT4NCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IEhhcm5pbmRlciBSYWkgPGhhcm5pbmRlci5yYWlAZnJlZXNjYWxlLmNvbT4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBNaW5naHVhbiBMaWFuIDxNaW5naHVhbi5MaWFuQGZyZWVzY2FsZS5jb20+DQo+
ID4gUmV2aWV3ZWQtYnk6IFphbmcgVGllZmVpLVI2MTkxMSA8dGllLWZlaS56YW5nQGZyZWVzY2Fs
ZS5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEt1c2h3YWhhIFByYWJoYWthci1CMzI1NzkgPHByYWJo
YWthckBmcmVlc2NhbGUuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBGbGVtaW5nIEFuZHJldy1BRkxF
TUlORyA8QUZMRU1JTkdAZnJlZXNjYWxlLmNvbT4NCj4gPiBUZXN0ZWQtYnk6IEZsZW1pbmcgQW5k
cmV3LUFGTEVNSU5HIDxBRkxFTUlOR0BmcmVlc2NhbGUuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IEhvdSBaaGlxaWFuZyA8QjQ4Mjg2QGZyZWVzY2FsZS5jb20+DQo+ID4gLS0tDQo+ID4gVjM6DQo+
ID4gIC0gUmVtb3ZlIGdlcnJpdCBzdHVmZi4NCj4gDQo+IE5vLCB5b3UgZGlkbid0IHJlbW92ZSBh
bGwgb2YgdGhlIEdlcnJpdCBzdHVmZi4gIEdldCByaWQgb2YgYWxsIHRoZQ0KPiBSZXZpZXdlZC0g
YnkgYW5kIFRlc3RlZC1ieSBzaW5jZSB0aGV5IGFyZSBub3QgcmVsZXZhbnQgdG8gdGhpcyBjb250
ZXh0Lg0KPiBIaXR0aW5nICIrMSINCj4gaW4gR2Vycml0IHRvIGFsbG93IGEgcGF0Y2ggdG8gZ28g
aW50byB0aGUgU0RLIHRyZWUgYSBmZXcgeWVhcnMgYWdvIGlzIG5vdA0KPiB0aGUgc2FtZSBhcyBy
ZXZpZXdpbmcgaXQgZm9yIGluY2x1c2lvbiBpbiBtYWlubGluZSBMaW51eCB0b2RheS4NCiANCk9r
LCB0aGFua3MuDQoNClpoaXFpYW5nDQo=
