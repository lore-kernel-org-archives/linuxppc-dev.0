Return-Path: <jonsmirl@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.230])
	by ozlabs.org (Postfix) with ESMTP id 3BED3DE7FA
	for <linuxppc-dev@ozlabs.org>; Sat, 17 May 2008 06:28:59 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so332286rvb.9
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 13:27:33 -0700 (PDT)
Message-ID: <9e4733910805161327u4c42fd1dg5b09319d89db447c@mail.gmail.com>
Date: Fri, 16 May 2008 16:27:33 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH 0/4] Describe SPI devices in the OF device tree and
	add mpc5200-spi driver
In-Reply-To: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
Cc: fabrizio.garetto@gmail.com, linuxppc-dev@ozlabs.org,
	dbrownell@users.sourceforge.net, linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 5/16/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> This series is a set of changes to allow the slaves on an SPI bus to be
>  described in the OF device tree (useful in arch/powerpc) and adds a driver
>  that uses it (the Freescale MPC5200 SoC's SPI device).

Right now we have SPI hooked up to PSC3. Hardware engineer is gone but
I'll see if I can get him to alter things to use the SPI controller. I
have an old mail from him where he thinks the Phytec board is missing
a signal needed to use the SPI controller.

Is the current SPI driver working on PSC3? I have a MMC card wired up
to it but I've never tried using it.

I have the MPC5200 PSC SPI driver enabled and "MMC/SD over SPI"
enabled in my kernel. The MMC bus gets created but there aren't any
devices on it. Do we need something in the SPI driver so that the MMC
layer can find it?

Are you going to keeps this as two drivers or merge them? If it is two
drivers there should be one entry in Kconfig and two sub choices for
the types of drivers.

>  Please review and comment.  David, I've included in this series my earlier
>  patch to change modalias from a pointer to a string as one of the later
>  patches depends on it.
>
>  Cheers,
>  g.
>
>
>  --
>  Grant Likely, B.Sc. P.Eng.
>  Secret Lab Technologies Ltd.
>


-- 
Jon Smirl
jonsmirl@gmail.com
