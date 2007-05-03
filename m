Return-Path: <mgreer@mvista.com>
Date: Thu, 3 May 2007 12:00:27 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 3/13] powerpc: Add bootwrapper support for Marvell/mv64x60
	hostbridge
Message-ID: <20070503190027.GB5600@mag.az.mvista.com>
References: <20070425234630.GA4046@mag.az.mvista.com>
	<20070425235619.GE4046@mag.az.mvista.com>
	<17969.37331.228482.225919@cargo.ozlabs.ibm.com>
	<20070427220245.GC14490@mag.az.mvista.com>
	<17977.29234.367271.820951@cargo.ozlabs.ibm.com>
	<20070503184402.GA5600@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070503184402.GA5600@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 03, 2007 at 11:44:02AM -0700, Mark A. Greer wrote:
> On Thu, May 03, 2007 at 03:25:06PM +1000, Paul Mackerras wrote:
> > Mark A. Greer writes:
> > Another question - is this setup something that will need to be done
> > differently for different boards using the mv64x60, or is the same
> > setup needed for all applications of the mv64x60?
> 
> I expect that the setup will be done the same for all of the boards
> that need it.  Not all of the boards will need it, though.  It depends
> on their firmware.  The config code is filling the gap between what the
> firmware should have done and what the kernel drivers require (i.e.,

> allowing the ctlrs to access system memory and pci mem/io space).

I'll clarify the last line: "allowing ctlrs on the bridge to access
system memory, allowing the cpu to access pci mem/io space, and allowing
pci devices to access system memory via pci mem reference."

Mark
