Date: Tue, 4 Mar 2003 16:35:58 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Cc: Dan Malek <dan@embeddededge.com>,
	Daniel Jacobowitz <drow@false.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Improved copy_page() function, about 30% speed up for mpc860!
Message-ID: <20030304233558.GA17093@ip68-0-152-218.tc.ph.cox.net>
References: <3E64DB91.4050508@embeddededge.com> <IGEFJKJNHJDCBKALBJLLEEMPFKAA.joakim.tjernlund@lumentis.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <IGEFJKJNHJDCBKALBJLLEEMPFKAA.joakim.tjernlund@lumentis.se>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Mar 04, 2003 at 11:01:59PM +0100, Joakim Tjernlund wrote:

> Maybe user space also can be fixed with instruction decoding
> as Daniel said even if it's ugly. Then you would not have to worry about
> apps/libs using dcbz, at least it would work but perhaps the performance sucks
>
> Tom, can you shed some light on this? The BK log lists you as the one
> who committed this change.

Which change in particular are you talking about?  But I think as Dan
has said, it's best to just accept this and move along. :)  It's known
to be horribly broken in some cases, but not admited to by Motorola, and
distinguishing between 8xx's at runtime is not trivial.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
