Message-ID: <3F4CE88B.2050307@mvista.com>
Date: Wed, 27 Aug 2003 10:21:15 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: ??? <ksshin@essetel.com>
Cc: Paul White <pwhite@bivio.net>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: interrupt handling in 7410+64260
References: <Pine.LNX.4.21.0308262014240.17370-100000@stimpy.bivio.net> <007301c36c53$079163c0$960aa8c0@ksshin>
In-Reply-To: <007301c36c53$079163c0$960aa8c0@ksshin>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


ksshin@essetel.com wrote:

>In Linux kernel, there is a example about handling internal
>interrupt(mpsc as serial, ethernet), but I can't find the example for
>about handling external interrupt with GPP.
>
There are plenty of examples including DUART & PCI interrupts in ev64260.c.

>Is there anyone who know that how to handle the external interrupt
>with GPP in 7410/64260?
>
>
Just look at ev64260.c, cpci690.c, hxeb100.c, ...

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
