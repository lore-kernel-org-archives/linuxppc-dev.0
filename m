Message-ID: <XFMail.000817093853.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.10.10008162005100.22954-100000@opal.biophys.uni-duesseldorf.de>
Date: Thu, 17 Aug 2000 09:38:53 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Subject: Re: keyboard
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> I see that there are some unused codes in the translation table in
>> usb/keybdev.c. May I use them to map the new keys ?
>
> Big win if all of these keys produce the same keycode :-)

Ehm, no. keypress code is different, but keyrelease code if 180
for all of them. What a mess.


Bye.
    Giuliano Pochini ->)|(<- Shiny Corporation {AS6665} ->)|(<-


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
