Return-Path: <dgibson@ozlabs.org>
Date: Mon, 25 Aug 2008 19:36:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: boot cuImage on an old u-boot
Message-ID: <20080825093617.GA1619@yookeroo.seuss>
References: <20080820150958.GA23294@Chamillionaire.breakpoint.cc>
	<20080821161505.GA15669@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080821161505.GA15669@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org,
	Sebastian Siewior <linuxppc-embedded@ml.breakpoint.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 21, 2008 at 11:15:05AM -0500, Scott Wood wrote:
> On Wed, Aug 20, 2008 at 05:09:58PM +0200, Sebastian Siewior wrote:
> > I have here a mpc8540ads board and a u-boot 1.0.0. I've build the
> > defconfig for the board and I tried to boot the genarated
> > cuImage.mpc8540ads image. After the bootm command I see just
> > 
> > |8540> bootm 1000000
> > |## Booting image at 01000000 ...
> > |   Image Name:   Linux-2.6.26
> > |   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
> > |   Data Size:    1232711 Bytes =  1.2 MB
> > |   Load Address: 00400000
> > |   Entry Point:  004005ac
> > |   Verifying Checksum ... OK
> > |   Uncompressing Kernel Image ... OK
> > |
> > 
> > I don't see the device tree fixups printfs, so crash happend quite
> > early. Anyone an idea what I could have done wrong?
> 
> Make sure the device tree contains /chosen/linux,stdout-path.

No paths to properties, remember!

Make sure the device tree contains a linux,stdout-path property in
/chosen.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
