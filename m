Message-ID: <3988A242.90228AB0@wanadoo.fr>
Date: Thu, 03 Aug 2000 00:35:46 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: New input layer and ADB (Was Re: CONFIG_PPC != Mac)
References: <Pine.LNX.4.10.10008030011181.14639-100000@opal.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz wrote:
>
> > > Sometimes after a console switch, I end up in capslock mode. Switching
> > > capslock on then gives lowercase letters (except the letter "L"). After
> > > a further console switch, things return to normal.
> >
> > That's normal. With PC keyboards, the LED state of the Caps Lock key is
> > controlled by Linux, while Mac (and Amiga) keyboards remember the Caps Lock
> > state in the keyboard. Hence if you do a VC switch to a VC where Caps Lock is
>
> Wrong for Mac. We explicitly set LED state from the keyboard bottom half
> if necessary (though it stopped working consistently sometime in 2.1
> IIRC).
>
> The CapsLock on ADB keyboards is worth a million laughs actually. It
> is sticky by hardware, and never sends a key up event, only key down. See
> mac_keyb.c.

In any case, Franz's typo fix (lost "!") makes the problem disappearand
everything works as it should: VCs remember their capslock state
independently of what the capslock key itself remembers.

--
Martin
 

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
