Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AD4FFDDDB6
	for <linuxppc-dev@ozlabs.org>; Fri,  1 May 2009 18:50:16 +1000 (EST)
Subject: Re: [PATCH 1/2] Add support for Designware SATA controller driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jeff@garzik.org>
In-Reply-To: <49FAA434.9040106@garzik.org>
References: <1241042419-19774-1-git-send-email-fkan@amcc.com>
	<49FAA434.9040106@garzik.org>
Content-Type: text/plain
Date: Fri, 01 May 2009 18:49:08 +1000
Message-Id: <1241167748.1781.3.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Feng Kan <fkan@amcc.com>,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2009-05-01 at 03:26 -0400, Jeff Garzik wrote:
> Feng Kan wrote:
> > Signed-off-by: Feng Kan <fkan@amcc.com>
> > ---
> >  drivers/ata/Kconfig    |   76 +-
> >  drivers/ata/Makefile   |    1 +
> >  drivers/ata/sata_dwc.c | 2047 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 2091 insertions(+), 33 deletions(-)
> >  create mode 100644 drivers/ata/sata_dwc.c
> 
> I don't see a patch 2/2 ?

Patch 2/2 is just adding the device-tree bits to the platform for
this driver to match against, so it's no big deal. However, Feng,
we already mentioned that you do a lot of unrelated changes to the
Kconfig file that shouldn't be part of this patch, just add the
entry for this chip, don't move stuff around in Kconfig, unless I
missed a good reason why this is done that way.

Cheers,
Ben.
