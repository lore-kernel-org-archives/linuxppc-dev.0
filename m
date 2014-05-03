Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0235.outbound.protection.outlook.com [207.46.163.235])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7E33814015E
 for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2014 16:51:40 +1000 (EST)
Message-ID: <5364904E.5070900@Freescale.com>
Date: Sat, 3 May 2014 01:44:30 -0500
From: Emil Medve <Emilian.Medve@Freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@Freescale.com>, Lijun Pan <LIJUN.PAN@Freescale.com>
Subject: Re: powerpc/mpc85xx: Remove P1023 RDS support
References: <1397841480-2652-1-git-send-email-Lijun.Pan@freescale.com>
 <20140503001318.GA19925@home.buserror.net>
In-Reply-To: <20140503001318.GA19925@home.buserror.net>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Scott,


On 05/02/2014 07:13 PM, Scott Wood wrote:
> On Fri, Apr 18, 2014 at 12:18:00PM -0500, Lijun Pan wrote:
>> P1023RDS is no longer supported by Freescale while P1023RDB is still supported.
> 
> Please wrap changelogs at no more than 75 columns.
> 
>> Signed-off-by: Lijun Pan <Lijun.Pan@freescale.com>
>>
>> ---
>> arch/powerpc/boot/dts/p1023rds.dts                 | 219 ---------------------
>>  arch/powerpc/configs/mpc85xx_defconfig             |   1 -
>>  arch/powerpc/configs/mpc85xx_smp_defconfig         |   1 -
>>  arch/powerpc/platforms/85xx/Kconfig                |   6 +-
>>  arch/powerpc/platforms/85xx/Makefile               |   2 +-
>>  .../platforms/85xx/{p1023_rds.c => p1023_rdb.c}    |  36 +---
>>  6 files changed, 10 insertions(+), 255 deletions(-)
>>  delete mode 100644 arch/powerpc/boot/dts/p1023rds.dts
>>  rename arch/powerpc/platforms/85xx/{p1023_rds.c => p1023_rdb.c} (75%)
> 
> As discussed internally, I'd like to see more of an explanation for why
> it should be removed upstream -- what sort of maintenance burden it's
> causing, or why this board should be considered of so little interest to
> users that we should remove it regardless of current maintenance burden.

When discussed internally I believe we addressed these points but I
guess not to your satisfaction. I suspect you're not asking for a replay
so I'm trying to get actual numbers of boards sold hoping that would
make the conversation a bit more objective


Cheers,
