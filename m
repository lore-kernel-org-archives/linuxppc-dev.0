Date: Thu, 17 Aug 2000 11:48:56 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Giuliano Pochini <pochini@shiny.it>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: keyboard
In-Reply-To: <XFMail.000817093717.pochini@shiny.it>
Message-ID: <Pine.LNX.4.10.10008171147270.8338-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > You can solve your problem much easier with loadkeys and a tailored
> > console keymap.
>
> No, I can't. mac_keyb.c uses a byte to store the pressed key. 1 bit is used
> for pressed/released flag, so key codes range is 1-127. That special keys
> have a code > 127 so currently they're not mapped at all.

So it's a more generic problem ...

> I must change the kernel to remap that codes to something < 128.
>
> Or perhaps I'll fix it by allowing int16_t keycodes just like on peecees.

The latter, if at all possible (because that allows for using the console
keymap tools again if I'm not mistaken).

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
