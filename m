Message-ID: <39C15A45.3723CCF6@wanadoo.fr>
Date: Fri, 15 Sep 2000 01:07:49 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: mlan@cpu.lu, linuxppc-dev@lists.linuxppc.org
Subject: Re: per-fb mmap for platinumfb and valkyriefb in 2.4 (and 2.2)
References: <200009140546.HAA00808@piglet.grunz.lu> <39C155BF.1A150162@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Martin Costabel wrote:

> One funny thing: In X, my Alt keys don't work correctly ("ModeShift")
> any more, they give "Alt_R" now. In the console, this is still OK. I
> suppose this cannot come from the mmap stuff, so this must come from
> some of the other changes in the bitkeeper tree in the last 2 days. I
> didn't change anything else in my config.

Sorry for the false alarm, after restarting X all keys are working
normally. Out of crash fear, I had unmounted a few partitions before
starting X and remounted them afterwards. Somehow the keymap got
perturbed by this.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
