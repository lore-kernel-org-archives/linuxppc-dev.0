Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 04FF3DDE23
	for <linuxppc-dev@ozlabs.org>; Tue,  5 May 2009 09:36:51 +1000 (EST)
Date: Tue, 5 May 2009 03:36:48 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/9] Some work for spi_mpc83xx driver, spi-mmc support
	for MPC8610HPCD
Message-ID: <20090504233648.GA6973@oksana.dev.rtsoft.ru>
References: <20090430234739.GA27709@oksana.dev.rtsoft.ru>
	<20090504135504.a6a6afcf.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20090504135504.a6a6afcf.akpm@linux-foundation.org>
Cc: linuxppc-dev@ozlabs.org, dbrownell@users.sourceforge.net,
	linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 04, 2009 at 01:55:04PM -0700, Andrew Morton wrote:
> On Fri, 1 May 2009 03:47:39 +0400
> Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> 
> > Here are few patches that are needed to support spi-mmc slot on
> > MPC8610HPCD PowerPC boards:
> > 
> > [1/9] spi_mpc83xx: Handles other Freescale processors
> > [2/9] spi_mpc83xx: Quieten down the "Requested speed is too low" message
> > [3/9] spi_mpc83xx: Add small delay after asserting chip-select line
> > [4/9] powerpc/86xx: Add MMC SPI support for MPC8610HPCD boards
> > 
> 
> Some or all of these seem appropriate to 2.6.30 and perhaps even -stable?

I'd say no, we don't need the fixes for MPC8323E-RDB boards
(currently the only mainline user of that driver), and support
for MPC8610HPCD boards is a new feature, so I think all these
patches can wait for 2.6.31.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
