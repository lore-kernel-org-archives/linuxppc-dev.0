Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6049C10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 10:51:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 223FA20830
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 10:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="h1FawtM9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 223FA20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fLYP5JgYzDqH4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 20:51:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.4.59; helo=eur03-db5-obe.outbound.protection.outlook.com;
 envelope-from=viorel.suman@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="h1FawtM9"; 
 dkim-atps=neutral
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr40059.outbound.protection.outlook.com [40.107.4.59])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fLVz3rQNzDq74
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 20:48:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m69pppyKVe/pZ24UZn/3/RjiDuiUCfyB9J9pxoEtGho=;
 b=h1FawtM9DbOnkJT5FwchS9aLlcL5Ahqr9ut3rrg6fGYT6axwnkQf4M4ncOiCeQyeAsbVnDiSkyMUiwytVeKj1BWQp1FxBZRoZT41CmplzKbgsP3fUzqH0Ep+Yw+dwiOg9PhyTWdPOE8TX/8pCSqHf+DJaMU+o4tV+SJdFLhS/qU=
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com (20.177.48.157) by
 VI1PR04MB5373.eurprd04.prod.outlook.com (20.178.120.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.21; Wed, 10 Apr 2019 10:48:48 +0000
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::2594:3cf0:20a2:8888]) by VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::2594:3cf0:20a2:8888%3]) with mapi id 15.20.1792.009; Wed, 10 Apr 2019
 10:48:48 +0000
From: Viorel Suman <viorel.suman@nxp.com>
To: "broonie@kernel.org" <broonie@kernel.org>
Subject: Re: [EXT] Re: [PATCH v3 2/4] dt-bindings: fsl, audmix: remove "model"
 attribute
Thread-Topic: [EXT] Re: [PATCH v3 2/4] dt-bindings: fsl, audmix: remove "model"
 attribute
Thread-Index: AQHU74lmyyBkUG6e/0616TsvWRCKcKY1NFyAgAAChQA=
Date: Wed, 10 Apr 2019 10:48:48 +0000
Message-ID: <1554893328.14997.15.camel@nxp.com>
References: <1554892629-17646-1-git-send-email-viorel.suman@nxp.com>
 <1554892629-17646-3-git-send-email-viorel.suman@nxp.com>
 <20190410103947.GH6106@sirena.org.uk>
In-Reply-To: <20190410103947.GH6106@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=viorel.suman@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 712a4071-5c1f-414d-0312-08d6bda21cea
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VI1PR04MB5373; 
x-ms-traffictypediagnostic: VI1PR04MB5373:
x-microsoft-antispam-prvs: <VI1PR04MB5373FFF6E77E4517FF204B49922E0@VI1PR04MB5373.eurprd04.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(376002)(39860400002)(396003)(366004)(346002)(189003)(199004)(68736007)(103116003)(8676002)(25786009)(2501003)(105586002)(53936002)(3846002)(11346002)(6512007)(14454004)(6116002)(2351001)(3450700001)(6246003)(106356001)(44832011)(2906002)(4326008)(316002)(71190400001)(81156014)(1730700003)(81166006)(71200400001)(5640700003)(54906003)(2616005)(8936002)(508600001)(4744005)(36756003)(476003)(446003)(6916009)(7416002)(186003)(7736002)(305945005)(6506007)(76176011)(102836004)(66066001)(6486002)(6436002)(99286004)(26005)(256004)(97736004)(486006)(5660300002)(43066004)(229853002)(86362001)(142933001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5373;
 H:VI1PR04MB4704.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tSXqy4EIrOHU6Km3kVg70TFgXzTDIZnCsYZQCoiNNBPzInpOcJ4Jo0Yo6GUVcL0X1SOWmFhGhOKTyXMTJ1ajeLUStM0BnhjlGa5TgRQ3qq7ZSU2cm9fTymABrt7E66NpeVVNjmCyf8WcUmz12BBqzkaUhvr4SEJiiVq2lNcMOo7IoatBvg0wzDDAW5lWO1wsPO8kM6LxhVqUrXjIG2Vb0ACvmsiLyHgRqVg/StqKgVSjeWKkNWqyt1wyJWVAP3bafwti1Srm2AGXastm+qnv9ESeyGnaxCKSHoz/Hl/hRPRqOoTe0wfYtWMVf8nJ3NjtniVdNyUFJ4KqTp6ze6e6EJybXqlUNwwzGVXg6/+BUbzOc5Yoe/E/UxkIpNC+y9/2xd2RfvutV4m/sAjpXHHn+3IPNMnEBkgxLVHDCkpQT/M=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B84F3E90B75994381C04DD8D34477F2@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 712a4071-5c1f-414d-0312-08d6bda21cea
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 10:48:48.5312 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5373
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
 "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "tiwai@suse.com" <tiwai@suse.com>,
 "viorel.suman@gmail.com" <viorel.suman@gmail.com>,
 "Julia.Lawall@lip6.fr" <Julia.Lawall@lip6.fr>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>, "perex@perex.cz" <perex@perex.cz>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

SGkgTWFyaywNCg0KT24gTWksIDIwMTktMDQtMTAgYXQgMTE6MzkgKzAxMDAsIE1hcmsgQnJvd24g
d3JvdGU6DQo+IE9uIFdlZCwgQXByIDEwLCAyMDE5IGF0IDEwOjM3OjMwQU0gKzAwMDAsIFZpb3Jl
bCBTdW1hbiB3cm90ZToNCj4gPiANCj4gPiBSZW1vdmUgIm1vZGVsIiBhdHRyaWJ1dGUuDQo+ID4g
DQo+ID4gU2lnbmVkLW9mZi1ieTogVmlvcmVsIFN1bWFuIDx2aW9yZWwuc3VtYW5AbnhwLmNvbT4N
Cj4gPiBBY2tlZC1ieTogTmljb2xpbiBDaGVuIDxuaWNvbGVvdHN1a2FAZ21haWwuY29tPg0KPiBQ
bGVhc2UgdXNlIHN1YmplY3QgbGluZXMgbWF0Y2hpbmcgdGhlIHN0eWxlIGZvciB0aGUgc3Vic3lz
dGVtLsKgwqBUaGlzDQo+IG1ha2VzIGl0IGVhc2llciBmb3IgcGVvcGxlIHRvIGlkZW50aWZ5IHJl
bGV2YW50IHBhdGNoZXMuDQoNClN1cmUsIHRoYW5rIHlvdSwgZG8gSSBoYXZlIHRvIHNlbmQgVjQg
d2l0aCBzdWJqZWN0IGZpeGVkID8=
