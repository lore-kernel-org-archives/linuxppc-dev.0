Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: self-modifying code in 2.6 kernel for ppc writes into readonly
	section
In-reply-to: <48A9F423.2070602@freescale.com> 
References: <78ef7ce10808180901v6c694e63xefc37dd97485533@mail.gmail.com>
	<1586.1219087193@neuling.org>
	<78ef7ce10808181257u637c5597xaa992b9e4e7a0925@mail.gmail.com>
	<11009.1219092703@neuling.org>
	<78ef7ce10808181427m507434f4we84d507b090a707b@mail.gmail.com>
	<18942.1219097397@neuling.org> <48A9F423.2070602@freescale.com>
Date: Mon, 18 Aug 2008 17:18:48 -0500
Message-ID: <19896.1219097928@neuling.org>
Cc: linuxppc-dev@ozlabs.org, Mihaela Grigore <grigore.mihaela@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <48A9F423.2070602@freescale.com> you wrote:
> Michael Neuling wrote:
> >> It seems like no one else is interested in the subject, so i will talk
> >> directly to you.
> >>
> >> If you say that the cpu also seg faults, it means that the problem is
> >> in the code of the linux kernel... :)
> > 
> > Sorry, I was only joking.  The hardware does _not_ segfault.  There is
> > no equivalent to segfault in real hardware.
> 
> Well, there are machine checks and checkstops... :-)

Shhhh! :-)

Mikey
