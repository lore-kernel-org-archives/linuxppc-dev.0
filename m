Subject: Re: two aty128 frame buffers?
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Jeffery von Ronne <jronne@ics.uci.edu>
Cc: Kaoru Fukui <k_fukui@highway.ne.jp>,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20020206153744.E3189@reepicheep.ics.uci.edu>
References: <20020204154626.C28199@reepicheep.ics.uci.edu>
	<200202050524.OAA13555@mail.highway.ne.jp>
	<20020204222214.A28746@reepicheep.ics.uci.edu>
	<1012901313.734.210.camel@pismo>
	<20020205151625.D761@reepicheep.ics.uci.edu>
	<1012954108.1885.3328.camel@pismo>
	<20020206153744.E3189@reepicheep.ics.uci.edu>
Content-Type: text/plain; charset=ISO-8859-1
Date: 07 Feb 2002 02:11:11 +0100
Message-Id: <1013044271.22256.9002.camel@pismo>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Don, 2002-02-07 at 00:37, Jeffery von Ronne wrote:
> On Wed, Feb 06, 2002 at 01:08:28AM +0100, Michel Dänzer wrote:
> > > I tried applying your hack to a virgin XF 4.2.0 source tree, and
> > > I get a signal 11 crash.  The last output shows the X server loading
> > > vgahw.
>
> I strated sprinkling the code with R128_TRACE messages, and as near as I can
> tell, the vgaHWGetIOBase is crashing.

Works here with a single chip... can you send me your XF86Config and X
server log privately?


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
