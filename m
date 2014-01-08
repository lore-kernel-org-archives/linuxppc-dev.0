Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0153.outbound.protection.outlook.com [207.46.163.153])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5FD262C00C4
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Jan 2014 12:19:26 +1100 (EST)
Date: Tue, 7 Jan 2014 19:04:21 -0600
From: Scott Wood <scottwood@freescale.com>
To: Lijun Pan <LIJUN.PAN@FREESCALE.COM>
Subject: Re: [v4] powerpc/85xx: Merge 85xx/p1023_defconfig into
 mpc85xx_smp_defconfig and mpc85xx_defconfig
Message-ID: <20140108010420.GA22357@home.buserror.net>
References: <1384558100-32759-1-git-send-email-Lijun.Pan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1384558100-32759-1-git-send-email-Lijun.Pan@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 15, 2013 at 05:28:20PM -0600, Lijun Pan wrote:
> mpc85xx_smp_defconfig and mpc85xx_defconfig already have CONFIG_P1023RDS=y.
> Merge CONFIG_P1023RDB=y and other relevant configurations into mpc85xx_smp_defconfig and mpc85_defconfig.
> 
> Signed-off-by: Lijun Pan <Lijun.Pan@freescale.com>

I'll fix it when applying, but please keep commit messages wrapped to
around 70 characters, and keep subject lines even shorter.

-Scott
