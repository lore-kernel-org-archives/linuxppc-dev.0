Return-Path: <B40534@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0253.outbound.messaging.microsoft.com [213.199.154.253])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7654F2C02F2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2013 19:48:55 +1000 (EST)
From: Wang Dongsheng-B40534 <B40534@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: RE: [RFC 2/2] powerpc/cputable: add wait feature for CPU kernel
 features
Date: Wed, 10 Jul 2013 09:47:23 +0000
Message-ID: <ABB05CD9C9F68C46A5CEDC7F15439259FBEC53@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1373444876-7783-1-git-send-email-dongsheng.wang@freescale.com>
 <1373444876-7783-2-git-send-email-dongsheng.wang@freescale.com>
 <1373448151.19894.16.camel@pasglop>
 <ABB05CD9C9F68C46A5CEDC7F15439259FBEBFC@039-SN2MPN1-022.039d.mgd.msft.net>
 <1373448801.19894.17.camel@pasglop>
In-Reply-To: <1373448801.19894.17.camel@pasglop>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Li Yang-R58472 <r58472@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Zhao Chenhui-B35336 <B35336@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmVuamFtaW4gSGVycmVu
c2NobWlkdCBbbWFpbHRvOmJlbmhAa2VybmVsLmNyYXNoaW5nLm9yZ10NCj4gU2VudDogV2VkbmVz
ZGF5LCBKdWx5IDEwLCAyMDEzIDU6MzMgUE0NCj4gVG86IFdhbmcgRG9uZ3NoZW5nLUI0MDUzNA0K
PiBDYzogV29vZCBTY290dC1CMDc0MjE7IGdhbGFrQGtlcm5lbC5jcmFzaGluZy5vcmc7IFpoYW8g
Q2hlbmh1aS1CMzUzMzY7IExpDQo+IFlhbmctUjU4NDcyOyBsaW51eHBwYy1kZXZAbGlzdHMub3ps
YWJzLm9yZw0KPiBTdWJqZWN0OiBSZTogW1JGQyAyLzJdIHBvd2VycGMvY3B1dGFibGU6IGFkZCB3
YWl0IGZlYXR1cmUgZm9yIENQVSBrZXJuZWwNCj4gZmVhdHVyZXMNCj4gDQo+IE9uIFdlZCwgMjAx
My0wNy0xMCBhdCAwOToyOSArMDAwMCwgV2FuZyBEb25nc2hlbmctQjQwNTM0IHdyb3RlOg0KPiA+
ID4NCj4gPiBZZXMsIHRoZSB3YWl0IGluc3RydWN0aW9ucyBpcyBmb3IgY3B1IGlkbGUsIEl0IHdp
bGwgYmUgbWFrZSBjcHUgaW50bw0KPiA+IGxvdyBwb3dlciBtb2RlLCBsaWtlIERPWkUgJiBOQVAu
IEVhY2ggdGhyZWFkIGhhdmUgdGhpcy4NCj4gDQo+IEkgZG9uJ3QgbmVlZCB5b3UgdG8gdGVsbCBt
ZSBieSBlbWFpbCwgSSBuZWVkIHlvdSB0byBwdXQgYSBwcm9wZXIgY29tbWVudA0KPiBpbiB0aGUg
cGF0Y2ggc3VibWlzc2lvbiBzbyBpdCBlbmRzIHVwIGluIHRoZSByZXBvc2l0b3J5IGFuZCBpZiBw
b3NzaWJsZSBhDQo+IGJpdCBtb3JlIGRldGFpbGVkIHRoYW4gdGhhdC4NCj4gDQo+IEJlbi4NCj4g
DQpPaywgVGhhbmtzIGJlbi4NCkkgd2lsbCBhZGQgYSBkZXNjcmlwdGlvbiBmb3IgbmV4dCBSRkMg
cGF0Y2guDQoNCi0gZG9uZ3NoZW5nDQo=
