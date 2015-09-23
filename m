Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 785D51A0014
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2015 09:24:22 +1000 (AEST)
Date: Wed, 23 Sep 2015 16:24:17 -0700 (PDT)
Message-Id: <20150923.162417.814596822188458346.davem@davemloft.net>
To: linux@arm.linux.org.uk
Cc: f.fainelli@gmail.com, devicetree@vger.kernel.org,
 frowand.list@gmail.com, grant.likely@linaro.org, isubramanian@apm.com,
 kchudgar@apm.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 leoli@freescale.com, michal.simek@xilinx.com, netdev@vger.kernel.org,
 rric@kernel.org, robh+dt@kernel.org, soren.brinkmann@xilinx.com,
 sgoutham@cavium.com, thomas.petazzoni@free-electrons.com
Subject: Re: [PATCH v2 0/9] Phy, mdiobus, and netdev struct device fixes
From: David Miller <davem@davemloft.net>
In-Reply-To: <20150922161710.GA21084@n2100.arm.linux.org.uk>
References: <20150922161710.GA21084@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RnJvbTogUnVzc2VsbCBLaW5nIC0gQVJNIExpbnV4IDxsaW51eEBhcm0ubGludXgub3JnLnVrPg0K
RGF0ZTogVHVlLCAyMiBTZXAgMjAxNSAxNzoxNzoxMCArMDEwMA0KDQo+IFRoaXMgaXMgdGhlIHNl
Y29uZCB2ZXJzaW9uIG9mIHRoZSBzZXJpZXMsIHdpdGggdGhlIGNvbW1lbnRzIERhdmlkIGhhZA0K
PiBvbiB0aGUgZmlyc3QgcGF0Y2ggZml4ZWQgdXAuICBPcmlnaW5hbCBzZXJpZXMgZGVzY3JpcHRp
b24gd2l0aCB1cGRhdGVkDQo+IGRpZmZzdGF0IGJlbG93Lg0KDQpUaGlzIG5lZWRzIHNvbWUgYnVp
bGQgZml4ZXM6DQoNCmRyaXZlcnMvbmV0L2V0aGVybmV0L2FwbS94Z2VuZS94Z2VuZV9lbmV0X2h3
LmM6IEluIGZ1bmN0aW9uIKF4Z2VuZV9lbmV0X3BoeV9jb25uZWN0ojoNCmRyaXZlcnMvbmV0L2V0
aGVybmV0L2FwbS94Z2VuZS94Z2VuZV9lbmV0X2h3LmM6Njk0OjIwOiBlcnJvcjogdG9vIGZldyBh
cmd1bWVudHMgdG8gZnVuY3Rpb24goW9mX3BoeV9jb25uZWN0og0KICAgcGRhdGEtPnBoeV9kZXYg
PSBvZl9waHlfY29ubmVjdChuZGV2LCBwaHlfbnAsDQogICAgICAgICAgICAgICAgICAgIF4NCklu
IGZpbGUgaW5jbHVkZWQgZnJvbSBkcml2ZXJzL25ldC9ldGhlcm5ldC9hcG0veGdlbmUveGdlbmVf
ZW5ldF9tYWluLmg6MzE6MCwNCiAgICAgICAgICAgICAgICAgZnJvbSBkcml2ZXJzL25ldC9ldGhl
cm5ldC9hcG0veGdlbmUveGdlbmVfZW5ldF9ody5jOjIyOg0KaW5jbHVkZS9saW51eC9vZl9tZGlv
Lmg6MTg6Mjc6IG5vdGU6IGRlY2xhcmVkIGhlcmUNCiBleHRlcm4gc3RydWN0IHBoeV9kZXZpY2Ug
Km9mX3BoeV9jb25uZWN0KHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsDQogICAgICAgICAgICAgICAg
ICAgICAgICAgICBeDQo=
