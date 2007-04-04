Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 325FBDDE30
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 02:00:05 +1000 (EST)
Date: Wed, 4 Apr 2007 09:01:26 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: "Mark A. Greer" <mgreer@mvista.com>, Scott Wood <scottwood@freescale.com>,
	linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 6/6] bootwrapper: cuboot for 83xx
Message-ID: <20070404160126.GB21314@mag.az.mvista.com>
References: <20070322194627.GA31926@ld0162-tx32.am.freescale.net>
	<20070322194930.GF31965@ld0162-tx32.am.freescale.net>
	<20070323055442.GB27940@localhost.localdomain>
	<20070323153056.GD6060@ld0162-tx32.am.freescale.net>
	<20070323233712.GC4459@localhost.localdomain>
	<20070404020629.GA2453@mag.az.mvista.com>
	<20070404063834.GA26616@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070404063834.GA26616@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 04, 2007 at 04:38:34PM +1000, David Gibson wrote:
> On Tue, Apr 03, 2007 at 07:06:29PM -0700, Mark A. Greer wrote:
> > On Sat, Mar 24, 2007 at 10:37:12AM +1100, David Gibson wrote:
> > > On Fri, Mar 23, 2007 at 10:30:56AM -0500, Scott Wood wrote:

> > > Actually, to be clearer here: this reason actually degenerates to the
> > > first; I want the "ft_open" step to go after console_open so we can
> > > get error messages from it.
> > 
> > The problem is,  the console device is specified in the dt so you have
> > to ft_open before you console_open.
> 
> Sorry, I should clarify.  In the context of libfdt, I was thinking
> *read* access to the fdt can happen at any point - right from
> platform_init().  ft_open() would mark the point at which write access
> to the tree can begin.

Ah, okay.
