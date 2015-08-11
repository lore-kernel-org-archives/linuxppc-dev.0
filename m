Return-Path: <yao.yuan@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0111.outbound.protection.outlook.com [207.46.100.111])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8A5C81A039F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 21:09:10 +1000 (AEST)
From: Yao Yuan <yao.yuan@freescale.com>
To: Scott Wood <scottwood@freescale.com>
CC: Yao Yuan <yao.yuan@freescale.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH] powerpc/corenet32: enable DMA in defconfig
Date: Tue, 11 Aug 2015 10:35:05 +0000
Message-ID: <CY1PR0301MB1562FDF93D4C9774AD7266E6837F0@CY1PR0301MB1562.namprd03.prod.outlook.com>
References: <1437620446-47626-1-git-send-email-yao.yuan@freescale.com>
In-Reply-To: <1437620446-47626-1-git-send-email-yao.yuan@freescale.com>
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

SGkgU2NvdHQsDQoNCkNvdWxkIHlvdSBwbGVhc2UgdGFrZSBzb21lIHRpbWVzIGhlbHAgdG8gcmV2
aWV3IHRoaXMgcGF0Y2g/IA0KDQpUaGFua3MuDQoNCkJlc3QgUmVnYXJkcywNCll1YW4gWWFvDQoN
Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGludXhwcGMtZGV2IFttYWls
dG86bGludXhwcGMtZGV2LQ0KPiBib3VuY2VzK3lhby55dWFuPWZyZWVzY2FsZS5jb21AbGlzdHMu
b3psYWJzLm9yZ10gT24gQmVoYWxmIE9mIFl1YW4gWWFvDQo+IFNlbnQ6IFRodXJzZGF5LCBKdWx5
IDIzLCAyMDE1IDExOjAxIEFNDQo+IFRvOiBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZzsg
V29vZCBTY290dC1CMDc0MjENCj4gU3ViamVjdDogW1BBVENIXSBwb3dlcnBjL2NvcmVuZXQzMjog
ZW5hYmxlIERNQSBpbiBkZWZjb25maWcNCj4gDQo+IEJ5IGRlZmF1bHQgd2UgZW5hYmxlIERNQShD
T05GSUdfRlNMX0RNQSkgc3VwcG9ydCB3aGljaCBhcmUgbmVlZGVkIG9uDQo+IFAyMDQxUkRCLCBQ
MzA0MURTLCBQNDA4MERTLCBCNDg2MFFEUywgZXRjLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWXVh
biBZYW8gPHlhby55dWFuQGZyZWVzY2FsZS5jb20+DQo+IC0tLQ0KPiAgYXJjaC9wb3dlcnBjL2Nv
bmZpZ3MvY29yZW5ldDMyX3NtcF9kZWZjb25maWcgfCAyICsrDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL2NvbmZpZ3Mv
Y29yZW5ldDMyX3NtcF9kZWZjb25maWcNCj4gYi9hcmNoL3Bvd2VycGMvY29uZmlncy9jb3JlbmV0
MzJfc21wX2RlZmNvbmZpZw0KPiBpbmRleCAzNzY1OTkzLi4wYzE3NWNjIDEwMDY0NA0KPiAtLS0g
YS9hcmNoL3Bvd2VycGMvY29uZmlncy9jb3JlbmV0MzJfc21wX2RlZmNvbmZpZw0KPiArKysgYi9h
cmNoL3Bvd2VycGMvY29uZmlncy9jb3JlbmV0MzJfc21wX2RlZmNvbmZpZw0KPiBAQCAtMTQzLDYg
KzE0Myw4IEBAIENPTkZJR19SVENfRFJWX0RTMTMwNz15DQo+IENPTkZJR19SVENfRFJWX0RTMTM3
ND15ICBDT05GSUdfUlRDX0RSVl9EUzMyMzI9eSAgQ09ORklHX1VJTz15DQo+ICtDT05GSUdfRE1B
REVWSUNFUz15DQo+ICtDT05GSUdfRlNMX0RNQT15DQo+ICBDT05GSUdfVklSVF9EUklWRVJTPXkN
Cj4gIENPTkZJR19GU0xfSFZfTUFOQUdFUj15DQo+ICBDT05GSUdfU1RBR0lORz15DQo+IC0tDQo+
IDIuMS4wLjI3Lmc5NmRiMzI0DQo+IA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXw0KPiBMaW51eHBwYy1kZXYgbWFpbGluZyBsaXN0DQo+IExpbnV4cHBj
LWRldkBsaXN0cy5vemxhYnMub3JnDQo+IGh0dHBzOi8vbGlzdHMub3psYWJzLm9yZy9saXN0aW5m
by9saW51eHBwYy1kZXYNCg==
