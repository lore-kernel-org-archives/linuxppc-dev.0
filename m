Subject: Re: two aty128 frame buffers?
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Jeffery von Ronne <jronne@ics.uci.edu>
Cc: Kaoru Fukui <k_fukui@highway.ne.jp>,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20020205151625.D761@reepicheep.ics.uci.edu>
References: <20020204154626.C28199@reepicheep.ics.uci.edu>
	<200202050524.OAA13555@mail.highway.ne.jp>
	<20020204222214.A28746@reepicheep.ics.uci.edu>
	<1012901313.734.210.camel@pismo>
	<20020205151625.D761@reepicheep.ics.uci.edu>
Content-Type: text/plain; charset=ISO-8859-1
Date: 06 Feb 2002 01:08:28 +0100
Message-Id: <1012954108.1885.3328.camel@pismo>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mit, 2002-02-06 at 00:16, Jeffery von Ronne wrote:
> On Tue, Feb 05, 2002 at 10:28:33AM +0100, Michel Dänzer wrote:
> > > Unfortunately, that was not my real problem.  I guess I forgot to mention
> > > that it crashes with a "signal 11" after the error message; now it crashes
> > > with a signal 11 and no error message.
> >
> > You need a hack like the attached one.
>
> I tried applying your hack to a virgin XF 4.2.0 source tree, and
> I get a signal 11 crash.  The last output shows the X server loading
> vgahw.

Hmm, isn't info->VBIOS == NULL? If not, enforce the other route in that
if construct. :)


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
