Message-ID: <399B1D7E.FE4D6D4E@denise.shiny.it>
Date: Wed, 16 Aug 2000 19:02:22 -0400
From: Giuliano Pochini <pochini@denise.shiny.it>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: keyboard
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have a microsoft (bleah) "internet keyboard" attached to my G3.
None of the new 19 keys works. When I press them it writes:

Aug 15 15:56:35 Jay kernel: keyboard.c: can't emulate rawmode for keycode 165

I see that there are some unused codes in the translation table in
usb/keybdev.c. May I use them to map the new keys ?

Bye.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
