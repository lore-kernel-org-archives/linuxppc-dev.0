Date: Wed, 16 Jan 2002 12:39:58 +0100 (CET)
From: Gabriel Paubert <paubert@iram.es>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Larry McVoy <lm@bitmover.com>,
	Kenneth Johansson <ken@kieraypc01.p.y.ki.era.ericsson.se>,
	"linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Problems with linuxppc_2_4_devel
In-Reply-To: <20020115211030.GH764@cpe-24-221-152-185.az.sprintbbd.net>
Message-ID: <Pine.LNX.4.33.0201161237090.21073-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 15 Jan 2002, Tom Rini wrote:

> On Tue, Jan 15, 2002 at 01:02:03PM -0800, Larry McVoy wrote:
>
> > a) try and connect to a well known time server and see if the time is too
> >    far off at commit time.  May or may not work.
>
> This would require some external program tho, wouldn't it?

It's called ntpq, and I believe most people should have it installed, even
if they don't go to full ntpd synchornisation. Besides that, the NTP
protocol is very simple, especially if you don't care about round trip
time measurement: it's UDP (on port 123 AFAIR).

>
> > b) see if the time is "too different" from the last changeset.  Most trees
> >    are fairly active and if the time is too far ahead (say a month?), then
> >    raise a warning and ask the user to confirm this is the correct time.
>
> I'd say 'b' with an override option (yes, the clock IS fine, the tree
> has just been dead for awhile).

Probably the best solution indeed...

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
