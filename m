From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Jeglinski <jeglin@4pi.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4.9-bk and X on 6500, not so good
Date: Tue, 21 Aug 2001 10:15:47 +0200
Message-Id: <20010821081547.5029@smtp.wanadoo.fr>
In-Reply-To: <p04330104b7a79e11b8be@[24.25.18.209]>
References: <p04330104b7a79e11b8be@[24.25.18.209]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I have a stock 6500/300, on which I just compiled and installed the
>ppc.bitkeeper linuxppc_2_4 (2.4.9) kernel. In console mode (RL3) it
>works just fine.
>
>But whenever I launch X (Gnome for example, or a plain window
>manager), about 70% of the time it breaks into the mon debugger
>before X has fully launched.
>
>Problem is, there is no keyboard response at this point, and I can't
>even restart with the 3-fingered approach (no response). Only thing
>that works is power down, and restart.
>
>Any suggestions? To create a backtrace appears impossible...

You can at least get the PC and LR values displayed by xmon and
lookup them in your System.map. Eventually, you can hack xmon
entry point to do a backtrace automatically.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
