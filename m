Date: Wed, 12 Jul 2000 15:43:32 +0200 (MET DST)
From: Derek Homeier <supas100@astrophysik.uni-kiel.de>
To: Iain Sandoe <iain@sandoe.co.uk>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: general module gottcha...
In-Reply-To: <200007121306.OAA00655@hyperion.valhalla.net>
Message-ID: <Pine.SOL.3.95.1000712153838.21439J-100000@juliet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 12 Jul 2000, Iain Sandoe wrote:

>
> Wed, Jul 12, 2000, Derek Homeier wrote:

> > Ay, that may be the rub! I think I've still seen 'dmasound.o' when I did
> > a lsmod. I did not change conf.modules, that's for sure.
> > I have no idea, though, where I might have got the old dmasound.o from,
> > because I made a 'mrproper' before the last compiles.
>
> This is because (as things stand) modules_install does *not* remove un-built
> modules - just overwrites rebuilt ones with the new versions...
>
> This is probably the only sensible behaviour (gurus?)...
>
> I am (usually) paranoid and do a:
>  rm -rf /lib/modules/kernel-version-i'm-working-on
>
> before doing modules_install :-)
>
I was quite aware of that, and recreated the modules dir several times,
also because I built three versions in a series and moved the corresponding
modules to a different place. I may have missed something there, though.

> > I can imagine that
> > would have messed up everything a bit, though I'm wondering how the
> > module got loaded with the wrong kernel version at all...
>
> Hmmm.. it's probably a little too tolerant - I have module versioning
> switched on in all my compiles and that is quite successful at whining when
> you've forgotten to delete/update something.
>
Good idea! Where do you enable that?

Cheers,
							Derek


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
