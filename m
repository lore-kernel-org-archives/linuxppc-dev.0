Subject: Re: IRDA/IRCOMM on a TiBook patch (UPDATED)
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
To: Till Straumann <Till.Straumann@TU-Berlin.de>
Cc: linuxppc-dev@lists.linuxppc.org, linux-irda@pasta.cs.uit.no
In-Reply-To: <3BD061BE.680BEF25@TU-Berlin.de>
References: <3BCC104D.B5770ADE@TU-Berlin.de>
	<1003453347.24371.912.camel@pismo> <3BCFCA2C.CACD571B@TU-Berlin.de>
	<1003500642.4732.451.camel@pismo>  <3BD061BE.680BEF25@TU-Berlin.de>
Content-Type: text/plain; charset=ISO-8859-1
Date: 20 Oct 2001 03:13:00 +0200
Message-Id: <1003540380.12970.674.camel@pismo>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2001-10-19 at 19:24, Till Straumann wrote:
>
> Michel Dänzer wrote:
> >
> > On Fri, 2001-10-19 at 08:37, Till Straumann wrote:
> > >
> > > Michel Dänzer wrote:
> > > >
> > > > Have you managed to do anything 'real' yet? I tried your patch, and it
> > > > does seem to improve things, irdadump seems to show data from my Palm,
> > > > but I haven't succeeded to synchronize yet.
> > >
> > > Sure - I can open a modem connection to my cellphone and issue any AT
> > > command I want. However, I have to take care of all of the three issues
> > > mentioned. (I.e. use patched irattach, use patched kernel and
> > > echo 57600 > /proc/sys/net/irda/max_baud_rate).
> >
> > I have done the latter two and used cat to work around the first. I see
> > something with irdadump but none of the pilot sync tools work. I'm
> > afraid they're broken on PPC yet. :(
>
> Hmm - I still have one of the old PalmPilot devices without irda. What
> exactly do you see with irdadump? (Forgive me the stupid question: you
> have set PILOT_PORT to /dev/ircomm0, right?)

No, of course I hadn't... I still don't, but now /dev/pilot points to
it. I was foolishly thinking it should point to /dev/ttyS1 as well.

So now I just finished synchronizing my Palm from within Linux for the
first time! There goes the last reason to boot into MacOS. :)

Thanks so much, I hope this gets integrated and the macserial driver
propoerly fixed soon.


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
