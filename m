Return-Path: <Igal.Liberman@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0128.outbound.protection.outlook.com [65.55.169.128])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1351F1A0BEB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 21:11:09 +1000 (AEST)
From: "Igal.Liberman@freescale.com" <Igal.Liberman@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH] powerpc/dts: Move pll0/1-div4 index
Date: Mon, 20 Apr 2015 11:10:59 +0000
Message-ID: <DM2PR03MB38320A3D701B771E163B8F3E6E00@DM2PR03MB383.namprd03.prod.outlook.com>
References: <1429186105-6991-1-git-send-email-igal.liberman@freescale.com>
 <1429249343.32545.53.camel@freescale.com>
In-Reply-To: <1429249343.32545.53.camel@freescale.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNClJlZ2FyZHMsDQpJZ2FsIExpYmVybWFuLg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+IEZyb206IFdvb2QgU2NvdHQtQjA3NDIxDQo+IFNlbnQ6IEZyaWRheSwgQXByaWwgMTcs
IDIwMTUgODo0MiBBTQ0KPiBUbzogTGliZXJtYW4gSWdhbC1CMzE5NTANCj4gQ2M6IGRldmljZXRy
ZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZw0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIXSBwb3dlcnBjL2R0czogTW92ZSBwbGwwLzEtZGl2NCBpbmRleA0KPiAN
Cj4gT24gVGh1LCAyMDE1LTA0LTE2IGF0IDE1OjA4ICswMzAwLCBJZ2FsLkxpYmVybWFuIHdyb3Rl
Og0KPiA+IEZyb206IElnYWwgTGliZXJtYW4gPElnYWwuTGliZXJtYW5AZnJlZXNjYWxlLmNvbT4N
Cj4gPg0KPiA+IFRoaXMgcGF0Y2ggdXBkYXRlcyBwbGwwLzEtZGl2NCBpbmRleCB0byAnMycuDQo+
ID4gT3JpZ2luYWxseSBpdCB3YXMgJzInLg0KPiA+DQo+ID4gVGhlIGZvbGxvd2luZyBwYXRjaCBh
ZGRzIHBsbDAvMS1kaXYzIG9wdGlvbjoNCj4gPiAJaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9y
Zy9wYXRjaC80NjExNTEvDQo+ID4gQWZ0ZXIgdGhpcyBwYXRjaCwgaW5kZXggJzInIGJlY29tZXMg
cGxsMC8xLWRpdjMuDQo+ID4NCj4gPiBUaGlzIHBhdGNoIGJhc2VkIG9uIHRvcCBvZiB0aGUgZm9s
bG93aW5nOg0KPiA+IAlodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3BhdGNoLzQ2MTgxMS8N
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IElnYWwgTGliZXJtYW4gPElnYWwuTGliZXJtYW5AZnJl
ZXNjYWxlLmNvbT4NCj4gDQo+IFRoaXMgbmVlZHMgdG8gYmUgZG9uZSBpbiB0aGUgc2FtZSBwYXRj
aCBhcyB0aGUgcHJvdmlkZXIgY2hhbmdlLCB0byBhdm9pZCBhDQo+IGJ1Z2d5IGludGVybWVkaWF0
ZSBzdGF0ZS4NCj4gDQo+IFdpbGwgdGhlcmUgYmUgYSBuZXcgYmluZGluZyBwYXRjaCBjb21pbmc/
DQo+IA0KDQpPSywgSSdsbCBhZGQgdGhvc2UgY2hhbmdlcyBhcyBvbiBwYXRjaC4NCg0KUmVnYXJk
aW5nIHRoZSBiaW5kaW5nLA0KSSBhbHJlYWR5IHN1Ym1pdHRlZCBodHRwczovL3BhdGNod29yay5v
emxhYnMub3JnL3BhdGNoLzQ2MTE1MC8NCkRvIHlvdSBtZWFuIHRoYXQgSSBzaG91bGQgYWRkIGNv
bW1lbnQgdGhhdCB0aGUgZHJpdmVyIHBhcnNlcyB0aGUgbm9kZSBieSByZWFkaW5nIHRoZSBudW1i
ZXIgb2YgaW5wdXQgY2xvY2tzIGFuZCBub3QgdGhlIGNvbXBhdGlibGU/DQoNCj4gLVNjb3R0DQo+
IA0KDQpJZ2FsDQoNCg==
