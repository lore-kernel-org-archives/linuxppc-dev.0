Date: Mon, 29 Mar 1999 18:59:34 -0500 (EST)
From: Tom Rini <tmrini@ntplx.net>
To: cort@ppc.kernel.org, Piotr Muszynski <u0295020@iwate-u.ac.jp>
cc: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: vger 2.2.5 kernel breaks (on scsi?)
In-Reply-To: <36FF53A7.5FB500AC@iwate-u.ac.jp>
Message-ID: <Pine.LNX.4.10.9903291740220.16395-100000@p07-42.hartford.dialin.ntplx.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 29 Mar 1999, Piotr Muszynski wrote:

> Vger sources as of ca. 10 hours before,  compiled with default or custom
> config,  PowerMac7500/601,  MESH,  BootX, R4.
> On boot the kernel repetitively resets scsi.  Had to cut that sad
> spectacle and come back to 2.2.4.
> Any thoughts (I keep compiler playfield in case someone might wish to
> look for clues)?

I'm getting this as well on my 7500 (CONFIG_PMAC, not CONFIG_ALL_PPC).
The problem seems to stem from the "smarter ioremap" as reverting
arch/ppc/mm/init.c to 1.152 allows me to boot again.

---
Tom Rini (TR1265)
http://dobbstown.yeti.edu/



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
