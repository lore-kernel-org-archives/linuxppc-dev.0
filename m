Date: Tue, 26 Aug 2003 20:18:23 -0700 (PDT)
From: Paul White <pwhite@bivio.net>
To: =?ks_c_5601-1987?B?vcWw5rz2?= <ksshin@essetel.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: interrupt handling in 7410+64260
In-Reply-To: <005901c36c41$e7d2c5d0$960aa8c0@ksshin>
Message-ID: <Pine.LNX.4.21.0308262014240.17370-100000@stimpy.bivio.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

Its been a little while since I've looked at the GT64260 manual,
but I believe you configure the MPP pins as interrupt pins.  These
then are masked/seen via the GPP_INTR_CAUSE (0xf108) and
GPP_INTR_MASK (0xf10c) registers.  Then, I believe that somewhere in
the CPU's mask, you can enable/disable the GPP/MPP interrupts.

This is what I recall from memory, but hopefully it'll get you
started.

Paul White
Senior Enginer, Software
Bivio Networks, Inc.
http://www.bivio.net


On Wed, 27 Aug 2003, [ks_c_5601-1987] ½Å°æ¼ö wrote:

>
> I have a custom MPC7410 + GT64260 board and
> I successfully ported linux to that board.
> Now, I am trying to handle the mii interrupt.
> The MII INT Line is connected to MPP 14, 15.
> How to handle that interrupt or where I can find
> out the example for external interrupt with MPP
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
