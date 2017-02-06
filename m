Return-Path: <yuantian.tang@nxp.com>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0060.outbound.protection.outlook.com [104.47.0.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vGxwK0kXbzDqDy
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Feb 2017 17:12:48 +1100 (AEDT)
From: "Y.T. Tang" <yuantian.tang@nxp.com>
To: Leo Li <pku.leo@gmail.com>
CC: Scott Wood <oss@buserror.net>, Michael Turquette
 <mturquette@baylibre.com>, Russell King <linux@armlinux.org.uk>, Stephen Boyd
 <sboyd@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J.
 Wysocki" <rjw@rjwysocki.net>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, Leo Li <leoyang.li@nxp.com>, "X.F. Ren"
 <xiaofeng.ren@nxp.com>
Subject: RE: [PATCH v3 2/2] cpufreq: qoriq: Don't look at clock implementation
 details
Date: Mon, 6 Feb 2017 06:12:40 +0000
Message-ID: <DB6PR0402MB2837F79AC0E88F5FAEEDB823F0400@DB6PR0402MB2837.eurprd04.prod.outlook.com>
References: <1466058085-19353-1-git-send-email-oss@buserror.net>
 <1466058085-19353-2-git-send-email-oss@buserror.net>
 <146785501714.73491.8643317356949121718@resonance>
 <1467864803.32358.63.camel@buserror.net>
 <146794477678.73491.8244253339435407853@resonance>
 <1468012014.32358.74.camel@buserror.net>
 <DB6PR0401MB2648CA1169D59950CD8BEC78F0080@DB6PR0401MB2648.eurprd04.prod.outlook.com>
 <CADRPPNR0xh_9Q3FZ_-94QD-B7PP=aGBySSi1+n=RmmjvkpKYzA@mail.gmail.com>
In-Reply-To: <CADRPPNR0xh_9Q3FZ_-94QD-B7PP=aGBySSi1+n=RmmjvkpKYzA@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="_002_DB6PR0402MB2837F79AC0E88F5FAEEDB823F0400DB6PR0402MB2837_"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_002_DB6PR0402MB2837F79AC0E88F5FAEEDB823F0400DB6PR0402MB2837_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMZW8gTGkgW21haWx0bzpwa3Uu
bGVvQGdtYWlsLmNvbV0NCj4gU2VudDogRnJpZGF5LCBGZWJydWFyeSAwMywgMjAxNyAyOjEyIEFN
DQo+IFRvOiBZLlQuIFRhbmcgPHl1YW50aWFuLnRhbmdAbnhwLmNvbT4NCj4gQ2M6IFNjb3R0IFdv
b2QgPG9zc0BidXNlcnJvci5uZXQ+OyBNaWNoYWVsIFR1cnF1ZXR0ZQ0KPiA8bXR1cnF1ZXR0ZUBi
YXlsaWJyZS5jb20+OyBSdXNzZWxsIEtpbmcgPGxpbnV4QGFybWxpbnV4Lm9yZy51az47DQo+IFN0
ZXBoZW4gQm95ZCA8c2JveWRAY29kZWF1cm9yYS5vcmc+OyBWaXJlc2ggS3VtYXINCj4gPHZpcmVz
aC5rdW1hckBsaW5hcm8ub3JnPjsgUmFmYWVsIEouIFd5c29ja2kgPHJqd0Byand5c29ja2kubmV0
PjsgbGludXgtDQo+IGNsa0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXBtQHZnZXIua2VybmVsLm9y
ZzsgbGludXhwcGMtDQo+IGRldkBsaXN0cy5vemxhYnMub3JnOyBMZW8gTGkgPGxlb3lhbmcubGlA
bnhwLmNvbT47IFguRi4gUmVuDQo+IDx4aWFvZmVuZy5yZW5AbnhwLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2MyAyLzJdIGNwdWZyZXE6IHFvcmlxOiBEb24ndCBsb29rIGF0IGNsb2NrDQo+
IGltcGxlbWVudGF0aW9uIGRldGFpbHMNCj4gDQo+IE9uIFR1ZSwgSnVsIDE5LCAyMDE2IGF0IDEw
OjAyIFBNLCBZdWFudGlhbiBUYW5nIDx5dWFudGlhbi50YW5nQG54cC5jb20+DQo+IHdyb3RlOg0K
PiA+DQo+ID4gUElORy4NCj4gPg0KPiA+IFJlZ2FyZHMsDQo+ID4gWXVhbnRpYW4NCj4gPg0KPiA+
ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IFNjb3R0IFdvb2QgW21h
aWx0bzpvc3NAYnVzZXJyb3IubmV0XQ0KPiA+ID4gU2VudDogU2F0dXJkYXksIEp1bHkgMDksIDIw
MTYgNTowNyBBTQ0KPiA+ID4gVG86IE1pY2hhZWwgVHVycXVldHRlIDxtdHVycXVldHRlQGJheWxp
YnJlLmNvbT47IFJ1c3NlbGwgS2luZw0KPiA+ID4gPGxpbnV4QGFybWxpbnV4Lm9yZy51az47IFN0
ZXBoZW4gQm95ZCA8c2JveWRAY29kZWF1cm9yYS5vcmc+Ow0KPiBWaXJlc2gNCj4gPiA+IEt1bWFy
IDx2aXJlc2gua3VtYXJAbGluYXJvLm9yZz47IFJhZmFlbCBKLiBXeXNvY2tpDQo+ID4gPiA8cmp3
QHJqd3lzb2NraS5uZXQ+DQo+ID4gPiBDYzogbGludXgtY2xrQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgtcG1Admdlci5rZXJuZWwub3JnOyBsaW51eHBwYy0NCj4gPiA+IGRldkBsaXN0cy5vemxhYnMu
b3JnOyBZdWFudGlhbiBUYW5nIDx5dWFudGlhbi50YW5nQG54cC5jb20+Ow0KPiA+ID4gWWFuZy1M
ZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNvbT47IFhpYW9mZW5nIFJlbg0KPiA+ID4gPHhpYW9mZW5n
LnJlbkBueHAuY29tPg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAyLzJdIGNwdWZyZXE6
IHFvcmlxOiBEb24ndCBsb29rIGF0IGNsb2NrDQo+ID4gPiBpbXBsZW1lbnRhdGlvbiBkZXRhaWxz
DQo+ID4gPg0KPiA+ID4gT24gVGh1LCAyMDE2LTA3LTA3IGF0IDE5OjI2IC0wNzAwLCBNaWNoYWVs
IFR1cnF1ZXR0ZSB3cm90ZToNCj4gPiA+ID4gUXVvdGluZyBTY290dCBXb29kICgyMDE2LTA3LTA2
IDIxOjEzOjIzKQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gT24gV2VkLCAyMDE2LTA3LTA2IGF0IDE4
OjMwIC0wNzAwLCBNaWNoYWVsIFR1cnF1ZXR0ZSB3cm90ZToNCj4gPiA+ID4gPiA+DQo+ID4gPiA+
ID4gPiBRdW90aW5nIFNjb3R0IFdvb2QgKDIwMTYtMDYtMTUgMjM6MjE6MjUpDQo+ID4gPiA+ID4g
PiA+DQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IC1zdGF0aWMgc3RydWN0IGRldmljZV9u
b2RlICpjcHVfdG9fY2xrX25vZGUoaW50IGNwdSkNCj4gPiA+ID4gPiA+ID4gK3N0YXRpYyBzdHJ1
Y3QgY2xrICpjcHVfdG9fY2xrKGludCBjcHUpDQo+ID4gPiA+ID4gPiA+ICB7DQo+ID4gPiA+ID4g
PiA+IC0gICAgICAgc3RydWN0IGRldmljZV9ub2RlICpucCwgKmNsa19ucDsNCj4gPiA+ID4gPiA+
ID4gKyAgICAgICBzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wOw0KPiA+ID4gPiA+ID4gPiArICAgICAg
IHN0cnVjdCBjbGsgKmNsazsNCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gICAgICAgICBp
ZiAoIWNwdV9wcmVzZW50KGNwdSkpDQo+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICByZXR1
cm4gTlVMTDsgQEAgLTExMiwzNyArODAsMjggQEAgc3RhdGljDQo+ID4gPiA+ID4gPiA+IHN0cnVj
dCBkZXZpY2Vfbm9kZSAqY3B1X3RvX2Nsa19ub2RlKGludA0KPiA+ID4gPiA+ID4gPiBjcHUpDQo+
ID4gPiA+ID4gPiA+ICAgICAgICAgaWYgKCFucCkNCj4gPiA+ID4gPiA+ID4gICAgICAgICAgICAg
ICAgIHJldHVybiBOVUxMOw0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiAtICAgICAgIGNs
a19ucCA9IG9mX3BhcnNlX3BoYW5kbGUobnAsICJjbG9ja3MiLCAwKTsNCj4gPiA+ID4gPiA+ID4g
LSAgICAgICBpZiAoIWNsa19ucCkNCj4gPiA+ID4gPiA+ID4gLSAgICAgICAgICAgICAgIHJldHVy
biBOVUxMOw0KPiA+ID4gPiA+ID4gPiAtDQo+ID4gPiA+ID4gPiA+ICsgICAgICAgY2xrID0gb2Zf
Y2xrX2dldChucCwgMCk7DQo+ID4gPiA+ID4gPiBXaHkgbm90IHVzZSBkZXZtX2Nsa19nZXQgaGVy
ZT8NCj4gPiA+ID4gPiBkZXZtX2Nsa19nZXQoKSBpcyBhIHdyYXBwZXIgYXJvdW5kIGNsa19nZXQo
KSB3aGljaCBpcyBub3QgdGhlDQo+ID4gPiA+ID4gc2FtZSBhcyBvZl9jbGtfZ2V0KCkuICBXaGF0
IGRldmljZSB3b3VsZCB5b3UgcGFzcyB0bw0KPiA+ID4gPiA+IGRldm1fY2xrX2dldCgpLCBhbmQg
d2hhdCBuYW1lIHdvdWxkIHlvdSBwYXNzPw0KPiA+ID4gPiBJJ20gZnV6enkgb24gd2hldGhlciBv
ciBub3QgeW91IGdldCBhIHN0cnVjdCBkZXZpY2UgZnJvbSBhIGNwdWZyZXENCj4gPiA+ID4gZHJp
dmVyLiBJZiBzbywgdGhlbiB0aGF0IHdvdWxkIGJlIHRoZSBvbmUgdG8gdXNlLiBJIHdvdWxkIGhv
cGUNCj4gPiA+ID4gdGhhdCBjcHVmcmVxIGRyaXZlcnMgbW9kZWwgY3B1cyBhcyBkZXZpY2VzLCBi
dXQgSSdtIHJlYWxseSBub3QNCj4gPiA+ID4gc3VyZSB3aXRob3V0IGxvb2tpbmcgaW50byB0aGUg
Y29kZS4NCj4gPiA+DQo+ID4gPiBJdCdzIG5vdCB0aGUgY3B1ZnJlcSBjb2RlIHRoYXQgcHJvdmlk
ZXMgaXQsIGJ1dCBnZXRfY3B1X2RldmljZSgpDQo+ID4gPiBjb3VsZCBiZSB1c2VkLg0KPiA+ID4N
Cj4gPiA+IERvIHlvdSBoYXZlIGFueSBjb21tZW50cyBvbiB0aGUgZmlyc3QgcGF0Y2ggb2YgdGhp
cyBzZXQ/DQo+IA0KPiANCj4gQW55IGFjdGlvbiBvbiB0aGlzIHBhdGNoPyAgVGhpcyBwYXRjaCBp
cyBzdGlsbCBhIGRlcGVuZGVuY3kgZm9yIGNwdWZyZXEgdG8gd29yaw0KPiBvbiBhbGwgUW9ySVEg
cGxhdGZvcm1zLg0KPiANClRoaXMgcGF0Y2ggY2FuIGJlIGFjY2VwdGVkIG9uIGNvbmRpdGlvbiB0
aGF0IHRoZSBhdHRhY2hlZCBwYXRjaCBpcyBhY2NlcHRlZC4NCkJ1dCB1bmZvcnR1bmF0ZWx5LCB0
aGUgYXR0YWNoZWQgcGF0Y2ggaGFzIGJlZW4gc2VudCBmb3IgYSByZWFsbHkgbG9uZyB0aW1lIGFu
ZCBubyBmZWVkYmFjay4NCg0KUmVnYXJkcywNCll1YW50aWFuDQoNCj4gUmVnYXJkcywNCj4gTGVv
DQo=

--_002_DB6PR0402MB2837F79AC0E88F5FAEEDB823F0400DB6PR0402MB2837_
Content-Type: message/rfc822
Content-Disposition: attachment;
	creation-date="Mon, 06 Feb 2017 06:12:35 GMT";
	modification-date="Mon, 06 Feb 2017 06:12:35 GMT"

Received: from AMSPR04MB485.eurprd04.prod.outlook.com (10.242.106.140) by
 DBXPR04MB495.eurprd04.prod.outlook.com (10.141.233.22) with Microsoft SMTP
 Server (TLS) id 15.1.511.8 via Mailbox Transport; Sun, 12 Jun 2016 03:16:44
 +0000
Received: from AM4PR0401MB1698.eurprd04.prod.outlook.com (10.165.244.20) by
 AMSPR04MB485.eurprd04.prod.outlook.com (10.242.106.140) with Microsoft SMTP
 Server (TLS) id 15.1.511.8; Sun, 12 Jun 2016 03:16:44 +0000
Received: from DB5PR04CA0032.eurprd04.prod.outlook.com (10.164.34.170) by
 AM4PR0401MB1698.eurprd04.prod.outlook.com (10.165.244.20) with Microsoft SMTP
 Server (TLS) id 15.1.517.8; Sun, 12 Jun 2016 03:16:43 +0000
Received: from DB3FFO11FD054.protection.gbl (2a01:111:f400:7e04::139) by
 DB5PR04CA0032.outlook.office365.com (2a01:111:e400:598c::42) with Microsoft
 SMTP Server (TLS) id 15.1.517.8 via Frontend Transport; Sun, 12 Jun 2016
 03:16:43 +0000
Received: from host.buserror.net (209.198.135.123) by
 DB3FFO11FD054.mail.protection.outlook.com (10.47.217.126) with Microsoft SMTP
 Server (TLS) id 15.1.497.8 via Frontend Transport; Sun, 12 Jun 2016 03:16:42
 +0000
Received: from c-75-72-173-242.hsd1.mn.comcast.net ([75.72.173.242] helo=snotra.am.freescale.net)
	by host.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
	(Exim 4.84_2)
	(envelope-from <oss@buserror.net>)
	id 1bBvsy-0006cF-CW; Sat, 11 Jun 2016 22:16:29 -0500
From: Scott Wood <oss@buserror.net>
To: Russell King <linux@armlinux.org.uk>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Y.T. Tang"
	<yuantian.tang@nxp.com>, Leo Li <leoyang.li@nxp.com>, "X.F. Ren"
	<xiaofeng.ren@nxp.com>, Scott Wood <scottwood@freescale.com>
Subject: [RESEND PATCH 1/2] clk: Add consumer APIs for discovering possible
 parent clocks
Thread-Topic: [RESEND PATCH 1/2] clk: Add consumer APIs for discovering
 possible parent clocks
Thread-Index: AQHRxFjZCC8SZHvpgk6kPG1iM/Ns3w==
Date: Sun, 12 Jun 2016 03:16:25 +0000
Message-ID: <1465701386-6220-1-git-send-email-oss@buserror.net>
Content-Language: en-US
X-MS-Exchange-Organization-AuthSource: DB3FFO11FD054.protection.gbl
X-MS-Has-Attach: 
X-MS-Exchange-Organization-Network-Message-Id: f5c94f0d-61a8-42fa-cbc4-08d3926ffa68
X-MS-TNEF-Correlator: 
received-spf: None (protection.outlook.com: buserror.net does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: 1;DBXPR04MB495;9:Jjb1DXgEdjSo5cKMEueLWaxZsAZaSFJ+XzH+rMVYScrUFagx7b5FP1taqXiFtHqhu62Z28hk2wNj17KxCHMXuTZAw1x8mPON2sJFXJMKqjnAKLumH2ofj6oH6ynETpoKzIbhxR9NSxOFhGSg2hyLdiWX4oMC3arBch9F2I+VCKk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0

From: Scott Wood <scottwood@freescale.com>

Commit fc4a05d4b0eb ("clk: Remove unused provider APIs") removed
__clk_get_num_parents() and clk_hw_get_parent_by_index(), leaving only
true provider API versions that operate on struct clk_hw.

qoriq-cpufreq needs these functions in order to determine the options
it has for calling clk_set_parent() and thus populate the cpufreq
table, so revive them as legitimate consumer APIs.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
Previously sent as http://patchwork.ozlabs.org/patch/519803/

Russell, could you please either ACK this or comment, as CLK API
maintainer?

 drivers/clk/clk.c   | 19 +++++++++++++++++++
 include/linux/clk.h | 31 +++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index d584004..d61a3fe 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -290,6 +290,12 @@ struct clk_hw *__clk_get_hw(struct clk *clk)
 }
 EXPORT_SYMBOL_GPL(__clk_get_hw);

+unsigned int clk_get_num_parents(struct clk *clk)
+{
+       return !clk ? 0 : clk->core->num_parents;
+}
+EXPORT_SYMBOL_GPL(clk_get_num_parents);
+
 unsigned int clk_hw_get_num_parents(const struct clk_hw *hw)
 {
        return hw->core->num_parents;
@@ -358,6 +364,19 @@ static struct clk_core *clk_core_get_parent_by_index(s=
truct clk_core *core,
        return core->parents[index];
 }

+struct clk *clk_get_parent_by_index(struct clk *clk, unsigned int index)
+{
+       struct clk_core *parent;
+
+       if (!clk)
+               return NULL;
+
+       parent =3D clk_core_get_parent_by_index(clk->core, index);
+
+       return !parent ? NULL : parent->hw->clk;
+}
+EXPORT_SYMBOL_GPL(clk_get_parent_by_index);
+
 struct clk_hw *
 clk_hw_get_parent_by_index(const struct clk_hw *hw, unsigned int index)
 {
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 0df4a51..937de0e 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -392,6 +392,26 @@ int clk_set_parent(struct clk *clk, struct clk *parent=
);
 struct clk *clk_get_parent(struct clk *clk);

 /**
+ * clk_get_parent_by_index - get a possible parent clock by index
+ * @clk: clock source
+ * @index: index into the array of possible parents of this clock
+ *
+ * Returns struct clk corresponding to the requested possible
+ * parent clock source, or NULL.
+ */
+struct clk *clk_get_parent_by_index(struct clk *clk,
+                                   unsigned int index);
+
+/**
+ * clk_get_num_parents - get number of possible parents
+ * @clk: clock source
+ *
+ * Returns the number of possible parents of this clock,
+ * which can then be enumerated using clk_get_parent_by_index().
+ */
+unsigned int clk_get_num_parents(struct clk *clk);
+
+/**
  * clk_get_sys - get a clock based upon the device name
  * @dev_id: device name
  * @con_id: connection ID
@@ -461,6 +481,17 @@ static inline struct clk *clk_get_parent(struct clk *c=
lk)
        return NULL;
 }

+struct clk *clk_get_parent_by_index(struct clk *clk,
+                                   unsigned int index)
+{
+       return NULL;
+}
+
+unsigned int clk_get_num_parents(struct clk *clk)
+{
+       return 0;
+}
+
 #endif

 /* clk_prepare_enable helps cases using clk_enable in non-atomic context. =
*/
--
2.5.0


--_002_DB6PR0402MB2837F79AC0E88F5FAEEDB823F0400DB6PR0402MB2837_--
