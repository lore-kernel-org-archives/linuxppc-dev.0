Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C766FB7B74
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2009 00:53:09 +1100 (EST)
Subject: Re: [PATCH 8/8] spi_mpc8xxx: Add support for QE DMA mode and
	CPM1/CPM2 chips
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20091012164927.GH4578@oksana.dev.rtsoft.ru>
Date: Thu, 5 Nov 2009 07:47:56 -0600
Message-Id: <D0B2174D-6EED-4D57-A011-FAFEF64AB794@kernel.crashing.org>
References: <20091012164841.GA32214@oksana.dev.rtsoft.ru>
	<20091012164927.GH4578@oksana.dev.rtsoft.ru>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	spi-devel-general@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 12, 2009, at 11:49 AM, Anton Vorontsov wrote:

> This patch adds QE buffer descriptors mode support for the
> spi_mpc8xxx driver, and as a side effect we now support CPM1
> and CPM2 SPI controllers.
>
> That means that today we support almost all MPC SPI controllers:
>
> - MPC834x-style controllers (support PIO mode only);
> - CPM1 and CPM2 controllers (support DMA mode only);
> - QE SPI controllers in CPU mode (PIO mode with shift quirks);
> - QE SPI controllers in buffer descriptors (DMA) mode;
>
> The only controller we don't currently support is a newer eSPI
> (with a dedicated chip selects and a bit different registers map).
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> Acked-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
> drivers/spi/Kconfig       |    3 -
> drivers/spi/spi_mpc8xxx.c |  540 ++++++++++++++++++++++++++++++++++++ 
> +++++----
> 2 files changed, 500 insertions(+), 43 deletions(-)

applied to next

- k
