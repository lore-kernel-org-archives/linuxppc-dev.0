Subject: Re: PREEMPT on PPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: Michel =?ISO-8859-1?Q?D=E4nzer?= <daenzer@debian.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
In-Reply-To: <Pine.LNX.4.44.0403291329300.4088-100000@opal.biophys.uni-duesseldorf.de>
References: 
	 <Pine.LNX.4.44.0403291329300.4088-100000@opal.biophys.uni-duesseldorf.de>
Content-Type: text/plain
Message-Id: <1080561670.1210.23.camel@gaston>
Mime-Version: 1.0
Date: Mon, 29 Mar 2004 22:01:11 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2004-03-29 at 21:29, Michael Schmitz wrote:
> > > What else are you using ? I suspect something like MOL may have troubles
> > > with preempt for example...
> >
> > Not using that regularly. Not sure what's special about my setup, XFS
> > maybe?
> >
> > What about this:
> >
> > -CONFIG_TASK_SIZE=0xc0000000
> > +CONFIG_TASK_SIZE=0x80000000
>
> Nope, that's what my kernel is built with as well.

BTW. I pushed more preempt fixes upsteam (see lkml if not in
mainstream yet).

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
