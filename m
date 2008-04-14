Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id 3B910DE5C0
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 02:20:13 +1000 (EST)
Subject: Re: Signal backtrace function
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: Detlev Zundel <dzu@denx.de>
In-Reply-To: <m2skxoo1ur.fsf@ohwell.denx.de>
References: <1207764980.5826.77.camel@gentoo-jocke.transmode.se>
	<m2skxoo1ur.fsf@ohwell.denx.de>
Content-Type: text/plain
Date: Mon, 14 Apr 2008 18:20:09 +0200
Message-Id: <1208190010.5911.15.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2008-04-14 at 18:09 +0200, Detlev Zundel wrote:
> Hi Jocke,
> 
> > I made my own backtrace function for printing
> > a trace from within a signal handler. Maybe it
> > can be useful for the kernel too? General
> > comments welcome.
> 
> Probably a dumb question, but doesn't backtrace(3) from glibc work
> architecture independent already?   Why do you need to reimplement it?

Nope, it doesn't give you a good backtrace from within a signal handler.
On x86 you can use the normal backtrace function with a minor
workaround, but as ppc doesn't save a FP in leaf functions, that
workaround does not work well. You can read more about it
at http://www.linuxjournal.com/article/6391

 Jocke
