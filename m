Return-Path: <rsc@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 06874DDDFB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Sep 2007 16:28:31 +1000 (EST)
Date: Wed, 12 Sep 2007 08:28:19 +0200
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Jon Smirl <jonsmirl@gmail.com>
Message-ID: <20070912062819.GI23573@pengutronix.de>
References: <46E57A9D.2020506@asist.si>
	<fa686aa40709101120u1310845et866b8fa6df7c5154@mail.gmail.com>
	<9e4733910709101622u6978baa6n8618975f75ae1315@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <9e4733910709101622u6978baa6n8618975f75ae1315@mail.gmail.com>
Subject: Re: Which 2.6 kernel for MPC5200
Cc: Babarovic Ivica <ivica.babarovic@asist.si>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Jon,

On Mon, Sep 10, 2007 at 07:22:39PM -0400, Jon Smirl wrote:
> > Then you need to apply the bestcomm patches. You can get them here:
> >
> > http://www.246tnt.com/mpc52xx/dev_full/
>
> I just finished rebasing the Efika version of those patches to current mainline.
>
> I'm working on merging support for my Phytec pcm030 into them.

We have the OSELAS.BSP patch stack for the PCM030 working ontop of
Linus' git. It still uses an older version of the Bestcom patches, so if
you do some work in that area, please keep me informed about your
progress.

Robert
-- 
Pengutronix - Linux Solutions for Science and Industry
Entwicklungszentrum Nord     http://www.pengutronix.de
