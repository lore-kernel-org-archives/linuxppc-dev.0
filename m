Date: Wed, 5 Mar 2003 10:12:34 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>
Cc: Dan Malek <dan@embeddededge.com>,
	Daniel Jacobowitz <drow@false.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Improved copy_page() function, about 30% speed up for mpc860!
Message-ID: <20030305171234.GC19303@ip68-0-152-218.tc.ph.cox.net>
References: <3E64DB91.4050508@embeddededge.com> <IGEFJKJNHJDCBKALBJLLEEMPFKAA.joakim.tjernlund@lumentis.se> <20030304233558.GA17093@ip68-0-152-218.tc.ph.cox.net> <008201c2e2a8$1afc4a40$020120b0@jockeXP> <20030305000542.GC17093@ip68-0-152-218.tc.ph.cox.net> <009001c2e2ac$d44c55e0$020120b0@jockeXP>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <009001c2e2ac$d44c55e0$020120b0@jockeXP>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Mar 05, 2003 at 01:19:04AM +0100, Joakim Tjernlund wrote:
> > > from http://lists.linuxppc.org/linuxppc-dev/200303/msg00022.html
> >
> > Well, the whole change is at:
> > http://ppc.bkbits.net:8080/linuxppc_2_4_devel/cset@1.118.1.428?nav=index.html|ChangeSet@-1d
> >
> > So, that should give it more context and make it clearer, I hope..
>
> Yes, but how did you come up with the fix in the first place? Trial end error or did Motorla help you?

It wasn't me personally, but it was trial and error I believe.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
