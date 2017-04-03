Return-Path: <roy.pledge@nxp.com>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1e::61d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vxjNS2TgxzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 05:49:11 +1000 (AEST)
From: Roy Pledge <roy.pledge@nxp.com>
To: Rob Herring <robh@kernel.org>
CC: "robin.murphy@arm.com" <robin.murphy@arm.com>, "oss@buserror.net"
 <oss@buserror.net>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, Madalin-Cristian Bucur <madalin.bucur@nxp.com>
Subject: Re: [RFC PATCH 4/5] dt-bindings: soc/fsl: Update reserved memory
 binding for QBMan
Date: Mon, 3 Apr 2017 19:49:03 +0000
Message-ID: <VI1PR04MB32166AA6361CD6F24DBC3AAF86080@VI1PR04MB3216.eurprd04.prod.outlook.com>
References: <1490822037-6752-1-git-send-email-roy.pledge@nxp.com>
 <1490822037-6752-5-git-send-email-roy.pledge@nxp.com>
 <20170403154229.mf63zeiwv5naxyrr@rob-hp-laptop>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 4/3/2017 11:42 AM, Rob Herring wrote:=0A=
> On Wed, Mar 29, 2017 at 05:13:56PM -0400, Roy Pledge wrote:=0A=
>> Updates the QMan and BMan device tree bindings for reserved memory=0A=
>> nodes. This makes the reserved memory allocation compatiable with=0A=
> s/compatiable/compatible/=0A=
>=0A=
>> the shared-dma-pool usage.=0A=
> This change is not backwards compatible. Please state that and explain =
=0A=
> why that is okay. If PPC needs to not change, then the old strings and =
=0A=
> properties should remain, but deprecated.=0A=
I think I can make the old device trees compatible since the=0A=
"compatible" string changed without too much effort or ifdefery in the=0A=
code.  However I would like to eventually see all PPC users move to the=0A=
new mode as I do believe it is more in alignment with the spirit of the=0A=
reserved-memory framework that is in the kernel.  Do I need to mention=0A=
the old mode in the binding.txt file?  I'm trying to keep things clean=0A=
so someone reading the binding doesn't get a headache and trying to=0A=
preserve my own sanity as we move forward with adding new features to=0A=
this driver.=0A=
=0A=
Roy=0A=
