Message-ID: <XFMail.000817093717.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.10.10008162005100.22954-100000@opal.biophys.uni-duesseldorf.de>
Date: Thu, 17 Aug 2000 09:37:17 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Subject: Re: keyboard
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> Aug 15 15:56:35 Jay kernel: keyboard.c: can't emulate rawmode for keycode
>> 165
>>
>> I see that there are some unused codes in the translation table in
>> usb/keybdev.c. May I use them to map the new keys ?
>
> Big win if all of these keys produce the same keycode :-)
>
> You can solve your problem much easier with loadkeys and a tailored
> console keymap.

No, I can't. mac_keyb.c uses a byte to store the pressed key. 1 bit is used
for pressed/released flag, so key codes range is 1-127. That special keys
have a code > 127 so currently they're not mapped at all.
I must change the kernel to remap that codes to something < 128.

Or perhaps I'll fix it by allowing int16_t keycodes just like on peecees.

Bye.
    Giuliano Pochini ->)|(<- Shiny Corporation {AS6665} ->)|(<-


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
