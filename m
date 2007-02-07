Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id C72FBDDE32
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 10:55:43 +1100 (EST)
Date: Tue, 6 Feb 2007 18:03:26 -0600
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] Update udbg_progress() to display the integer
Message-ID: <20070207000326.GA26024@lixom.net>
References: <11707051151024-git-send-email-timur@freescale.com>
	<20070206013051.GA15525@lixom.net> <45C90A6E.3040302@freescale.com>
	<17865.2853.132102.769702@cargo.ozlabs.ibm.com>
	<1170805102.2620.264.camel@localhost.localdomain>
	<0C529499-B766-4D3A-8340-361BB1B461D3@kernel.crashing.org>
	<45C9151E.70201@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45C9151E.70201@freescale.com>
From: olof@lixom.net (Olof Johansson)
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 06, 2007 at 05:54:06PM -0600, Timur Tabi wrote:
> Kumar Gala wrote:
> 
> >I'm with Ben on this.  I'm not aware of any in tree user that just 
> >doesn't print this stuff out to a console port.  The concept is nice, 
> >but does anyone really use it?
> 
> I just ran a quick test on an 8349 board, and it appears that everywhere 
> ppc_md.progress() is called, printk() works, too.
> 
> Is there any platform where ppc_md.progress() does something different than 
> printk()?  Is there any point in the boot process where ppc_md.progress() 
> works but printk() doesn't?

On some IBM machines the progress will also print the status on the hardware
maintenance console's status line for the partition/machine in question.


-Olof
