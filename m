Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0106.outbound.protection.outlook.com [207.46.100.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E79441A0C18
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 10:26:37 +1100 (AEDT)
Message-ID: <54EBB6BF.4080900@Freescale.com>
Date: Mon, 23 Feb 2015 17:24:47 -0600
From: Emil Medve <Emilian.Medve@Freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@Freescale.com>, Igal.Liberman
 <igal.liberman@Freescale.com>
Subject: Re: [PATCH][v3] powerpc/mpc85xx: Add FMan platform support
References: <1424268285-8491-1-git-send-email-igal.liberman@freescale.com>
 <1424728915.4698.8.camel@freescale.com>
In-Reply-To: <1424728915.4698.8.camel@freescale.com>
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Scott,


On 02/23/2015 04:01 PM, Scott Wood wrote:
> On Wed, 2015-02-18 at 16:04 +0200, Igal.Liberman wrote:
>> From: Igal Liberman <Igal.Liberman@freescale.com>
>>
>> Get the FMan devices/sub-nodes (MAC, MDIO, etc.) auto-probed
>>
>> Signed-off-by: Igal Liberman <Igal.Liberman@freescale.com>
>> ---
>>  arch/powerpc/platforms/85xx/common.c          |    1 +
>>  arch/powerpc/platforms/85xx/corenet_generic.c |    3 +++
>>  2 files changed, 4 insertions(+)
> 
> What changed from v2?

v1,2 were based on an internal tree/branch and had some reference to
'fsl,dpaa':

>  	{ .compatible = "fsl,dpaa", },


Cheers,
