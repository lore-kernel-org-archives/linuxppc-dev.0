Date: Tue, 15 Jan 2002 13:02:03 -0800
From: Larry McVoy <lm@bitmover.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Larry McVoy <lm@bitmover.com>, Gabriel Paubert <paubert@iram.es>,
	Kenneth Johansson <ken@kieraypc01.p.y.ki.era.ericsson.se>,
	"linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Problems with linuxppc_2_4_devel
Message-ID: <20020115130203.K15959@work.bitmover.com>
References: <20020115162546.GB764@cpe-24-221-152-185.az.sprintbbd.net> <Pine.LNX.4.33.0201151756200.11139-100000@gra-lx1.iram.es> <20020115112233.E15959@work.bitmover.com> <20020115205755.GF764@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020115205755.GF764@cpe-24-221-152-185.az.sprintbbd.net>; from trini@kernel.crashing.org on Tue, Jan 15, 2002 at 01:57:55PM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


What I was thinking was one of two approaches:

a) try and connect to a well known time server and see if the time is too
   far off at commit time.  May or may not work.
b) see if the time is "too different" from the last changeset.  Most trees
   are fairly active and if the time is too far ahead (say a month?), then
   raise a warning and ask the user to confirm this is the correct time.

Comments?

On Tue, Jan 15, 2002 at 01:57:55PM -0700, Tom Rini wrote:
> On Tue, Jan 15, 2002 at 11:22:33AM -0800, Larry McVoy wrote:
>
> > Would you like me to make you a "pre-commit" trigger which catches these
> > problems?
>
> If you've got the time, sure.  Hopefully we're all done breaking our
> clocks tho. :)
>
> --
> Tom Rini (TR1265)
> http://gate.crashing.org/~trini/

--
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
