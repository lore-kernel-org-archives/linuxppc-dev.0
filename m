Return-Path: <b07421@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 92862DDEFF
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Mar 2007 06:47:55 +1100 (EST)
Date: Wed, 7 Mar 2007 13:47:32 -0600
From: Scott Wood <scottwood@freescale.com>
To: "Mark A. Greer" <mgreer@mvista.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 11/15] zImage wrapper for Ebony
Message-ID: <20070307194732.GB30721@ld0162-tx32.am.freescale.net>
References: <20070305032307.GB31417@localhost.localdomain>
	<20070305032452.EDB2BDDF1D@ozlabs.org>
	<20070305171053.GC32672@mag.az.mvista.com>
	<20070306000905.GC4728@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070306000905.GC4728@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 06, 2007 at 11:09:05AM +1100, David Gibson wrote:
> On Mon, Mar 05, 2007 at 10:10:53AM -0700, Mark A. Greer wrote:
> > I think we more-or-less agreed to go with Scott Wood's 'wrap' method
> > (unless there is a problem with it).
> 
> Oh, we had?
> 
> > http://ozlabs.org/pipermail/linuxppc-dev/2007-February/031337.html
> 
> Um.. I'm pretty uneasy about that, because I'm not at all sure that
> the wrapper script does the right thing w.r.t. where it puts the .dtb
> file, when building with a VPATH.

My patches don't change where the dtb goes as far as I can tell.  If
there's a problem, it can be addressed with an additional patch (or if my
patches do change it, please tell me how).

> Actually, longer term what I think might be a better option is to
> build *all* the dts files into asm (with different symbolic names) and
> fold them into the wrapper library.

I can see potential benefit in allowing multiple dtbs to be included, to
be chosen at runtime (such as from a board ID passed from the bootloader,
or based on detection of how the board is configured (such as detecting
whether an MDS board is plugged into a PCI backplane, or is acting as a
PCI agent, or is standalone)).  But why all of them?

-Scott
