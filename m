Return-Path: <B13201@freescale.com>
Received: from AM1EHSOBE004.bigfish.com (am1ehsobe001.messaging.microsoft.com
 [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 61D89B6FAB
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Feb 2012 13:34:27 +1100 (EST)
From: Liu Yu-B13201 <B13201@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH v5 4/4] KVM: PPC: epapr: Update other hypercall invoking
Date: Wed, 22 Feb 2012 02:34:20 +0000
Message-ID: <4CA99838F21AB847ACC344051E23170905749AEC@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1329799573-8820-1-git-send-email-yu.liu@freescale.com>
 <1329799573-8820-2-git-send-email-yu.liu@freescale.com>
 <1329799573-8820-3-git-send-email-yu.liu@freescale.com>
 <1329799573-8820-4-git-send-email-yu.liu@freescale.com>
 <4F44134E.1070802@freescale.com>
In-Reply-To: <4F44134E.1070802@freescale.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "agraf@suse.de" <agraf@suse.de>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29vZCBTY290dC1CMDc0
MjENCj4gU2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSAyMiwgMjAxMiA1OjU4IEFNDQo+IFRvOiBM
aXUgWXUtQjEzMjAxDQo+IENjOiBhZ3JhZkBzdXNlLmRlOyBrdm0tcHBjQHZnZXIua2VybmVsLm9y
Zzsga3ZtQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXhwcGMtZGV2QG96bGFicy5vcmc7IFdvb2Qg
U2NvdHQtQjA3NDIxDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgNC80XSBLVk06IFBQQzogZXBh
cHI6IFVwZGF0ZSBvdGhlciBoeXBlcmNhbGwNCj4gaW52b2tpbmcNCj4gDQo+IE9uIDAyLzIwLzIw
MTIgMTA6NDYgUE0sIExpdSBZdSB3cm90ZToNCj4gPiBEaXNjYXJkIHRoZSBvbGQgd2F5IHRoYXQg
aW52b2tlIGh5cGVyY2FsbCwgaW5zdGVhZCwgdXNlIGVwYXByDQo+ID4gcGFyYXZpcnQuDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBMaXUgWXUgPHl1LmxpdUBmcmVlc2NhbGUuY29tPg0KPiA+IC0t
LQ0KPiA+IHY1OiBuZXcgcGF0Y2gNCj4gPg0KPiA+ICBhcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20v
ZXBhcHJfaGNhbGxzLmggfCAgIDIyICsrKysrKysrKy0tLS0tLS0tLQ0KPiA+ICBhcmNoL3Bvd2Vy
cGMvaW5jbHVkZS9hc20vZnNsX2hjYWxscy5oICAgfCAgIDM2ICsrKysrKysrKysrKysrKy0tLS0t
LS0tDQo+IC0tLS0tLS0NCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspLCAy
OSBkZWxldGlvbnMoLSkNCj4gDQo+IE1ha2Ugc3VyZSBhbGwgdGhlIFRvcGF6L2VQQVBSIGRyaXZl
cnMgdGhhdCB1c2UgdGhpcyBzZWxlY3QgRVBBUFJfUEFSQVZJUlQuDQo+IA0KPiBIYXZlIHlvdSB0
ZXN0ZWQgd2l0aCBUb3Bhej8NCj4gDQoNCk5vdCB5ZXQgdGVzdC4NCg0KVGhhbmtzLA0KWXUNCg==
