Message-ID: <003301c375c4$866c2520$960aa8c0@ksshin>
From: "???" <ksshin@essetel.com>
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <Pine.LNX.4.21.0308262014240.17370-100000@stimpy.bivio.net> <007301c36c53$079163c0$960aa8c0@ksshin> <3F4CE88B.2050307@mvista.com>
Subject: Re: interrupt handling in 7410+64260
Date: Mon, 8 Sep 2003 13:49:01 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thank you for your response.

according to your message, I try to find example source in
my linux kernel(my Linux kernel is 2.4.18 from montavista)
but I cannot find sources like cpci690.c, hxeb100.c and ev64260.c

I also try to handle an external interrupt from MPP in various way.
But I Failed until now.

please help me...

----- Original Message -----
From: "Mark A. Greer" <mgreer@mvista.com>
To: "???" <ksshin@essetel.com>
Cc: "Paul White" <pwhite@bivio.net>; <linuxppc-embedded@lists.linuxppc.org>
Sent: Thursday, August 28, 2003 2:21 AM
Subject: Re: interrupt handling in 7410+64260


>
> ksshin@essetel.com wrote:
>
> >In Linux kernel, there is a example about handling internal
> >interrupt(mpsc as serial, ethernet), but I can't find the example for
> >about handling external interrupt with GPP.
> >
> There are plenty of examples including DUART & PCI interrupts in ev64260.c.
>
> >Is there anyone who know that how to handle the external interrupt
> >with GPP in 7410/64260?
> >
> >
> Just look at ev64260.c, cpci690.c, hxeb100.c, ...
>
> Mark
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
