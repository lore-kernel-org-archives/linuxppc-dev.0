Date: Thu, 23 Mar 2000 16:38:36 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: PB2000 (pismo) install feedback
In-Reply-To: <20000323142808.002464@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.10.10003231550560.12669-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >There's been a patch by Geert on this list to fix this - basically
> >subtract GUI_RESERVE from the determined vram size in atyfb.c for all 8 MB
> >Rage Pro (and possibly other) chips to prevent the screen clear from
> >stepping on the card registers.
>
> It's a different issue. This machine has a r128 and aty128fb works fine
> with the few fixes we added for the M3. The problem is with offb and seem
> to be related to some timing issues when accessing the DAC palette
> registers. Henry found a fix for this, I'll add this to my kernel asap.

OK, I didn't catch the point that the new PB has a rage128. You're lucky,
then.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
