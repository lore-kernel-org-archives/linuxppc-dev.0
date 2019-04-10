Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50528C10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 10:37:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1BAB20830
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 10:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="j9mZG/XG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1BAB20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fLGC1bQ6zDqN8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 20:37:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.0.89; helo=eur02-am5-obe.outbound.protection.outlook.com;
 envelope-from=viorel.suman@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="j9mZG/XG"; 
 dkim-atps=neutral
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00089.outbound.protection.outlook.com [40.107.0.89])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fLBx4g79zDqN9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 20:35:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYOdesluUcFUpe+7kBR/gaw5+2leLL27O0J39LxMI2U=;
 b=j9mZG/XGYNww1LdbFKCX7fmxLZ0l917p/ll7Xu2IlwURlZHEHhYc2j03fON+3ZXW+oGEEKnsiMx6BH7ZpFC/10ryU7vsJ9Ys0sKMm5k7K9j8op8xqAv3OuDxR+j7DQz5vimbk52iLYRljhBzE2hXlqmHAwSMEJMA7J8mWMoBFgY=
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com (20.177.48.157) by
 VI1PR04MB5549.eurprd04.prod.outlook.com (20.178.122.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Wed, 10 Apr 2019 10:34:57 +0000
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::2594:3cf0:20a2:8888]) by VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::2594:3cf0:20a2:8888%3]) with mapi id 15.20.1792.009; Wed, 10 Apr 2019
 10:34:57 +0000
From: Viorel Suman <viorel.suman@nxp.com>
To: "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>
Subject: Re: [EXT] Re: [PATCH v2 1/3] ASoC: fsl_audmix: remove "model"
 attribute
Thread-Topic: [EXT] Re: [PATCH v2 1/3] ASoC: fsl_audmix: remove "model"
 attribute
Thread-Index: AQHU7sc9qpmulFGub0K/+sjdGTcqzaY0zlCAgABmNoA=
Date: Wed, 10 Apr 2019 10:34:57 +0000
Message-ID: <1554892497.14997.13.camel@nxp.com>
References: <1554809242-27475-1-git-send-email-viorel.suman@nxp.com>
 <1554809242-27475-2-git-send-email-viorel.suman@nxp.com>
 <20190410042906.GC3032@Asurada>
In-Reply-To: <20190410042906.GC3032@Asurada>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=viorel.suman@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aef6e93b-59cb-4223-f480-08d6bda02d7e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:VI1PR04MB5549; 
x-ms-traffictypediagnostic: VI1PR04MB5549:
x-microsoft-antispam-prvs: <VI1PR04MB5549915959C68AC0B212E740922E0@VI1PR04MB5549.eurprd04.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(136003)(396003)(366004)(39860400002)(199004)(189003)(105586002)(14444005)(71190400001)(71200400001)(256004)(5660300002)(68736007)(3450700001)(2351001)(106356001)(1411001)(8676002)(81166006)(81156014)(1730700003)(5024004)(508600001)(36756003)(66066001)(5640700003)(97736004)(102836004)(6506007)(486006)(25786009)(1361003)(2616005)(11346002)(446003)(26005)(4326008)(186003)(76176011)(6246003)(6916009)(14454004)(2501003)(8936002)(229853002)(6436002)(53936002)(7416002)(6486002)(2906002)(6116002)(44832011)(54906003)(43066004)(99286004)(3846002)(316002)(103116003)(86362001)(305945005)(4744005)(6512007)(7736002)(476003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5549;
 H:VI1PR04MB4704.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zeoqRRN/pPyTaqZoGw75uuWG84q20hoETvU4LKZyhZFFxgEnbYFTUAX4W2JI5oPz5a1lIzqb1jVxIL6lbXhccDTcz6N2hSxM71GeeKeVwVrAL/rBrlZULlztid4P/H9X6URi9xAhjo8Jr7LQ+WGdQ4hARwT/u96DFUQofqokvc1K+FqdGAPQn1S4PEgy6G5bjB96DkVoegTBp5BuR4SeSSZYbNtWlQrSjBjNLsUEZqlAP6Oa2QzXYZtVFKD83unHihmU07ltcSvJzKCCuvQCq3MUmZ0t69ba2UvGNBo6T+cIFUwD4AW5ghPjnWTWaIUIhnyClUExyvHBEyV04LE6IOe2wwDMp516ilUBY7gjGjW5SXywrOmraekhBIjgIylc/9PbfL7sWh++L3Q7pMEKDMYV5rjQVoaHnwftgvUDLG0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <19968812BB3F654D91C05730D04AC48D@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aef6e93b-59cb-4223-f480-08d6bda02d7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 10:34:57.3324 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5549
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
Reply-To: Viorel Suman <viorel.suman@nxp.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "tiwai@suse.com" <tiwai@suse.com>,
 "viorel.suman@gmail.com" <viorel.suman@gmail.com>,
 "Julia.Lawall@lip6.fr" <Julia.Lawall@lip6.fr>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>, "perex@perex.cz" <perex@perex.cz>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

SGkgTmljb2xpbiwNCg0KT24gTWEsIDIwMTktMDQtMDkgYXQgMjE6MjkgLTA3MDAsIE5pY29saW4g
Q2hlbiB3cm90ZToNCj4gV0FSTklORzogVGhpcyBlbWFpbCB3YXMgY3JlYXRlZCBvdXRzaWRlIG9m
IE5YUC4gRE8gTk9UIENMSUNLIGxpbmtzIG9yDQo+IGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVj
b2duaXplIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMNCj4gc2FmZS4NCj4gDQo+
IA0KPiANCj4gT24gVHVlLCBBcHIgMDksIDIwMTkgYXQgMTE6Mjc6MzlBTSArMDAwMCwgVmlvcmVs
IFN1bWFuIHdyb3RlOg0KPiA+IA0KPiA+IFVzZSAib2ZfZGV2aWNlX2lkLmRhdGEiIHRvIHNwZWNp
ZnkgdGhlIG1hY2hpbmUgZHJpdmVyDQo+ID4gaW5zdGVhZCBvZiAibW9kZWwiIERUUyBhdHRyaWJ1
dGUuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogVmlvcmVsIFN1bWFuIDx2aW9yZWwuc3VtYW5A
bnhwLmNvbT4NCj4gQWNrZWQtYnk6IE5pY29saW4gQ2hlbiA8bmljb2xlb3RzdWthQGdtYWlsLmNv
bT4NCj4gDQo+ID4gDQo+ID4gLS0tDQo+ID4gwqBzb3VuZC9zb2MvZnNsL2ZzbF9hdWRtaXguYyB8
IDQzICsrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0NCj4gPiAtLS0tLS0tLS0NCj4g
PiDCoDEgZmlsZSBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCAyMCBkZWxldGlvbnMoLSkNCj4g
PiANCj4gPiArwqDCoMKgwqDCoHByaXYtPnBkZXYgPSBwbGF0Zm9ybV9kZXZpY2VfcmVnaXN0ZXJf
ZGF0YSgmcGRldi0+ZGV2LCBtZHJ2LA0KPiA+IDAsIE5VTEwsDQo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoDApOw0KPiBXb3VsZCB5b3UgcGxlYXNlIHNlbmQgYSBz
ZXBhcmF0ZSBwYXRjaCB0byByZXBsYWNlICJwZGV2LT5kZXYiPw0KDQpUaGFuayB5b3UgZm9yIHJl
dmlldy4gWWVzLCB3aWxsIHNlbmQgVjMuDQoNCi9WaW9yZWwNCg0K
