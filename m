Date: Wed, 26 May 2004 13:20:27 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Matt Porter <mporter@kernel.crashing.org>,
	Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: curious about BK checkin protocol
In-Reply-To: <20040526165705.GT6763@smtp.west.cox.net>
Message-ID: <Pine.LNX.4.58.0405261315420.26326@localhost.localdomain>
References: <Pine.LNX.4.58.0405250909280.14496@localhost.localdomain>
 <20040525102352.A1329@home.com> <Pine.LNX.4.58.0405260714540.24178@localhost.localdomain>
 <20040526165705.GT6763@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 26 May 2004, Tom Rini wrote:

> I still like to argue that it's best to loudly blow up than to compile
> fine and then die in other ways at run-time (if someone hadn't gotten
> the last problem fixed on 8xx I was getting tempted to move what we had
> done now up with an #error tossed on top of head_8xx.S pointing people
> to what's wrong, etc).

that's a fair statement.  but, from my perspective, before i tried this
recently, i had *no* clue about the possibility of linux on 8xx, and
grabbed the linuxppc-2.5 tree, which of course didn't compile because of
that one issue.  once i got that compile issue out of the way, i was
purely deeeelighted to see a kernel actually load and boot to user space
and at least start init before hanging.  and this was after doing
*nothing* in terms of customizing the kernel for my board.

even with going no further than that, i could at least take comfort in the
fact that *something* was happening.  it's an admittedly nitpicky
perspective, but seeing even that partial progress made me one happy
camper.

anyway, at this point, i'll just be waiting with bated breath for new
patches.  too exciting for words ...

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
