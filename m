Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0144.outbound.protection.outlook.com [157.56.110.144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D8B9E1A0E50
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 12:46:22 +1000 (AEST)
From: Wang Dongsheng <Dongsheng.Wang@freescale.com>
To: Scott Wood <scottwood@freescale.com>
CC: York Sun <yorksun@freescale.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, Jin Jason <Jason.Jin@freescale.com>
Subject: RE: [RESEND] powerpc/diu: adjust DIU initialization entry
Date: Wed, 8 Jul 2015 02:30:28 +0000
Message-ID: <SN1PR0301MB16161F3443AF7311DB42A36E9D910@SN1PR0301MB1616.namprd03.prod.outlook.com>
References: <1436255497-41207-1-git-send-email-dongsheng.wang@freescale.com>
 <1436305887.2658.49.camel@freescale.com>
In-Reply-To: <1436305887.2658.49.camel@freescale.com>
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
MjENCj4gU2VudDogV2VkbmVzZGF5LCBKdWx5IDA4LCAyMDE1IDU6NTEgQU0NCj4gVG86IFdhbmcg
RG9uZ3NoZW5nLUI0MDUzNA0KPiBDYzogU3VuIFlvcmstUjU4NDk1OyBsaW51eHBwYy1kZXZAbGlz
dHMub3psYWJzLm9yZzsgSmluIFpoZW5neGlvbmctUjY0MTg4DQo+IFN1YmplY3Q6IFJlOiBbUkVT
RU5EXSBwb3dlcnBjL2RpdTogYWRqdXN0IERJVSBpbml0aWFsaXphdGlvbiBlbnRyeQ0KPiANCj4g
T24gVHVlLCAyMDE1LTA3LTA3IGF0IDE1OjUxICswODAwLCBEb25nc2hlbmcgV2FuZyB3cm90ZToN
Cj4gPiBGcm9tOiBXYW5nIERvbmdzaGVuZyA8ZG9uZ3NoZW5nLndhbmdAZnJlZXNjYWxlLmNvbT4N
Cj4gPg0KPiA+IE1vdmUgZnNsX2RpdV9pbml0IGludG8gZGl1IHByb2JlIGZ1bmN0aW9uLCBiZWNh
dXNlIGl0IHNob3VsZCBiZQ0KPiA+IGluaXRpYWxpemVkIHdoZW4gc3lzdGVtIGdldCBkaXUgZGV2
aWNlIHRyZWUgbm9kZSwgbm90IGFsd2F5cyBkbw0KPiA+IGluaXRpYWxpemF0aW9uLg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogV2FuZyBEb25nc2hlbmcgPGRvbmdzaGVuZy53YW5nQGZyZWVzY2Fs
ZS5jb20+DQo+ID4gLS0tDQo+ID4gQ2hhbmdlczoNCj4gPiBSZWJhc2Ugb3JpZ2luYWwgcGF0Y2gg
Zm9yIHVwc3RyZWFtIGJlY2F1c2UgZnNsLWRpdS1mYi5jIGhhcyBtb3ZlZCB0bw0KPiA+IGZiZGV2
IGRpci4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggaXMgYSBsb25nIHRpbWUgYWdvLCB0aGVyZSBpcyBu
byBmZWVkYmFjaywgYW5kIHRoZSBQYXRjaHdvcmsNCj4gPiBzdGF0ZSBoYXMgYmVlbiBtb2RpZmll
ZCBmb3IgdGhlIGNoYW5nZXMgcmVxdWVzdGVkLCBJIGRvbid0IGtub3cgd2h5Lg0KPiA+IFNvIEkg
cmVzZW5kIHRoaXMgcGF0Y2ggdG8gdXBzdHJlYW0uDQo+IA0KPiBQbGVhc2Ugc2VuZCB0aGlzIHRv
IHRoZSBwcm9wZXIgbGlzdCBhbmQgbWFpbnRhaW5lciwgYW5kIHdpdGggYSBzdWJqZWN0IHByZWZp
eA0KPiB0aGF0IGluZGljYXRlcyBpdCdzIGFuIGZiZGV2IHBhdGNoLg0KPiANClRoYW5rcy4NCg0K
SSB3aWxsIHNlbmQgdGhpcyBwYXRjaCB0byBsaW51eC1mYmRldkB2Z2VyLmtlcm5lbC5vcmcuDQoN
ClBsZWFzZSBpZ25vcmUgdGhpcyBwYXRjaC4NCg0KUmVnYXJkcywNCi1Eb25nc2hlbmcNCg==
