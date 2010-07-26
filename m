Return-Path: <glikely@secretlab.ca>
Received: from mail-pv0-f170.google.com (mail-pv0-f170.google.com
	[74.125.83.170]) by ozlabs.org (Postfix) with ESMTP id 97EF0B6EDD
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 10:36:21 +1000 (EST)
Received: by pvg16 with SMTP id 16so5053745pvg.15
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Jul 2010 17:36:20 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Sun, 25 Jul 2010 18:36:18 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Mingkai Hu <Mingkai.hu@freescale.com>
Subject: Re: [PATCH 0/6] refactor spi_mpc8xxx.c and add eSPI controller support
Message-ID: <20100726003618.GF25419@angua.secretlab.ca>
References: <1279591705-7574-1-git-send-email-Mingkai.hu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1279591705-7574-1-git-send-email-Mingkai.hu@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 20, 2010 at 10:08:19AM +0800, Mingkai Hu wrote:
> This patchset refactor the file spi_mpc8xxx.c to abstract some common code
> as a lib used by the SPI/eSPI controller driver, move the SPI controller
> driver code to fsl_spi.c, and add the eSPI controller support with fsl_espi.c.
> 
> Tested on P4080DS and MPC8536DS board based on latest Linux tree.
> 
> [PATCH 1/6] spi/mpc8xxx: refactor the common code for SPI/eSPI controller
> [PATCH 2/6] eSPI: add eSPI controller support
> [PATCH 3/6] of/spi: add support to parse the SPI flash's partitions
> [PATCH 4/6] mtd: m25p80: change the read function to read page by page
> [PATCH 5/6] powerpc/of: add eSPI controller dts bindings
> [PATCH 6/6] DTS: add SPI flash(s25fl128p01) support on p4080ds and mpc8536ds board

Hi Mingkai,

Thanks for the patches, I've just sent my review.  Make sure you cc: spi-devel-general@lists.sourceforge.net when you post v2

g.
