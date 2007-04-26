Return-Path: <mgreer@mvista.com>
Date: Wed, 25 Apr 2007 18:15:52 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 0/13] powerpc: Add support for Marvell/mv64x60 and
	prpmc2800
Message-ID: <20070426011552.GS4046@mag.az.mvista.com>
References: <20070425234630.GA4046@mag.az.mvista.com>
	<20070426004514.GC2193@localhost.localdomain>
	<20070426005853.GQ4046@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070426005853.GQ4046@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 25, 2007 at 05:58:53PM -0700, Mark A. Greer wrote:

> Well, its not really the ctlr init.  That is done in the kernel
> driver(s).  What's being set up are the windows that allow the ctlrs to
> access system memory.  This should really be done the the firmware but
                                                    ^^^ "by"

> isn't so I think the bootwrapper is the proper place to do it.
> 
> AFA PCI, its setting up the window from cpu phys->PCI MEM & I/O,
> and PCI MEM->system mem.  I think its better to not have that in the
> kernel--bloats the kernel and mv64x60 with better fw (which is most of
                                       ^ "platforms"

Mark
