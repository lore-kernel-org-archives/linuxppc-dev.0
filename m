Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by bilbo.ozlabs.org (Postfix) with ESMTP id F17DBB70B3
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Sep 2009 10:07:01 +1000 (EST)
Date: Tue, 1 Sep 2009 03:47:13 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Louise.Yeung@Sun.COM
Subject: Re: ECC & Magic bitmask errors with JFFS2 file system on 6.23
	kernel for	powerpc
Message-ID: <20090831234713.GA6767@oksana.dev.rtsoft.ru>
References: <OF4DA6695F.B8912DE2-ON652575F5.004F0DE0-652575F5.00519736@lntemsys.com>
	<4A9C34EE.4040606@Sun.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4A9C34EE.4040606@Sun.COM>
Cc: louise <louise@Sun.COM>, Ravinder Kumar <Ravinder.Kumar@Sun.COM>,
	linuxppc-dev@lists.ozlabs.org, Rupesh Kumar <Rupesh.Kumar@Lntemsys.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 31, 2009 at 01:39:10PM -0700, Louise.Yeung@Sun.COM wrote:
> *Hi Rupesh,
> 
> We are using a Freescale processor similar to yours with NAND flash
> supporting 2KB page size .

What kernel version and NAND driver you use? I don't think that old
BSP kernels include fsl_elbc_nand driver, which is a much improved
version of the fsl_fcm driver.

So you might want to swith to a newer kernel or back-port the
fsl_elbc_nand driver[1] and a few fixes to your kernel.

[1] http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=history;f=drivers/mtd/nand/fsl_elbc_nand.c

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
