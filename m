Date: Wed, 16 Aug 2000 20:07:04 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Giuliano Pochini <pochini@denise.shiny.it>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: keyboard
In-Reply-To: <399B1D7E.FE4D6D4E@denise.shiny.it>
Message-ID: <Pine.LNX.4.10.10008162005100.22954-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I have a microsoft (bleah) "internet keyboard" attached to my G3.
> None of the new 19 keys works. When I press them it writes:
>
> Aug 15 15:56:35 Jay kernel: keyboard.c: can't emulate rawmode for keycode 165
>
> I see that there are some unused codes in the translation table in
> usb/keybdev.c. May I use them to map the new keys ?

Big win if all of these keys produce the same keycode :-)

You can solve your problem much easier with loadkeys and a tailored
console keymap. Why pollute the kernel with that stuff (except for the
learning experience)?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
