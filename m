Date: Wed, 6 Feb 2002 15:37:44 -0800
From: Jeffery von Ronne <jronne@ics.uci.edu>
To: =?iso-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>
Cc: Kaoru Fukui <k_fukui@highway.ne.jp>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: two aty128 frame buffers?
Message-ID: <20020206153744.E3189@reepicheep.ics.uci.edu>
References: <20020204154626.C28199@reepicheep.ics.uci.edu> <200202050524.OAA13555@mail.highway.ne.jp> <20020204222214.A28746@reepicheep.ics.uci.edu> <1012901313.734.210.camel@pismo> <20020205151625.D761@reepicheep.ics.uci.edu> <1012954108.1885.3328.camel@pismo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1012954108.1885.3328.camel@pismo>; from michel@daenzer.net on Wed, Feb 06, 2002 at 01:08:28AM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Feb 06, 2002 at 01:08:28AM +0100, Michel Dänzer wrote:
> > I tried applying your hack to a virgin XF 4.2.0 source tree, and
> > I get a signal 11 crash.  The last output shows the X server loading
> > vgahw.

I strated sprinkling the code with R128_TRACE messages, and as near as I can
tell, the vgaHWGetIOBase is crashing.

--
Jeffery von Ronne <jronne@ics.uci.edu>
Graduate Student
Information and Computer Science
University of California, Irvine

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
