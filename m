Return-Path: <dgibson@ozlabs.org>
Date: Wed, 19 Nov 2008 11:42:20 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Timur Tabi <timur@freescale.com>
Subject: Re: powerpc: udbg based backend for hvc_console
Message-ID: <20081119004220.GE29577@yookeroo.seuss>
References: <20081024035434.GF4267@yookeroo.seuss>
	<ed82fe3e0811171204y4e8de21dy18f5b332b7f05f1f@mail.gmail.com>
	<20081118004005.GC26336@yookeroo.seuss>
	<ed82fe3e0811172042r1d4887f8n76682e0b21555372@mail.gmail.com>
	<20081118051408.GM26336@yookeroo.seuss>
	<4922D9E9.5020204@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4922D9E9.5020204@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 18, 2008 at 09:06:17AM -0600, Timur Tabi wrote:
> David Gibson wrote:
> 
> > Given the variety of strange I/O configurations in prototype and
> > embedded platforms, I can't imagine this was a unique situation.  So
> > I've pushed my patch out, so anyone else in a similar situation can
> > immediately turn their little udbg methods for whatever strange I/O
> > they have into a fully-functional console.  Maybe it's not something
> > you'd want to go to release with, but it certainly simplifies life
> > during bringup.
> 
> Ok, I understand now.  However, I would like to see two changes:
> 
> 1) Re-arrange the Makefile as I pointed out in another post.

Um.. yeah.. I'm a bit baffled by this.. all the existing backends
are listed after hvc_console, I just added hvc_udbg to the end.  I
didn't really understand the rationale in that commit, but then I
haven't had time to look at it very much yet.

> 2) Update the Kconfig help file to be very clear that this feature
> is only meaningful if the platform has a udbg back-end but no other
> console or TTY driver.

Alrighty...

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
