Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2FD691007D7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2011 06:12:11 +1100 (EST)
Subject: Re: [PATCH 1/1] SPI: disable CONFIG_SPI_FSL_ESPI=m build
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1322131298-21511-1-git-send-email-jslaby@suse.cz>
Date: Thu, 24 Nov 2011 13:12:08 -0600
Message-Id: <5C7165B8-7ED5-444B-BF8B-DA049A432E6D@kernel.crashing.org>
References: <1322131298-21511-1-git-send-email-jslaby@suse.cz>
To: Jiri Slaby <jslaby@suse.cz>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 jirislaby@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 24, 2011, at 4:41 AM, Jiri Slaby wrote:

> When spi_fsl_espi is chosen to be built as a module, there is a build
> error because we test only CONFIG_SPI_FSL_ESPI in declaration of
> struct mpc8xxx_spi in drivers/spi/spi_fsl_lib.h. Also some called
> functions are not exported.
>=20
> So we forbid CONFIG_SPI_FSL_ESPI to be tristate here.
>=20
> The error looks like:
> drivers/spi/spi_fsl_espi.c: In function 'fsl_espi_bufs':
> drivers/spi/spi_fsl_espi.c:232: error: 'struct mpc8xxx_spi' has no =
member named 'len'
> ...
>=20
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Kumar Gala <galak@kernel.crashing.org>
> ---
> drivers/spi/Kconfig |    4 ++--
> 1 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Kumar Gala <galak@kernel.crashing.org>

- k=
