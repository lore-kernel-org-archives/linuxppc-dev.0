Date: Thu, 27 Dec 2001 19:09:47 -0800
From: David Ashley <dash@xdr.com>
Message-Id: <200112280309.fBS39lG00172@dave.home>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: eth0: transmit timed out
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>Hello,
>
>It seems that the kernel cannot send on ethernet.
>(transmit timed out).
>What can be the source of such a problem ?
>
>Thanks
>
>C. Leroy
>
>
>
>eth0: CPM ENET Version 0.2 on SCC1, 08:00:3e:01:00:17


I was getting similiar messages on the fcc_enet.c driver from hhl 2.4.2
after I turned on bridge support (2 ethernet ports in the box) and
didn't have anything plugged into the other adapter. The solutions then
were to
1) Ignore the errors
2) Modify the driver so it doesn't make so much noise
3) Plug something into the port.

I don't know whether this applies to your situation though. BTW I
opted for #2.

-Dave


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
