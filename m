Date: Wed, 6 Sep 2000 18:46:31 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Rolf Liu <rolfl@sc23.sc.mcel.mot.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: question about 'r2' !!!
In-Reply-To: <Pine.LNX.4.10.10009061259440.453-100000@cassiopeia.home>
Message-ID: <Pine.LNX.4.10.10009061819050.23404-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > I am currently engaged in compiling Linux-ppc source tree using a CC other
> > than GCC.
>
> May I ask you _why_ you want to do that?!?

The mind fairly boggles. Anyway, once upon a time, current wasn't kept in
a register but in memory. And if r2 won't do, just pick another register
and tell the compiler not to touch it. Hope your compiler of choice has
such a thing as --fixed-r2 ...

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
