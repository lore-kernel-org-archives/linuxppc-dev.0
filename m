Subject: Re: new ATI sleep code freezes
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: mutex@kerneli.org
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20030607192713.GN1982@heliosphan>
References: <E19O25a-0000Ej-00@piglet.grunz.lu>
	 <20030607192713.GN1982@heliosphan>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1055016895.17021.74.camel@thor.holligenstrasse29.lan>
Mime-Version: 1.0
Date: 07 Jun 2003 22:14:55 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 2003-06-07 at 21:28, mutex@kerneli.org wrote:

> > >> are those normal permissions ?  Also, I'm running an enlightenment
> > >> battery applet which afaik uses apm layer to report battery level.
> > >> So something has to be working. Dave
> > >
> > > I don't know wtf with devfs & perms, but the problem is here, once you
> > > fix that, it should work much better ;)
>
> well(in response to ben) I have a hard time believing that once I fix
> permissions it will eliminate a crash that happens 1/20 sleeps. Just
> doesn't seem like something a permissions problem would cause.

The permissions don't cause the crash directly, it's the fact that the X
server has no way of dealing with the sleep without using /dev/apm_bios.


--
Earthling Michel Dänzer   \  Debian (powerpc), XFree86 and DRI developer
Software libre enthusiast  \     http://svcs.affero.net/rm.php?r=daenzer


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
