Date: Thu, 3 Aug 2000 00:16:54 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Martin Costabel <costabel@wanadoo.fr>,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: New input layer and ADB (Was Re: CONFIG_PPC != Mac)
In-Reply-To: <Pine.LNX.4.10.10008021445550.427-100000@cassiopeia.home>
Message-ID: <Pine.LNX.4.10.10008030011181.14639-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Sometimes after a console switch, I end up in capslock mode. Switching
> > capslock on then gives lowercase letters (except the letter "L"). After
> > a further console switch, things return to normal.
>
> That's normal. With PC keyboards, the LED state of the Caps Lock key is
> controlled by Linux, while Mac (and Amiga) keyboards remember the Caps Lock
> state in the keyboard. Hence if you do a VC switch to a VC where Caps Lock is

Wrong for Mac. We explicitly set LED state from the keyboard bottom half
if necessary (though it stopped working consistently sometime in 2.1
IIRC).

The CapsLock on ADB keyboards is worth a million laughs actually. It
is sticky by hardware, and never sends a key up event, only key down. See
mac_keyb.c.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
