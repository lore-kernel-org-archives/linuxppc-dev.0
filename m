Message-ID: <3849845E.2A27621A@jlc.net>
Date: Sat, 04 Dec 1999 16:15:10 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Martin Costabel <costabel@wanadoo.fr>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: arch/ppc/math-emu ?
References: <38491C0F.8934B801@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Martin Costabel wrote:
> 
> Is the code in arch/ppc/math-emu ever used by anyone?


Yes, it is being used in the MPC8xx ports.  There are patches floating
around to fix the trivial current->tss problem, and I will update that
one of these days when I make another CVS update.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
