Return-Path: <SRS0=ts8b=SV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84181C282DA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 10:09:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEB50218FD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 10:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="L8oYp/qd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEB50218FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44lsCF0xq5zDqVl
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 20:09:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.8.87; helo=eur04-vi1-obe.outbound.protection.outlook.com;
 envelope-from=horia.geanta@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="L8oYp/qd"; 
 dkim-atps=neutral
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-eopbgr80087.outbound.protection.outlook.com [40.107.8.87])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44lrtZ6J6rzDqTv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2019 19:54:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18TgJBx7dFa7kWnuEvTtelf7/vEaKlm0ee9YUxyCtBw=;
 b=L8oYp/qdC0jCAoIMWPeEzHEpLCn+n3iyz0OP1yXkN0TshBs7WUwSZpHYBnSujvfSuTxXNAqoYjMWmPKFznhkwIoZTS+UoOlCMWXKAne5VhqZwakObREhuJHDono1hUFMHZWw2tsRRUjdlAanESWmz0+bXB46/6d7QKEXU+tFiBw=
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com (52.134.3.153) by
 VI1PR0402MB3533.eurprd04.prod.outlook.com (52.134.4.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Fri, 19 Apr 2019 09:54:54 +0000
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::484c:ab68:81c4:51be]) by VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::484c:ab68:81c4:51be%5]) with mapi id 15.20.1792.020; Fri, 19 Apr 2019
 09:54:54 +0000
From: Horia Geanta <horia.geanta@nxp.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] powerpc/dts/fsl: add crypto node alias for B4
Thread-Topic: [PATCH] powerpc/dts/fsl: add crypto node alias for B4
Thread-Index: AQHU3xx6IuR7orhNF0iEBCjr3J4Y8w==
Date: Fri, 19 Apr 2019 09:54:54 +0000
Message-ID: <VI1PR0402MB34857D2DAF16A611B11A119598270@VI1PR0402MB3485.eurprd04.prod.outlook.com>
References: <20190320125516.12277-1-horia.geanta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e892e04-32e6-40ff-0b68-08d6c4ad12d2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VI1PR0402MB3533; 
x-ms-traffictypediagnostic: VI1PR0402MB3533:
x-microsoft-antispam-prvs: <VI1PR0402MB353377691D818E844D35FA7798270@VI1PR0402MB3533.eurprd04.prod.outlook.com>
x-forefront-prvs: 0012E6D357
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(346002)(136003)(366004)(376002)(189003)(199004)(66066001)(97736004)(73956011)(3846002)(6116002)(26005)(4744005)(53546011)(102836004)(66446008)(2906002)(186003)(6506007)(229853002)(66476007)(66556008)(6436002)(99286004)(64756008)(68736007)(76116006)(66946007)(110136005)(256004)(86362001)(7696005)(76176011)(316002)(54906003)(25786009)(71190400001)(71200400001)(6246003)(4326008)(53936002)(9686003)(55016002)(8676002)(81156014)(8936002)(5660300002)(446003)(81166006)(33656002)(44832011)(52536014)(476003)(486006)(74316002)(7736002)(478600001)(14454004)(305945005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB3533;
 H:VI1PR0402MB3485.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0vqEHQ4VAyXewXNtThP2ywXF+VCY4qsFL73jZLsgRt4bUtuRTA5V00Ql3jDqO8WW5f69l9ymz6dQMXG08W7ACvU/75GG6icPzw/CJjSezcGuEqZG4P4cyYfzWtrLKGo5TF1e86Mpm3+BcNpT6HFW7e0/ayxElgaQHP2tXrNjESSVYV4POHUOHP9J6vjJJurhZOQLz8NnDVBl2DFS8QbzXx8+/QTxbyMyj3AL1y/z8Lzn1v0GOxTEawxBEXVZOrjdMfpsL+axyXvECgxtUnEEuMfpPrRPctwSLgd52Odmv21PS5F3d5r1g8a+I9l7ijrLSQY/PZs3NgKRazQaxffkdEgrH/zYgEIr+ev0rubPKxRj2Nm8S4vYv/Dcpc7gruCdtH/DezRxKEWXeXGI3w/WoDiA1pjXO15SeGpQbagLCrg=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e892e04-32e6-40ff-0b68-08d6c4ad12d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2019 09:54:54.2104 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3533
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
Cc: Scott Wood <oss@buserror.net>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Has this slipped through?=0A=
=0A=
On 3/20/2019 2:57 PM, Horia Geant=E3 wrote:=0A=
> crypto node alias is needed by U-boot to identify the node and=0A=
> perform fix-ups, like adding "fsl,sec-era" property.=0A=
> =0A=
> Signed-off-by: Horia Geant=E3 <horia.geanta@nxp.com>=0A=
> ---=0A=
>  arch/powerpc/boot/dts/fsl/b4qds.dtsi | 1 +=0A=
>  1 file changed, 1 insertion(+)=0A=
> =0A=
> diff --git a/arch/powerpc/boot/dts/fsl/b4qds.dtsi b/arch/powerpc/boot/dts=
/fsl/b4qds.dtsi=0A=
> index 999efd3bc167..05be919f3545 100644=0A=
> --- a/arch/powerpc/boot/dts/fsl/b4qds.dtsi=0A=
> +++ b/arch/powerpc/boot/dts/fsl/b4qds.dtsi=0A=
> @@ -40,6 +40,7 @@=0A=
>  	interrupt-parent =3D <&mpic>;=0A=
>  =0A=
>  	aliases {=0A=
> +		crypto =3D &crypto;=0A=
>  		phy_sgmii_10 =3D &phy_sgmii_10;=0A=
>  		phy_sgmii_11 =3D &phy_sgmii_11;=0A=
>  		phy_sgmii_1c =3D &phy_sgmii_1c;=0A=
> =0A=
