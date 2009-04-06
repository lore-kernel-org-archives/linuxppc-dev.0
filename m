Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3EE75DDE1F
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Apr 2009 00:15:06 +1000 (EST)
Message-Id: <6758B03E-2525-4754-83FA-643CED277CC6@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20090404192802.GA12183@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 1/3] spi_mpc83xx: Handles other Freescale processors
Date: Mon, 6 Apr 2009 09:13:51 -0500
References: <20090404192802.GA12183@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 4, 2009, at 2:28 PM, Anton Vorontsov wrote:

> With this patch we'll able to select spi_mpc83xx driver on the MPC86xx
> platforms. Let the driver depend on FSL_SOC, so we don't have to worry
> about Kconfig anymore.
>
> Also remove the "experimental" dependency, the driver has been tested
> to work on a various hardware, and surely not experimental anymore.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> drivers/spi/Kconfig |   14 ++++++--------
> 1 files changed, 6 insertions(+), 8 deletions(-)

this looks fine, but why don't we go ahead and rename things as well?   
SPI_MPC83xx -> SPI_MPC8xxx, spi_mpc83xx.c -> spi_mpc8xxx.c

- k
