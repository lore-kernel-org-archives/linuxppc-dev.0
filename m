From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kostas Gewrgiou <gewrgiou@imbc.gr>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Sound stoppage: TRIAL code to re-start DEAD dma
Date: Wed, 28 Mar 2001 14:10:49 +0200
Message-Id: <20010328121049.10701@mailhost.mipsys.com>
In-Reply-To: <Pine.LNX.4.31.0103281418180.21345-100000@idd-01.imbc.gr>
References: <Pine.LNX.4.31.0103281418180.21345-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Nope it doesn't restart the frame, thats why we need to either reload it
>and return or continue as if it played correctly.
>
>I was wondering again today why we get the DEAD status in the powercomputing
>machines everything was working fine until 2.2.9/10 (there were no changes
>in dmasound at that point) so some other change is causing this i can't
>imagine anything though :(

Can this be the time when we added proper support for IDE M/DMA mode ?

Previously, our driver could do DMA, but couldn't configure the disk DMA
mode, leaving it in whatever state the firmware/MacOS set it up. Around
2.2.x (early, I don't remember when exactly), we added some code to
configure the timings properly.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
