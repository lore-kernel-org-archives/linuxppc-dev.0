Subject: Re: VGA out/External Monitor on ibook 2
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
Cc: Manuj Dhingra <manuj_dhingra@ae.gatech.edu>,
	Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.44.0302101721560.23854-100000@zirkon.biophys.uni-duesseldorf.de>
References: 
	 <Pine.LNX.4.44.0302101721560.23854-100000@zirkon.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1044898053.10697.27.camel@thor>
Mime-Version: 1.0
Date: 10 Feb 2003 18:27:33 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2003-02-10 at 17:24, Michael Schmitz wrote:
>
> > Owen asked: How was it using OFFB? The phase is steady with the OFFB.
> >
> > > Does that ring a bell with anyone
> > > here? Does anyone know which PLL setting the hsync position is derived
> > > from?
> > >
> > > 	Michael
> >
> > Is it possible that the lcd and crt *have to be* on different
> > controllers? From what I understand,  OF and OSX set it up that way but we
>
> Yep, that's entirely possible. Maybe we can't get the proper specs for
> both on one controller.
>
> > don't. As I have no documentation, this is just  a conjecture.
> > Still I would like to do just that. But I am constrained by the lack of
> > documentation. Pointers anybody? Maybe people who desire a dual-head would
> > like to help :)
>
> I'd talk to Michel Dänzer about this. The XFree people might have figured
> something out on other (i386) architectures. XFree developers have access
> to at least some ATI docs.

The XFree86 radeon driver has indeed solved this by using both CRTCs.
The code is there for everyone to look at. ;)


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
