Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 4C323DDFB7
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 04:24:12 +1100 (EST)
Date: Sun, 11 Jan 2009 20:24:10 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] powerpc/83xx: Move mcu_mpc8349emitx driver out of
	drivers/i2c/chips/
Message-ID: <20090111172410.GA7106@oksana.dev.rtsoft.ru>
References: <20090111165136.GA26096@oksana.dev.rtsoft.ru>
	<20090111181055.31611474@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20090111181055.31611474@hyperion.delvare>
Cc: linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jan 11, 2009 at 06:10:55PM +0100, Jean Delvare wrote:
> Hi Anton,
> 
> On Sun, 11 Jan 2009 19:51:36 +0300, Anton Vorontsov wrote:
> > This patch is used to help Jean Delvare to get rid of drivers/i2c/chips/
> > directory. The new location suggested by Kumar Gala: as the driver is
> > 83xx specific it's placed into arch/powerpc/platforms/83xx/.
> > 
> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> 
> Thanks for doing this. Do you expect me to take this patch in my i2c
> tree, or will it go in some powerpc tree?

As the patch adds some code to arch/powerpc/, I believe Kumar would
want to merge it into his powerpc tree. In that case I think we'll
need your Acked-by line for formality.

But let's wait for Kumar's decision.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
