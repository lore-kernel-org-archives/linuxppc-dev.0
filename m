Message-ID: <39883B9B.3D9E0C83@embeddededge.com>
Date: Wed, 02 Aug 2000 11:17:47 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: CONFIG_PPC != Mac
References: <Pine.LNX.4.10.10007311828010.442-100000@cassiopeia.home>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:
>
> On Mon, 31 Jul 2000, Franz Sirl wrote:
> > BTW, how about CONFIG_PPC_DESKTOP and CONFIG_PPC_EMBEDDED in addition to
> > CONFIG_PPC?
>
> And what makes the difference between a `desktop' and an `embedded' PPC here?


I hope we don't do this, as I don't think that is a very good
distinction either.  I prefer some of the other suggestions, where
we simply have mix-n-match configuration options.  Select a board
and processor type and go from there.

I have had the opportunity lately to use some of the other Linux
processor architecture configurations.  The Linux PowerPC configuration
really isn't too bad, and I would prefer just a small evolution.  If
you want to see some bad configuration and hard to use environments,
go visit some of the other emerging architectures.......

I think even some of the "source restructuring" that has been discussed
could also be mitigated with a more logical set of configuration options.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
