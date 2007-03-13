Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 52914DDDFA
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 16:37:25 +1100 (EST)
Date: Mon, 12 Mar 2007 22:38:10 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 02/19] bootwrapper: Set -msoft-float and assembler target
	options.
Message-ID: <20070313053810.GD27618@mag.az.mvista.com>
References: <20070312204140.GB28545@ld0162-tx32.am.freescale.net>
	<17910.4629.587851.80369@cargo.ozlabs.ibm.com>
	<20070313053258.GB27618@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070313053258.GB27618@mag.az.mvista.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 12, 2007 at 10:32:59PM -0700, Mark A. Greer wrote:
> On Tue, Mar 13, 2007 at 01:53:09PM +1100, Paul Mackerras wrote:
> > We
> > should also consider whether the command-line editing is generally
> > useful, or not, and whether the function to do it should be made more
> > generic.
> 
> IMHO, it is very useful if you have fw that doesn't update the dtb for
> you (i.e., OF and u-boot).  Don't know if it makes sense for OF and/or
           ^^^ add a "not"

> u-boot.
