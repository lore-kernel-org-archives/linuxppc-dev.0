From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Jeglinski <jeglin@4pi.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4.2 USB and "mon>" (was Re: All 6 cards!!!)
Date: Thu, 8 Mar 2001 12:45:30 +0100
Message-Id: <20010308114530.17944@mailhost.mipsys.com>
In-Reply-To: <p04330100b6ccd0a23c2c@[24.162.228.89]>
References: <p04330100b6ccd0a23c2c@[24.162.228.89]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Yes, it helps a lot. The USB mouse now works in X. Attached are
>several (perhaps) pertinent records. There are no more USB errors in
>dmesg, lspci now shows a believable interrupt (IRQ 23). I've also
>attached lsprop, I'm not sure how to interpret it...
>
>Thanks for all the help. Awaiting the discussion. Posted to the
>dev-list also, hope that's OK with everybody...
>

Everything looks fine.

I'll push either that patch or a cleaner version to the bk tree
asap.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
