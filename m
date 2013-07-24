Return-Path: <B40534@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0189.outbound.messaging.microsoft.com [213.199.154.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D36FE2C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 12:17:53 +1000 (EST)
From: Wang Dongsheng-B40534 <B40534@freescale.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: RE: [PATCH 2/2] cpuidle: export cpuidle_idle_call symbol
Date: Wed, 24 Jul 2013 02:17:17 +0000
Message-ID: <ABB05CD9C9F68C46A5CEDC7F15439259FDCB0E@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1374571681-31911-1-git-send-email-dongsheng.wang@freescale.com>
 <1374571681-31911-2-git-send-email-dongsheng.wang@freescale.com>
 <16375354.KJ7QhjYo9F@vostro.rjw.lan>
In-Reply-To: <16375354.KJ7QhjYo9F@vostro.rjw.lan>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFmYWVsIEouIFd5c29j
a2kgW21haWx0bzpyandAc2lzay5wbF0NCj4gU2VudDogV2VkbmVzZGF5LCBKdWx5IDI0LCAyMDEz
IDU6MzMgQU0NCj4gVG86IFdhbmcgRG9uZ3NoZW5nLUI0MDUzNA0KPiBDYzogZGFuaWVsLmxlemNh
bm9AbGluYXJvLm9yZzsgbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBsaW51eHBwYy0NCj4gZGV2
QGxpc3RzLm96bGFicy5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzJdIGNwdWlkbGU6IGV4
cG9ydCBjcHVpZGxlX2lkbGVfY2FsbCBzeW1ib2wNCj4gDQo+IE9uIFR1ZXNkYXksIEp1bHkgMjMs
IDIwMTMgMDU6Mjg6MDEgUE0gRG9uZ3NoZW5nIFdhbmcgd3JvdGU6DQo+ID4gRnJvbTogV2FuZyBE
b25nc2hlbmcgPGRvbmdzaGVuZy53YW5nQGZyZWVzY2FsZS5jb20+DQo+ID4NCj4gPiBFeHBvcnQg
Y3B1aWRsZV9pZGxlX2NhbGwgc3ltYm9sLCBtYWtlIHRoaXMgZnVuY3Rpb24gY2FuIGJlIGludm9r
ZWQgaW4NCj4gPiB0aGUgbW9kdWxlLg0KPiANCj4gV2h5Pw0KPiANCk9uIHBvd2VycGMgcGxhdGZv
cm0sIHRoZXJlIGlzIGFscmVhZHkgaGF2ZSBjcHUgaWRsZSBpbXBsZW1lbnRhdGlvbi4NCg0KSSB3
YW50IHVzZSBjcHVpZGxlIGZyYW1ld29yayB0byBjb250cm9sIHZhcmlvdXMgbG93IHBvd2VyIG1v
ZGVzLiBCdXQgbmVlZCB0bw0KYmUgY29tcGF0aWJsZSB3aXRoIHRoZSBjdXJyZW50IGltcGxlbWVu
dGF0aW9uLiBBbmQgZHJpdmVyIHNob3VsZCBiZSBhcyBhIG1vZHVsZSwNClRoZSB1c2VyIGNhbiB1
c2luZyB0aGlzIG1vZHVsZSBhdCBhbnkgdGltZS4NCg0KV2UgbmVlZCBjcHVpZGxlX2lkbGVfY2Fs
bCB0byBkcml2ZSB0aGUgbmV3IGltcGxlbWVudGF0aW9uIGluIG1vZHVsZXMuDQoNClRoYW5rcy4N
Ci0gZG9uZ3NoZW5nDQoNCj4gUmFmYWVsDQoNCg0K
