Date: Wed, 3 Dec 2003 09:15:13 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: tx_full v.s tx_free race fix in 8xx_io/enet.c?
Message-ID: <20031203161513.GG912@stop.crashing.org>
References: <003501c3b85e$eb138ef0$020120b0@jockeXP>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <003501c3b85e$eb138ef0$020120b0@jockeXP>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Dec 02, 2003 at 12:00:27AM +0100, Joakim Tjernlund wrote:

> It seems to me that the old tx_full stuff is working better that the
> new tx_free.

What problem are you seeing without making any changes to the code as it
stands?

> Which race is it supposed to fix and how do I generate it?

I don't recall the exact details right now, but I think it was a
potential race (hence yes, you might not be able to trigger it) where
some packets could be lost (and a retransmitt would happen).  But again,
it's been a long time since I thought about this one.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
