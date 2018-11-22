Return-Path: <SRS0=R24o=OB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB95C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Nov 2018 02:36:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB1D5206BA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Nov 2018 02:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OcgaXQkw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB1D5206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 430k8H1ZLVzDqHv
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Nov 2018 13:35:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="OcgaXQkw";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.8.79; helo=eur04-vi1-obe.outbound.protection.outlook.com;
 envelope-from=xiaowei.bao@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="OcgaXQkw"; 
 dkim-atps=neutral
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-eopbgr80079.outbound.protection.outlook.com [40.107.8.79])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 430k5c2gLczDqGD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Nov 2018 13:33:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYJCo87X1I3xZzHFrJ5Q6exjlefVP64fgYyZUHpcb0Y=;
 b=OcgaXQkwIosstInfXC6oYV+IfP34HnaLxVnnzl7Rn5WgSwROuMxF2CWUjWj0exYp3NsbQ221sj2lC5sBws/iti818GXZjMC+kFlNx8J8nCxmsBL6YvWcXrgu6qr+4GADhhzoRjD8THS1BMG2bNQk7G93nAetUjygrIqJT4qjM9c=
Received: from HE1PR04MB1497.eurprd04.prod.outlook.com (10.163.176.23) by
 HE1PR04MB3243.eurprd04.prod.outlook.com (10.170.251.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.16; Thu, 22 Nov 2018 02:33:29 +0000
Received: from HE1PR04MB1497.eurprd04.prod.outlook.com
 ([fe80::dc32:150f:5344:715]) by HE1PR04MB1497.eurprd04.prod.outlook.com
 ([fe80::dc32:150f:5344:715%5]) with mapi id 15.20.1361.015; Thu, 22 Nov 2018
 02:33:29 +0000
From: Xiaowei Bao <xiaowei.bao@nxp.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: RE: [PATCHv4 0/3] dts: Add the property of IB and OB
Thread-Topic: [PATCHv4 0/3] dts: Add the property of IB and OB
Thread-Index: AQHTWdlkjmHFkxG22kG6Ctwa1JzotaVbOckAgAImCuA=
Date: Thu, 22 Nov 2018 02:33:29 +0000
Message-ID: <HE1PR04MB14978C967CFAE17815FF1CC8F5DB0@HE1PR04MB1497.eurprd04.prod.outlook.com>
References: <20171110034847.17891-1-xiaowei.bao@nxp.com>
 <20181120173021.GA29331@e107981-ln.cambridge.arm.com>
In-Reply-To: <20181120173021.GA29331@e107981-ln.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; HE1PR04MB3243;
 6:qi2t1B9O8p5QuUM1HDlk1hRLtpGZRatn55XrHqniYckW0MwUI2PYdoVdio7IDfVZJbxi9FDdJUTK93ZuY9JUqZgf0gxLapUPSB2H4PBejunkQPJJR/PyhD2a1bJ+QXY0HhhH+IbV89azg+9mDjnl7tO2Yd45hwsusCv/qSeBBtr4X6QS1VsKPOznQn25h3C4IN6NSfABzWcdlejN7vyd99mj/uA0Gc9rHdVI72NkM/Yyddc6hjwICL8lMDcTuJ+3kxBojxvZrY/nWti56miHv6+0ipSuHTnLyuY+ipZrklrQhoepihMeABrsBWTtWJ6wWNvQmjYWsMOCFhR3I2Ppbqpmq+/k9CbwbYIzDRsHfbUr/NQOKwVHc4O2R+GnwP53S6aogr095pNuZ+b1ZbLomJDPopvmuENjdpPRUP3FfuvQcobMJ1yG2XfyU1ADsWtLR4DsEPpXgjgKFksUODda/A==;
 5:IH0WaJrzoT205CmcU92Oln7RfqYuQJEXfViW1QMnULvQICXQ5mQhn6wHCFTXJ+oqOrYkH4Bm4hx1KqnNVuoRzWGPJzVgwweqqEvdjQjAhOl1p8JrMO/Ai+G3ZOhRQNPwj/D0XiyvWRBMZ9PkZF+IkYUozZnoszpynAF9XabBqy4=;
 7:sZkgWjZZO1mr++QGsxNZHCVco3Gfp9bdPAB6F4THV5cPDwyTSaywNZ59pWjr/uWb1A1fMAAkgUBiVFbZNbjod9GF80fOR8M1MuMlCmE0tPCca25+l3dgL6w2oM0oPoXrzYMkoEfpWJc59ebSuPTljA==
x-ms-office365-filtering-correlation-id: 44a8cd7d-b090-404c-7cd8-08d65022e370
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:HE1PR04MB3243; 
x-ms-traffictypediagnostic: HE1PR04MB3243:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaowei.bao@nxp.com; 
x-microsoft-antispam-prvs: <HE1PR04MB32439C0527243EFF27326706F5DB0@HE1PR04MB3243.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231442)(944501410)(4982022)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:HE1PR04MB3243; BCL:0; PCL:0; RULEID:; SRVR:HE1PR04MB3243; 
x-forefront-prvs: 0864A36BBF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(376002)(366004)(346002)(39860400002)(396003)(189003)(199004)(13464003)(6246003)(66066001)(2900100001)(39060400002)(9686003)(6306002)(6436002)(53936002)(2906002)(4326008)(6116002)(3846002)(6916009)(54906003)(316002)(71200400001)(71190400001)(105586002)(106356001)(7696005)(99286004)(6506007)(53546011)(229853002)(81166006)(74316002)(81156014)(305945005)(7736002)(45080400002)(8936002)(8676002)(14454004)(76176011)(186003)(256004)(102836004)(26005)(478600001)(476003)(446003)(11346002)(55016002)(86362001)(575784001)(33656002)(7416002)(97736004)(68736007)(25786009)(5660300001)(44832011)(486006)(966005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:HE1PR04MB3243;
 H:HE1PR04MB1497.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mwYdENmCdBtY+SMKuV1t0VvlnEQsFdDc/YzbqHJQ6ai7KYeOHlmjQgMWGUzCIXTYuuTxJ6KgWmzWnrDJ+s3FmTBnLxrzb+Ziy6Pv0tHH9ZYvxmqg1daG2Y4lYbxLIJ5RtM6AqI3t0FIM60jQftCQjbJnfNPP0RV1rxb5+1no3Rxj5tL7DMvpeQlDXUMPIcxIEtnvMpuBvlZnNUBw7rB8HR56WbFWXaMyikC/hiJhgdDz5ubTgj9EsPVs8ft5Wt32MrHVZuCucdfRrqX6zebwIyTYuLXyLB3RwGnaIn8JAAWyppQExeyBy3nvxrekvdT5oUjFPD/Q3tTaPosbDixm6lB8BxEBWw9qfadqG+lNOSY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a8cd7d-b090-404c-7cd8-08d65022e370
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2018 02:33:29.1757 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3243
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 Madalin-cristian Bucur <madalin.bucur@nxp.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "M.h. Lian" <minghuan.lian@nxp.com>,
 "hongtao.jia@nxp.com" <hongtao.jia@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "sumit.garg@nxp.com" <sumit.garg@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
 "kishon@ti.com" <kishon@ti.com>, "pbrobinson@gmail.com" <pbrobinson@gmail.com>,
 "songxiaowei@hisilicon.com" <songxiaowei@hisilicon.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "Z.q. Hou" <zhiqiang.hou@nxp.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Andy Tang <andy.tang@nxp.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Leo Li <leoyang.li@nxp.com>, "Y.B. LU" <yangbo.lu@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

SGkgTG9yZW56bywNCg0KWWVzLCB0aGVzZSBzZXJpZXMgcGF0Y2hlcyBjYW4gZHJvcCwgdGhhbmtz
IGEgbG90LiANCg0KQmVzdCByZWdhcmRzDQpYaWFvd2VpDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQpGcm9tOiBMb3JlbnpvIFBpZXJhbGlzaSA8bG9yZW56by5waWVyYWxpc2lAYXJtLmNv
bT4gDQpTZW50OiAyMDE4xOoxMdTCMjHI1SAxOjMxDQpUbzogWGlhb3dlaSBCYW8gPHhpYW93ZWku
YmFvQG54cC5jb20+DQpDYzogcm9iaCtkdEBrZXJuZWwub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNv
bTsgY2F0YWxpbi5tYXJpbmFzQGFybS5jb207IHdpbGwuZGVhY29uQGFybS5jb207IGJoZWxnYWFz
QGdvb2dsZS5jb207IHNoYXduZ3VvQGtlcm5lbC5vcmc7IE1hZGFsaW4tY3Jpc3RpYW4gQnVjdXIg
PG1hZGFsaW4uYnVjdXJAbnhwLmNvbT47IHN1bWl0LmdhcmdAbnhwLmNvbTsgWS5CLiBMVSA8eWFu
Z2JvLmx1QG54cC5jb20+OyBob25ndGFvLmppYUBueHAuY29tOyBBbmR5IFRhbmcgPGFuZHkudGFu
Z0BueHAuY29tPjsgTGVvIExpIDxsZW95YW5nLmxpQG54cC5jb20+OyBraXNob25AdGkuY29tOyBq
aW5nb29oYW4xQGdtYWlsLmNvbTsgcGJyb2JpbnNvbkBnbWFpbC5jb207IHNvbmd4aWFvd2VpQGhp
c2lsaWNvbi5jb207IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnOyBaLnEu
IEhvdSA8emhpcWlhbmcuaG91QG54cC5jb20+OyBNaW5na2FpIEh1IDxtaW5na2FpLmh1QG54cC5j
b20+OyBNLmguIExpYW4gPG1pbmdodWFuLmxpYW5AbnhwLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFU
Q0h2NCAwLzNdIGR0czogQWRkIHRoZSBwcm9wZXJ0eSBvZiBJQiBhbmQgT0INCg0KT24gRnJpLCBO
b3YgMTAsIDIwMTcgYXQgMTE6NDg6NDRBTSArMDgwMCwgQmFvIFhpYW93ZWkgd3JvdGU6DQo+IERl
cGVuZCBvbiANCj4gaHR0cHM6Ly9lbWVhMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5j
b20vP3VybD1odHRwJTNBJTJGJTJGcGF0Yw0KPiBod29yay5vemxhYnMub3JnJTJGcGF0Y2glMkY4
MTUzODIlMkYmYW1wO2RhdGE9MDIlN0MwMSU3Q3hpYW93ZWkuYmFvJTQwDQo+IG54cC5jb20lN0M2
NzUxODg1OTQ1Njc0MThjY2Y2YTA4ZDY0ZjBkZTlmNSU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5
YzUNCj4gYzMwMTYzNSU3QzAlN0MwJTdDNjM2NzgzMzE4NTE3MTkyOTcxJmFtcDtzZGF0YT1IaWxM
VCUyQjVUJTJCJTJCdWJweHJhOA0KPiBsNTRaVmlFRk43U0JDZjR2REI4ekRNV1VkNCUzRCZhbXA7
cmVzZXJ2ZWQ9MA0KPiANCj4gQmFvIFhpYW93ZWkgKDMpOg0KPiAgIEFSTXY4OiBkdHM6IGxzMTA0
NmE6IGFkZCB0aGUgcHJvcGVydHkgb2YgSUIgYW5kIE9CDQo+ICAgQVJNdjg6IGxheWVyc2NhcGU6
IGFkZCB0aGUgcGNpZSBlcCBmdW5jdGlvbiBzdXBwb3J0DQo+ICAgQVJNdjg6IHBjaWU6IG1ha2Ug
dGhlIERXQyBFUCBkcml2ZXIgc3VwcG9ydCBmb3IgbGF5ZXJzY2FwZQ0KPiANCj4gIGFyY2gvYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwNDZhLmR0c2kgfCAgIDYgKysNCj4gIGRyaXZl
cnMvcGNpL2R3Yy9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KPiAgZHJp
dmVycy9wY2kvZHdjL3BjaS1sYXllcnNjYXBlLmMgICAgICAgICAgICAgICB8IDEyMSArKysrKysr
KysrKysrKysrKysrKysrKy0tDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDEyMSBpbnNlcnRpb25zKCsp
LCA3IGRlbGV0aW9ucygtKQ0KDQpDYW4gSSBkcm9wIHRoaXMgc2VyaWVzIGZyb20gdGhlIGxpbnV4
LXBjaSBwYXRjaCBxdWV1ZSA/IEkgcmVja29uIGl0IGlzIHN1cGVyc2VkZWQgYnk6DQoNCmh0dHBz
Oi8vZW1lYTAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0El
MkYlMkZwYXRjaHdvcmsub3psYWJzLm9yZyUyRnBhdGNoJTJGOTkyOTI4JTJGJmFtcDtkYXRhPTAy
JTdDMDElN0N4aWFvd2VpLmJhbyU0MG54cC5jb20lN0M2NzUxODg1OTQ1Njc0MThjY2Y2YTA4ZDY0
ZjBkZTlmNSU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2MzY3
ODMzMTg1MTcxOTI5NzEmYW1wO3NkYXRhPWkzVSUyRjd1VCUyRm5vJTJGU0dWYzZWRDFnZzdZYm4w
elYlMkYlMkI4QTk2OThRSGZ1b1RvJTNEJmFtcDtyZXNlcnZlZD0wDQoNCmJ1dCBJIHdhbnRlZCB0
byBtYWtlIHN1cmUgdGhhdCdzIHRoZSBjYXNlLCBJIHJlYWxseSBjYW4ndCBmb2xsb3cgdGhlIHZl
cnNpb24gbnVtYmVyaW5nIHNvIEkgYW0gYXNraW5nLg0KDQpUaGFua3MsDQpMb3JlbnpvDQo=
