Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0241.outbound.protection.outlook.com [207.46.163.241])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6069A140091
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Mar 2014 12:29:40 +1100 (EST)
Message-ID: <1395710972.12479.418.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc/85xx: Remove defconfigs
From: Scott Wood <scottwood@freescale.com>
To: Michael Neuling <mikey@neuling.org>
Date: Mon, 24 Mar 2014 20:29:32 -0500
In-Reply-To: <12121.1395710142@ale.ozlabs.ibm.com>
References: <12121.1395710142@ale.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>,
 Linux PPC dev <linuxppc-dev@ozlabs.org>, Lijun Pan <Lijun.Pan@freescale.com>,
 Mingkai Hu <Mingkai.Hu@freescale.com>,
 Prabhakar Kushwaha <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-03-25 at 12:15 +1100, Michael Neuling wrote:
> These are always breaking and I feel like I'm the only one fixing them
> and 

Always?  Please elaborate.

> I don't even have one of these boards so let's just remove them.

What does you having one of these boards have to do with anything?

> They are also broken right now in linux-next when compiling modules.

A fix for that breakage is in i2c.git i2c/for-current (commit
5f12c5eca6e6b7aeb4b2028d579f614b4fe7a81f).  I sent the patch to fix it
(I guess you're not "the only one fixing them") the day I found out
about the breakage.  The breakage was introduced by commits from the i2c
tree, including one late in the rc cycle that enables a driver that
hadn't been enabled in a while (let's not do that again please).

> Signed-off-by: Michael Neuling <mikey@neuling.org>
> 
> diff --git a/arch/powerpc/configs/mpc85xx_defconfig b/arch/powerpc/configs/mpc85xx_defconfig
> deleted file mode 100644
> index 19f0fbe..0000000
> --- a/arch/powerpc/configs/mpc85xx_defconfig
> +++ /dev/null
> @@ -1,272 +0,0 @@

NACK

I'm curious why you only removed this one defconfig when
mpc85xx_smp_defconfig had the same problem...

-Scott
