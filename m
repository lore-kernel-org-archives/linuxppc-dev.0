Date: Wed, 16 Jan 2002 12:37:03 +0100 (CET)
From: Gabriel Paubert <paubert@iram.es>
To: Larry McVoy <lm@bitmover.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Kenneth Johansson <ken@kieraypc01.p.y.ki.era.ericsson.se>,
	"linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Problems with linuxppc_2_4_devel
In-Reply-To: <20020115130203.K15959@work.bitmover.com>
Message-ID: <Pine.LNX.4.33.0201161230530.21073-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 15 Jan 2002, Larry McVoy wrote:

> What I was thinking was one of two approaches:
>
> a) try and connect to a well known time server and see if the time is too
>    far off at commit time.  May or may not work.

While there are NTP servers all around the globe (and I maintain the one
we have here at work), finding the nearest one is not always easy.
Furthermore some people may create a changeset while disconnected on a
laptop or would object the cost of an additional call just to get the
time.


> b) see if the time is "too different" from the last changeset.  Most trees
>    are fairly active and if the time is too far ahead (say a month?), then
>    raise a warning and ask the user to confirm this is the correct time.

Probably better, although I like the a) solution because it is likely to
be more exact. AFAIK the bk variables in the usr home directory only
affect the GUI Tools look and feel, it would be too much a stretch to add
a time server specification, no ?

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
