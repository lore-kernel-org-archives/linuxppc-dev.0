Date: Wed, 16 Jan 2002 19:43:39 +0100 (CET)
From: Gabriel Paubert <paubert@iram.es>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Larry McVoy <lm@bitmover.com>,
	Kenneth Johansson <ken@kieraypc01.p.y.ki.era.ericsson.se>,
	"linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Problems with linuxppc_2_4_devel
In-Reply-To: <20020116150722.GE5220@cpe-24-221-152-185.az.sprintbbd.net>
Message-ID: <Pine.LNX.4.33.0201161900290.21073-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 16 Jan 2002, Tom Rini wrote:

> On Wed, Jan 16, 2002 at 12:39:58PM +0100, Gabriel Paubert wrote:
> >
> >
> > On Tue, 15 Jan 2002, Tom Rini wrote:
> >
> > > On Tue, Jan 15, 2002 at 01:02:03PM -0800, Larry McVoy wrote:
> > >
> > > > a) try and connect to a well known time server and see if the time is too
> > > >    far off at commit time.  May or may not work.
> > >
> > > This would require some external program tho, wouldn't it?
> >
> > It's called ntpq, and I believe most people should have it installed
> [snip]
>
> Should doesn't mean they will tho. :)  And the first time you assume
> everyone has something, 5 people pop up screaming 'cuz they don't.

No, but as I said, the protocol is trivial if you want a very approximate
time (use NTP v3 since all V4 servers I know support it). The problem is
finding the closest server, not sending an UDP packet and decoding the
answer and giving up if you don't receive anything after 5 packets or so.
I'm almost certain there is database of servers somewhere, but I just
don't remember where (between 2 cesium clocks, one hydrogen maser, 2 GPS
and one radio receiver I have enough references for my use at the
telescope ;-)). I also don't know whether some people could be blocked
from using NTP, but I don't think that it is a satisfactory solution in
any case.

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
