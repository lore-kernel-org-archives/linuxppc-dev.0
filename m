Date: Tue, 15 Jan 2002 14:10:30 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Larry McVoy <lm@bitmover.com>
Cc: Gabriel Paubert <paubert@iram.es>,
	Kenneth Johansson <ken@kieraypc01.p.y.ki.era.ericsson.se>,
	"linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Problems with linuxppc_2_4_devel
Message-ID: <20020115211030.GH764@cpe-24-221-152-185.az.sprintbbd.net>
References: <20020115162546.GB764@cpe-24-221-152-185.az.sprintbbd.net> <Pine.LNX.4.33.0201151756200.11139-100000@gra-lx1.iram.es> <20020115112233.E15959@work.bitmover.com> <20020115205755.GF764@cpe-24-221-152-185.az.sprintbbd.net> <20020115130203.K15959@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020115130203.K15959@work.bitmover.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jan 15, 2002 at 01:02:03PM -0800, Larry McVoy wrote:

> a) try and connect to a well known time server and see if the time is too
>    far off at commit time.  May or may not work.

This would require some external program tho, wouldn't it?

> b) see if the time is "too different" from the last changeset.  Most trees
>    are fairly active and if the time is too far ahead (say a month?), then
>    raise a warning and ask the user to confirm this is the correct time.

I'd say 'b' with an override option (yes, the clock IS fine, the tree
has just been dead for awhile).

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
