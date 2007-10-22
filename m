Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (unknown [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 9362DDDE3C
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Oct 2007 11:10:55 +1000 (EST)
Date: Sun, 21 Oct 2007 20:17:40 -0500
From: Olof Johansson <olof@lixom.net>
To: scott.wood@freescale.com, linuxppc-dev@ozlabs.org
Subject: Re: ep88xc_defconfig doesn't build
Message-ID: <20071022011740.GA25222@lixom.net>
References: <20071020024355.GA20356@lixom.net>
	<20071022003625.GC17164@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071022003625.GC17164@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 22, 2007 at 10:36:25AM +1000, David Gibson wrote:
> On Fri, Oct 19, 2007 at 09:43:55PM -0500, Olof Johansson wrote:
> > Hi,
> > 
> > Did it ever?! I get this with current mainline when building default target:
> 
> I think you must have an old dtc; I'm pretty sure I removed the check
> for /chosen some time ago.  But then I also thought we added a force
> to the dtc commant line in wrapper ages ago, so now I'm a bit confused.

Hrm, seems like I had an old version. It's a little annoying that it's a
moving target and it's impossible to find out form a built binary which
version it is, besides trying to guess based on file time stamps.

A nice enhancement could be to have a "dtc -v" and have the makefile
verify it before using it.


-Olof
