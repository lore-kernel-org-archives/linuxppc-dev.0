Date: Mon, 31 Jul 2000 18:40:24 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Martin Costabel <costabel@wanadoo.fr>
cc: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: CONFIG_PPC != Mac
In-Reply-To: <39857AE8.766DC3C3@wanadoo.fr>
Message-ID: <Pine.LNX.4.10.10007311830080.20511-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I am fighting with the "new input layer" right now, although I don't
> quite understand why this thing is being inflicted upon innocent ADB
> users.

My question exactly.

> The main problem so far is that I cannot get mouse button emulation to
> work. Has anyone tested this on an ADB keyboard/mouse? Or does it only
> work if one goes over completely to the "linux" keycodes? I don't want
> to do this yet, because it will make my system unusable with any other
> kernel (or maybe unusable at all). Last time I tried, it took me several
> hours to get a usable system back.

ADB keyboard and mouse work (and button emulation works as well) with
CONFIG_NEW_INPUT_LAYER not set. What doesn't work for me anymore is the
USB mouse. The 2.2.17 kernel (rsynced last Thursday) only compiled after I
added a #ifdef CONFIG_MOUSEDEV somewhere in mac_keyb.c as a consequence of
not having CONFIG_NEW_INPUT_LAYER defined. I'd look it up on the Lombard
but the box just crashed on me the second time in a row today. 2.2.17 sure
is exciting.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
