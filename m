Message-ID: <39FDE67D.AD28BA91@noos.fr>
Date: Mon, 30 Oct 2000 22:22:05 +0100
From: Guillaume Laures <guillaume.laures@noos.fr>
MIME-Version: 1.0
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Keyboard trouble with XF 4.0.1R
References: <200010292209.XAA02779@piglet.grunz.lu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Lanners wrote:

> Hi all,
>
> Just to add to this thread, I wonder whether anybody has noticed that
> Apple Extended keyboards don't get switched to a different ADB
> handler,
> in order to enable right and left modifier keys to send different
> keycodes.

Hopefully they are back wtih the linux keycodes.
I mapped R & L ctrl to Control.
L alt to Mode_switch (the key we use in MacOS to modify the meaning of
keys, eg l-> |).
R & L Apple to meta
R alt to "I dunno what" but this is the key that allows to switch from X
to console (with alt + Fx), needs to be fixed to Mode_switch as well,
and use both Apple to switch from X to console


--
GoM


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
