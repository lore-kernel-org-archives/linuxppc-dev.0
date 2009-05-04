Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 348FBDDDF6
	for <linuxppc-dev@ozlabs.org>; Tue,  5 May 2009 06:59:51 +1000 (EST)
Date: Mon, 4 May 2009 13:55:04 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 0/9] Some work for spi_mpc83xx driver, spi-mmc support
	for MPC8610HPCD
Message-Id: <20090504135504.a6a6afcf.akpm@linux-foundation.org>
In-Reply-To: <20090430234739.GA27709@oksana.dev.rtsoft.ru>
References: <20090430234739.GA27709@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, dbrownell@users.sourceforge.net,
	linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 1 May 2009 03:47:39 +0400
Anton Vorontsov <avorontsov@ru.mvista.com> wrote:

> Here are few patches that are needed to support spi-mmc slot on
> MPC8610HPCD PowerPC boards:
> 
> [1/9] spi_mpc83xx: Handles other Freescale processors
> [2/9] spi_mpc83xx: Quieten down the "Requested speed is too low" message
> [3/9] spi_mpc83xx: Add small delay after asserting chip-select line
> [4/9] powerpc/86xx: Add MMC SPI support for MPC8610HPCD boards
> 

Some or all of these seem appropriate to 2.6.30 and perhaps even -stable?
