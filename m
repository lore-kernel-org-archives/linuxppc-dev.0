Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0145.outbound.protection.outlook.com [157.56.111.145])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 816E61A0B66
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Feb 2015 05:01:30 +1100 (AEDT)
Message-ID: <54E4D30C.9050507@Freescale.com>
Date: Wed, 18 Feb 2015 11:59:40 -0600
From: Emil Medve <Emilian.Medve@Freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC v2 01/10] fsl_bman: Add drivers for the Freescale DPAA BMan
References: <1424101581-22109-1-git-send-email-Emilian.Medve@Freescale.com>
 <1424101581-22109-2-git-send-email-Emilian.Medve@Freescale.com>
 <AC59CFF6-9DF2-444B-85CE-D0178C336418@kernel.crashing.org>
In-Reply-To: <AC59CFF6-9DF2-444B-85CE-D0178C336418@kernel.crashing.org>
Content-Type: text/plain; charset="windows-1252"
Cc: Geoff Thorpe <Geoff.Thorpe@Freescale.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Kumar,


Thanks for taking the time to review this

On 02/18/2015 11:43 AM, Kumar Gala wrote:
> On Feb 16, 2015, at 9:46 AM, Emil Medve <Emilian.Medve@freescale.com> wrote:
> 
>> From: Geoff Thorpe <Geoff.Thorpe@freescale.com>
>>
>> Change-Id: I075944acf740dbaae861104c17a9ff7247dec1be
>> Signed-off-by: Geoff Thorpe <Geoff.Thorpe@freescale.com>
>> ---
>> drivers/soc/Kconfig                  |    1 +
>> drivers/soc/Makefile                 |    1 +
>> drivers/soc/freescale/Kconfig        |   51 ++
>> drivers/soc/freescale/Makefile       |    7 +
>> drivers/soc/freescale/bman.c         |  611 ++++++++++++++++++++
>> drivers/soc/freescale/bman.h         |  524 +++++++++++++++++
>> drivers/soc/freescale/bman_api.c     | 1033 ++++++++++++++++++++++++++++++++++
>> drivers/soc/freescale/bman_portal.c  |  330 +++++++++++
>> drivers/soc/freescale/bman_priv.h    |  149 +++++
>> drivers/soc/freescale/dpaa_alloc.c   |  404 +++++++++++++
>> drivers/soc/freescale/dpaa_sys.h     |  235 ++++++++
>> drivers/soc/freescale/qbman_driver.c |   41 ++
>> include/linux/fsl_bman.h             |  511 +++++++++++++++++
> 
> If you are using drivers/soc than the include should probably be include/soc/freescale/

Will move/rename

> Also, any reason you guys aren’t using drivers/soc/fsl ?

Will rename


Cheers,
