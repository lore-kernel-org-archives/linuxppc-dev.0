Date: Tue, 5 Feb 2002 15:16:25 -0800
From: Jeffery von Ronne <jronne@ics.uci.edu>
To: =?iso-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>
Cc: Kaoru Fukui <k_fukui@highway.ne.jp>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: two aty128 frame buffers?
Message-ID: <20020205151625.D761@reepicheep.ics.uci.edu>
References: <20020204154626.C28199@reepicheep.ics.uci.edu> <200202050524.OAA13555@mail.highway.ne.jp> <20020204222214.A28746@reepicheep.ics.uci.edu> <1012901313.734.210.camel@pismo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1012901313.734.210.camel@pismo>; from michel@daenzer.net on Tue, Feb 05, 2002 at 10:28:33AM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Feb 05, 2002 at 10:28:33AM +0100, Michel Dänzer wrote:
> > Unfortunately, that was not my real problem.  I guess I forgot to mention
> > that it crashes with a "signal 11" after the error message; now it crashes
> > with a signal 11 and no error message.
>
> You need a hack like the attached one.

I tried applying your hack to a virgin XF 4.2.0 source tree, and
I get a signal 11 crash.  The last output shows the X server loading
vgahw.  Are there any other patches I should be applying?

My server log and configuration are at
<URL: http://www.ics.uci.edu/~jronne/2-XFree86.0.log> and
<URL: http://www.ics.uci.edu/~jronne/2-XF86Config-4>.

Thanks,
--
Jeffery von Ronne <jronne@ics.uci.edu>
Graduate Student
Information and Computer Science
University of California, Irvine


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
