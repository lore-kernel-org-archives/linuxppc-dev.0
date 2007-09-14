Return-Path: <dgibson@ozlabs.org>
Date: Fri, 14 Sep 2007 11:22:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Olof Johansson <olof@lixom.net>
Subject: Re: oftree and external connected devices
Message-ID: <20070914012249.GB481@localhost.localdomain>
References: <200709131326.27325.jbe@pengutronix.de>
	<20070913132913.GA9031@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070913132913.GA9031@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 13, 2007 at 08:29:13AM -0500, Olof Johansson wrote:
> On Thu, Sep 13, 2007 at 01:26:26PM +0200, Juergen Beisert wrote:
> > Hi,
> > 
> > I'm using an MPC5200B based system with various external connected devices to 
> > its LocalPlusBus. On other architectures I would register them as platform 
> > devices (no chance to autodetect these devices). But on PowerPC architecture?
> 
> If it's a special case of something that it's unlikely that you'll reuse
> the driver for, I'd say go ahead with a platform driver. There's nothing in the
> PPC kernel that stops it from working.
> 
> We're just trying to avoid it for common devices that platforms might share,
> and instead of describing hardware in the platform devices setup, describe it
> in the device tree instead.
> 
> So it depends on how much work you want to invest in it, and if you're
> planning on ever submitting the driver upstream. If you are, going
> with a simple device tree definiton would be best (the kernel side,
> to move a platform driver to instead be an of_platform driver is easy,
> and can be done afterwards).
> 
> > Is the oftree description also intended to describe these kind of external 
> > devices, or only SoC's internal devices? If its also intended for external 
> > devices, how to do so? Are there any examples? I didn't find anything useful 
> > yet.
> 
> It can be used to describe on-board or off-board devices alike.

And should be used to describe any devices that can't otherwise be
probed, whether they're on-board or not.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
