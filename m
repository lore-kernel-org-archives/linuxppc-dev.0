Return-Path: <stuart.yoder@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0113.outbound.protection.outlook.com [157.56.110.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 679B41A006C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 04:39:23 +1000 (AEST)
From: Stuart Yoder <stuart.yoder@freescale.com>
To: Wang Dongsheng <Dongsheng.Wang@freescale.com>
CC: Scott Wood <scottwood@freescale.com>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, Zhao C.H. <chenhui.zhao@freescale.com>, "Huan
 Wang" <alison.wang@freescale.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, Wang Dongsheng
 <Dongsheng.Wang@freescale.com>, Yuantian Tang <Yuantian.Tang@freescale.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, Jin Jason
 <Jason.Jin@freescale.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v3 1/2] fsl: Add binding for RCPM
Date: Thu, 1 Oct 2015 17:05:43 +0000
Message-ID: <CY1PR0301MB0748AB1CE2D93FFD79FE6009874C0@CY1PR0301MB0748.namprd03.prod.outlook.com>
References: <1443083354-37369-1-git-send-email-dongsheng.wang@freescale.com>
 <CALRxmdDwGgxCG5SfSOaEXK8_fJcG4UUw_9D2=NA7nQhikDyb+A@mail.gmail.com>
In-Reply-To: <CALRxmdDwGgxCG5SfSOaEXK8_fJcG4UUw_9D2=NA7nQhikDyb+A@mail.gmail.com>
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

PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL2ZzbC9yY3BtLnR4
dA0KPiBAQCAtMCwwICsxLDYzIEBADQo+ICsqIFJ1biBDb250cm9sIGFuZCBQb3dlciBNYW5hZ2Vt
ZW50DQo+ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICtU
aGUgUkNQTSBwZXJmb3JtcyBhbGwgZGV2aWNlLWxldmVsIHRhc2tzIGFzc29jaWF0ZWQgd2l0aCBk
ZXZpY2UgcnVuIGNvbnRyb2wNCj4gK2FuZCBwb3dlciBtYW5hZ2VtZW50Lg0KPiArDQo+ICtSZXF1
aXJlZCBwcm9wZXJpdGVzOg0KPiArICAtIHJlZyA6IE9mZnNldCBhbmQgbGVuZ3RoIG9mIHRoZSBy
ZWdpc3RlciBzZXQgb2YgUkNQTSBibG9jay4NCg0Kcy9SQ1BNIGJsb2NrL3RoZSBSQ1BNIGJsb2Nr
Lw0KDQo+ICsgIC0gZnNsLCNyY3BtLXdha2V1cC1jZWxscyA6IFRoZSBudW1iZXIgb2YgY2VsbHMg
aW4gcmNwbS13YWtldXAgcHJvcGVydHkuDQoNCnMvcmNwbS13YWtldXAtcHJvcGVydHkvdGhlIHJj
cG0td2FrZXVwLXByb3BlcnR5Lw0KDQo+ICsgIC0gY29tcGF0aWJsZSA6IFNvdWxkIGNvbnRhaW4g
YSBjaGlwLXNwZWNpZmljIFJDUE0gYmxvY2sgY29tcGF0aWJsZSBzdHJpbmcNCg0Kcy9Tb3VsZC9T
aG91bGQNCg0KIlNob3VsZCIgbWVhbnMgaXQgaXMgcmVjb21tZW5kZWQsIGJ1dCBkb2VzIG5vdCBt
ZWFuICJtdXN0Ii4gIElzIGl0IHJlYWxseSBvcHRpb25hbD8NCg0KPiArICAgICAgIGFuZCAoaWYg
YXBwbGljYWJsZSkgbWF5IGNvbnRhaW4gYSBjaGFzc2lzLXZlcnNpb24gUkNQTSBjb21wYXRpYmxl
DQo+ICsgICAgICAgc3RyaW5nLiBDaGlwLXNwZWNpZmljIHN0cmluZ3MgYXJlIG9mIHRoZSBmb3Jt
ICJmc2wsPGNoaXA+LXJjcG0iLA0KPiArICAgICAgIHN1Y2ggYXM6DQo+ICsgICAgICAgKiAiZnNs
LHAyMDQxLXJjcG0iDQo+ICsgICAgICAgKiAiZnNsLHAzMDQxLXJjcG0iDQo+ICsgICAgICAgKiAi
ZnNsLHA0MDgwLXJjcG0iDQo+ICsgICAgICAgKiAiZnNsLHA1MDIwLXJjcG0iDQo+ICsgICAgICAg
KiAiZnNsLHA1MDQwLXJjcG0iDQo+ICsgICAgICAgKiAiZnNsLHQ0MjQwLXJjcG0iDQo+ICsgICAg
ICAgKiAiZnNsLGI0NDIwLXJjcG0iDQo+ICsgICAgICAgKiAiZnNsLGI0ODYwLXJjcG0iDQoNCjIg
b3IgMyBleGFtcGxlcyBpcyBlbm91Z2guDQoNCj4gKyAgICAgICBDaGFzc2lzLXZlcnNpb24gc3Ry
aW5ncyBhcmUgb2YgdGhlIGZvcm0gImZzbCxxb3JpcS1yY3BtLTx2ZXJzaW9uPiIsDQo+ICsgICAg
ICAgc3VjaCBhczoNCj4gKyAgICAgICAqICJmc2wscW9yaXEtcmNwbS0xLjAiOiBmb3IgY2hhc3Np
cyAxLjAgcmNwbQ0KPiArICAgICAgICogImZzbCxxb3JpcS1yY3BtLTIuMCI6IGZvciBjaGFzc2lz
IDIuMCByY3BtDQo+ICsgICAgICAgKiAiZnNsLHFvcmlxLXJjcG0tMi4xIjogZm9yIGNoYXNzaXMg
Mi4xIHJjcG0NCj4gKw0KPiArQWxsIHJlZmVyZW5jZXMgdG8gIjEuMCIgYW5kICIyLjAiIHJlZmVy
IHRvIHRoZSBRb3JJUSBjaGFzc2lzIHZlcnNpb24gdG8NCj4gK3doaWNoIHRoZSBjaGlwIGNvbXBs
aWVzLg0KPiArQ2hhc3NpcyBWZXJzaW9uICAgICAgICAgICAgICAgIEV4YW1wbGUgQ2hpcHMNCj4g
Ky0tLS0tLS0tLS0tLS0tLSAgICAgICAgICAgICAgICAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQo+ICsxLjAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcDQwODAsIHA1MDIwLCBw
NTA0MCwgcDIwNDEsIHAzMDQxDQo+ICsyLjAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdDQy
NDAsIGI0ODYwLCBiNDQyMA0KPiArMi4xICAgICAgICAgICAgICAgICAgICAgICAgICAgIHQxMDQw
LCBsczEwMjENCg0KTm90IHN1cmUgdGhpcyBiaW5kaW5nIGlzIHRoZSBwbGFjZSB0byBtYWludGFp
biBhIHRhYmxlIG9mIGNoYXNzaXMNCnZlcnNpb25zIHRvIFNvQ3MuDQoNClRoYW5rcywNClN0dWFy
dA0K
