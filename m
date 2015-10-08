Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0104.outbound.protection.outlook.com [157.56.111.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6AC651A0023
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Oct 2015 13:32:19 +1100 (AEDT)
From: Wang Dongsheng <Dongsheng.Wang@freescale.com>
To: Stuart Yoder <stuart.yoder@freescale.com>
CC: Scott Wood <scottwood@freescale.com>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, Zhao C.H. <chenhui.zhao@freescale.com>, "Huan
 Wang" <alison.wang@freescale.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, Yuantian Tang <Yuantian.Tang@freescale.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, Jin Jason
 <Jason.Jin@freescale.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v3 1/2] fsl: Add binding for RCPM
Date: Thu, 8 Oct 2015 02:32:10 +0000
Message-ID: <SN1PR0301MB161632E7B6EB131A35C137939D350@SN1PR0301MB1616.namprd03.prod.outlook.com>
References: <1443083354-37369-1-git-send-email-dongsheng.wang@freescale.com>
 <CALRxmdDwGgxCG5SfSOaEXK8_fJcG4UUw_9D2=NA7nQhikDyb+A@mail.gmail.com>
 <CY1PR0301MB0748AB1CE2D93FFD79FE6009874C0@CY1PR0301MB0748.namprd03.prod.outlook.com>
In-Reply-To: <CY1PR0301MB0748AB1CE2D93FFD79FE6009874C0@CY1PR0301MB0748.namprd03.prod.outlook.com>
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

PiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvZnNsL3JjcG0u
dHh0DQo+ID4gQEAgLTAsMCArMSw2MyBAQA0KPiA+ICsqIFJ1biBDb250cm9sIGFuZCBQb3dlciBN
YW5hZ2VtZW50DQo+ID4gKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCj4gPiArVGhlIFJDUE0gcGVyZm9ybXMgYWxsIGRldmljZS1sZXZlbCB0YXNrcyBhc3NvY2lh
dGVkIHdpdGggZGV2aWNlIHJ1bg0KPiA+ICtjb250cm9sIGFuZCBwb3dlciBtYW5hZ2VtZW50Lg0K
PiA+ICsNCj4gPiArUmVxdWlyZWQgcHJvcGVyaXRlczoNCj4gPiArICAtIHJlZyA6IE9mZnNldCBh
bmQgbGVuZ3RoIG9mIHRoZSByZWdpc3RlciBzZXQgb2YgUkNQTSBibG9jay4NCj4gDQo+IHMvUkNQ
TSBibG9jay90aGUgUkNQTSBibG9jay8NCj4gDQo+ID4gKyAgLSBmc2wsI3JjcG0td2FrZXVwLWNl
bGxzIDogVGhlIG51bWJlciBvZiBjZWxscyBpbiByY3BtLXdha2V1cCBwcm9wZXJ0eS4NCj4gDQo+
IHMvcmNwbS13YWtldXAtcHJvcGVydHkvdGhlIHJjcG0td2FrZXVwLXByb3BlcnR5Lw0KPiANCj4g
PiArICAtIGNvbXBhdGlibGUgOiBTb3VsZCBjb250YWluIGEgY2hpcC1zcGVjaWZpYyBSQ1BNIGJs
b2NrIGNvbXBhdGlibGUNCj4gPiArIHN0cmluZw0KPiANCj4gcy9Tb3VsZC9TaG91bGQNCj4gDQo+
ICJTaG91bGQiIG1lYW5zIGl0IGlzIHJlY29tbWVuZGVkLCBidXQgZG9lcyBub3QgbWVhbiAibXVz
dCIuICBJcyBpdCByZWFsbHkNCj4gb3B0aW9uYWw/DQo+IA0KDQpUaGFua3MgZm9yIHlvdXIgcGF0
aWVudCBleHBsYWluLCBjaGFuZ2UgdG8gIm11c3QiLg0KDQpSZWdhcmRzLA0KLURvbmdzaGVuZw0K
DQo+ID4gKyAgICAgICBhbmQgKGlmIGFwcGxpY2FibGUpIG1heSBjb250YWluIGEgY2hhc3Npcy12
ZXJzaW9uIFJDUE0gY29tcGF0aWJsZQ0KPiA+ICsgICAgICAgc3RyaW5nLiBDaGlwLXNwZWNpZmlj
IHN0cmluZ3MgYXJlIG9mIHRoZSBmb3JtICJmc2wsPGNoaXA+LXJjcG0iLA0KPiA+ICsgICAgICAg
c3VjaCBhczoNCj4gPiArICAgICAgICogImZzbCxwMjA0MS1yY3BtIg0KPiA+ICsgICAgICAgKiAi
ZnNsLHAzMDQxLXJjcG0iDQo+ID4gKyAgICAgICAqICJmc2wscDQwODAtcmNwbSINCj4gPiArICAg
ICAgICogImZzbCxwNTAyMC1yY3BtIg0KPiA+ICsgICAgICAgKiAiZnNsLHA1MDQwLXJjcG0iDQo+
ID4gKyAgICAgICAqICJmc2wsdDQyNDAtcmNwbSINCj4gPiArICAgICAgICogImZzbCxiNDQyMC1y
Y3BtIg0KPiA+ICsgICAgICAgKiAiZnNsLGI0ODYwLXJjcG0iDQo+IA0KPiAyIG9yIDMgZXhhbXBs
ZXMgaXMgZW5vdWdoLg0KPiANCj4gPiArICAgICAgIENoYXNzaXMtdmVyc2lvbiBzdHJpbmdzIGFy
ZSBvZiB0aGUgZm9ybSAiZnNsLHFvcmlxLXJjcG0tPHZlcnNpb24+IiwNCj4gPiArICAgICAgIHN1
Y2ggYXM6DQo+ID4gKyAgICAgICAqICJmc2wscW9yaXEtcmNwbS0xLjAiOiBmb3IgY2hhc3NpcyAx
LjAgcmNwbQ0KPiA+ICsgICAgICAgKiAiZnNsLHFvcmlxLXJjcG0tMi4wIjogZm9yIGNoYXNzaXMg
Mi4wIHJjcG0NCj4gPiArICAgICAgICogImZzbCxxb3JpcS1yY3BtLTIuMSI6IGZvciBjaGFzc2lz
IDIuMSByY3BtDQo+ID4gKw0KPiA+ICtBbGwgcmVmZXJlbmNlcyB0byAiMS4wIiBhbmQgIjIuMCIg
cmVmZXIgdG8gdGhlIFFvcklRIGNoYXNzaXMgdmVyc2lvbg0KPiA+ICt0byB3aGljaCB0aGUgY2hp
cCBjb21wbGllcy4NCj4gPiArQ2hhc3NpcyBWZXJzaW9uICAgICAgICAgICAgICAgIEV4YW1wbGUg
Q2hpcHMNCj4gPiArLS0tLS0tLS0tLS0tLS0tICAgICAgICAgICAgICAgIC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCj4gPiArMS4wICAgICAgICAgICAgICAgICAgICAgICAgICAgIHA0
MDgwLCBwNTAyMCwgcDUwNDAsIHAyMDQxLCBwMzA0MQ0KPiA+ICsyLjAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdDQyNDAsIGI0ODYwLCBiNDQyMA0KPiA+ICsyLjEgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdDEwNDAsIGxzMTAyMQ0KPiANCj4gTm90IHN1cmUgdGhpcyBiaW5kaW5nIGlz
IHRoZSBwbGFjZSB0byBtYWludGFpbiBhIHRhYmxlIG9mIGNoYXNzaXMgdmVyc2lvbnMgdG8NCj4g
U29Dcy4NCj4gDQo+IFRoYW5rcywNCj4gU3R1YXJ0DQo=
