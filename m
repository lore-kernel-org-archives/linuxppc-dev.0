To: "Andrew Dennison" <andrew.dennison@motec.com.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: JTAG debuggers for Motorola 8xx/82xx/85xx 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 18 Jun 2004 15:21:15 +1000."
             <002601c454f4$13e589a0$ee00a8c0@CAT>
Date: Fri, 18 Jun 2004 11:39:58 +0200
Message-Id: <20040618094003.1DC3EC13D3@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <002601c454f4$13e589a0$ee00a8c0@CAT> you wrote:
>
> > Note that the GDB in our ELDK not only supports the BDM4GDB, but also
> > the wiggler ...
>
> So I could use a wiggler and GDB from ELDK with MPC5200?

No, sorry if I gave you a wrong idea.

So far we can only support the BDM interface; to implement  interface
software  for  the  JTAG/COP  port  as  used  on  60x  based  systems
(including the MPC5200) you need special documentation from Motorola,
which is only available under a pretty strict NDA. The terms of  this
NDA  prevent any open source implementation, so we cannot add this to
GDB.


> I've been asked to try to avoid buying a BDI2000 for now :(

What a silly question ;-)

> I already have the Greenhills slingshot and Metrowerks Wiretap from the
> 5200lite kit but they seem to be paper weights without their (expensive)
> integrated software tools...

Indeed.

Just go ahead and buy a BDI2000...

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Contrary to popular belief, thinking does not cause brain damage.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
