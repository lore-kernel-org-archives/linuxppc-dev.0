Message-Id: <200010261617.e9QGHNP03365@denx.local.net>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Using MPC8BUG on custom boards... 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 26 Oct 2000 17:22:44 +0200."
             <001f01c03f60$982d74a0$0a00010a@airvent.it>
Date: Thu, 26 Oct 2000 18:17:23 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <001f01c03f60$982d74a0$0a00010a@airvent.it>
Paolo Scaffardi wrote:
>
> I'm using MPC8BUG connected via the ADI port to my FADS823, and the FADS
> connected via the debug port to our custom board. I cannot load a program
> into a flash because MPC8BUG doesnt detect it correctly.
>
> Does anyone know how to configure MPC8BUG to use other flashes than the
> FADS?
>
> Another way can be writing a custom code on the RAM that does that...

Ummm... get some real BDM debugger (and while you are at it, get  one
that supports the MMU). See for instance
http://bdm4gdb.sourceforge.net/

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Remember that Beethoven wrote his first symphony in C ...

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
