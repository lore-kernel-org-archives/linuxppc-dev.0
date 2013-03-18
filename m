Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F0BCF2C0151
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2013 02:01:40 +1100 (EST)
Subject: Re: [PATCH 5/5 v9] iommu/fsl: Freescale PAMU driver and iommu
 implementation.
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <C5ECD7A89D1DC44195F34B25E172658D40ABB4@039-SN2MPN1-013.039d.mgd.msft.net>
Date: Mon, 18 Mar 2013 09:59:53 -0500
Message-Id: <CCCE947A-1C24-40C2-9341-BBF3F5C00D98@kernel.crashing.org>
References: <1363200580-11623-1-git-send-email-Varun.Sethi@freescale.com>
 <0080B56D-8417-41B9-8341-665457D04DE6@kernel.crashing.org>
 <C5ECD7A89D1DC44195F34B25E172658D40ABB4@039-SN2MPN1-013.039d.mgd.msft.net>
To: Sethi Varun-B16395 <B16395@freescale.com>
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Yoder Stuart-B08248 <B08248@freescale.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 17, 2013, at 10:48 AM, Sethi Varun-B16395 wrote:

>>>=20
>>> +	guts_node =3D of_find_compatible_node(NULL, NULL,
>>> +			"fsl,qoriq-device-config-1.0");
>>=20
>> This doesn't work for T4 or B4 device trees.
>>=20
> [Sethi Varun-B16395]hmm.... I need to use the dcfg space for this.

Let's see with the SoC arch's if something like =
"fsl,qoriq-device-config-2.0" makes sense for T4 & B4.

- k=
