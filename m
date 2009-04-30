Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 3411BDE5E5
	for <linuxppc-dev@ozlabs.org>; Fri,  1 May 2009 09:47:41 +1000 (EST)
Date: Fri, 1 May 2009 03:47:39 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 0/9] Some work for spi_mpc83xx driver, spi-mmc support for
	MPC8610HPCD
Message-ID: <20090430234739.GA27709@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	David Brownell <dbrownell@users.sourceforge.net>,
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

Hi all,

Here are few patches that are needed to support spi-mmc slot on
MPC8610HPCD PowerPC boards:

[1/9] spi_mpc83xx: Handles other Freescale processors
[2/9] spi_mpc83xx: Quieten down the "Requested speed is too low" message
[3/9] spi_mpc83xx: Add small delay after asserting chip-select line
[4/9] powerpc/86xx: Add MMC SPI support for MPC8610HPCD boards

The rest are cleanups, initially Kumar suggested to rename
spi_mpc83xx.c to spi_mpc8xxx.c, but checkpatch told me to fix
some other issues. So the following cleanups were prepared:

[5/9] spi_mpc83xx: Fix checkpatch issues
[6/9] spi_mpc83xx: Split mpc83xx_spi_work() into two routines
[7/9] spi_mpc83xx: Remove dead code
[8/9] spi_mpc83xx: Rename spi_83xx.c to spi_8xxx.c
[9/9] spi_mpc8xxx: s/83xx/8xxx/g

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
