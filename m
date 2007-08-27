Return-Path: <rbrito@ime.usp.br>
Received: from hope.ime.usp.br (hope.ime.usp.br [143.107.45.8])
	by ozlabs.org (Postfix) with SMTP id 2112CDE14C
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Aug 2007 16:59:32 +1000 (EST)
Date: Mon, 27 Aug 2007 03:52:46 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: Re: Sleep problems with kernels >= 2.6.21 on powerpc
Message-ID: <20070827065246.GA21220@ime.usp.br>
References: <6540c930708251937o2a9a23efv72a0f2b8947067bd@mail.gmail.com>
	<6bffcb0e0708261621q25316becqce7b3ae2176f45a8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <6bffcb0e0708261621q25316becqce7b3ae2176f45a8@mail.gmail.com>
Cc: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@gmail.com>,
	linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>,
	linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org,
	Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, Thanks, Michal.

I didn't know who to include as the wizards of the matter.

On Aug 27 2007, Michal Piotrowski wrote:
> [Adding STR wizards to CC]
> 
> On 26/08/07, Rogério Brito <rbrito@gmail.com> wrote:
> > If I, on the other hand, use Debian's kernel 2.6.22 or compile my own
> > kernel with just the necessary parts for my work (version 2.6.23-rc3
> > taken from kernel.org), then I can't make the machine sleep: when I
> > press the button, it acts like if I had, in sequence, pressed anything
> > to wake it up (say, like pressing shift).

Things are getting now a little bit fishy.

Before, I was using gnome and all the little daemons that come with it
(even though I just prefer a plain window manager), but, as I mentioned
before, it didn't matter if I pressed the power button on X or on a
console.

I had the gnomee power-thingy sounding like an alarm (an ambulance!) on me
when I pressed the power button with Debian kernels 2.6.22, for instance. I
compiled my own (this time, from kernel.org) 2.6.23-rc3, with many modules
and subsystems removed (e.g., bluetooth, as this laptop doesn't have it)
and I got the exact same behavior.

If I booted, OTOH, with Debian's kernel 2.6.18, things were fine and the
machine would go to sleep without any problems.

I am now suspecting of some module that prevented the machine from going to
sleep and I now using just a fluxbox as my window manager. This time, even
with a 2.6.23-rc3 kernel (again, from kernel.org) the machine went to sleep
normally.

I did 13 compiles with git bisect and some of them were unsucessfuly
compiled, which I am afraid that may miss the real cause if I tag them as
being "bad" (which I did). (This was with just a bare minimum installation
of Debian).


The course of action that I am taking right now is to pull GNOME and see if
my current 23-rc3 kernel has any problems and see which modules are loaded.

If things progress well, I will incrementally include features on the
kernel that I need (I left out, for instance, the Firewire subsystem, so
that compilation wouldn't take more than an hour here, despite the fact
that I do need Firewire support on the kernel) and see the point where
things are not normal.

Again, I am willing to test anything that is useful to getting PowerPC
working as well as it should with the final 2.6.23 release.

Please, don't hesitate to ask for any further information.


Regards, Rogério Brito.

-- 
Rogério Brito : rbrito@{mackenzie,ime.usp}.br : GPG key 1024D/7C2CAEB8
http://www.ime.usp.br/~rbrito : http://meusite.mackenzie.com.br/rbrito
Projects: algorithms.berlios.de : lame.sf.net : vrms.alioth.debian.org
