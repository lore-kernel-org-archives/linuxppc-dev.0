Subject: Re: Odd problem with 2.4 backport of radeon driver
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Ken Offer <koffer@arlut.utexas.edu>
Cc: linuxppcdev <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <684DF574-0320-11D8-8EDF-000393467F1A@arlut.utexas.edu>
References: <684DF574-0320-11D8-8EDF-000393467F1A@arlut.utexas.edu>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1066670797.9929.11.camel@thor.asgaard.local>
Mime-Version: 1.0
Date: Mon, 20 Oct 2003 19:26:37 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2003-10-20 at 19:11, Ken Offer wrote:
>
> I've been trying to backport parts of the 2.6 radeon driver into the
> 2.4 radeon driver in an effort to support the 15" Powerbooks.  The chip
> in question is the Radeon Mobility 9600 (i.e. chip set 0x4e50, RV350 NP
> in the driver).
>
> I'm *almost* there, but I got stuck.  A large portion of the lines on
> the screen are garbled... but strangely, not ALL of them.
>
> Under X11, it looks like the top 20 lines are OK, and the bottom 40% of
> the screen is OK, but the rest looks like the "row bytes" are incorrect
> for those lines.  In text-console mode, all the screen is garbled
> except for the top few lines.

OF sets up a surface with tiling. The code related to
surf_{lower_bound,upper_bound,info} in drivers/video/aty/radeon_base.c
deals with this.


--
Earthling Michel Dänzer   \  Debian (powerpc), XFree86 and DRI developer
Software libre enthusiast  \     http://svcs.affero.net/rm.php?r=daenzer


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
