Subject: Re: ibook2r2 & strange freeze.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Brice Figureau <brice@tincell.com>
Cc: "Linuxppc-Dev@Lists.      " "Linuxppc. Org" <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <1051292592.2104.9.camel@gaston>
References: <1051284468.2467.179.camel@localhost.localdomain>
	 <1051292592.2104.9.camel@gaston>
Content-Type: text/plain
Message-Id: <1051293026.10345.13.camel@gaston>
Mime-Version: 1.0
Date: 25 Apr 2003 19:50:26 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2003-04-25 at 19:43, Benjamin Herrenschmidt wrote:
> > By unstable I mean that the computer completely freeze during boot time,
> > around the time rc.sysinit is launched. Unfortunately I'm rather new to
> > linux kernel so I don't know how to provide more information on the
> > crash (maybe should I configure the kernel with xmon ?).
> > In a divide&conquer approach I found that the part of rc.sysinit which
> > 'uploads' the console font to the font layer was triggering the crash.
>
> Can you try 2 things and let me know if one of them helps ?
>
>  - Compile without CPUFREQ support
>  - Use video=radeon:noaccel on the command line to disable acceleration
>    on console

Also, it would be helpful if you could go backward the kernel
versions to point when the problem started. You could try
2.4.20-ben1. If it doesn't have the problem, then -ben5, etc...
(do a dichotomy).

If -ben1 is affected, then we'll need to do something different

(Patches are available on kernel.org)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
