To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: "unhandled relocation type 18" ??? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 06 Mar 2001 08:25:41 +0100."
             <Pine.LNX.4.05.10103060824030.29713-100000@callisto.of.borg>
Date: Tue, 06 Mar 2001 09:02:21 +0100
Message-Id: <20010306080226.6846A287E8@denx.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <Pine.LNX.4.05.10103060824030.29713-100000@callisto.of.borg> you wrote:
> On Mon, 5 Mar 2001, Wolfgang Denk wrote:
> > when trying to "insmod" a  kernel  module  that  uses  floating-point
> > functions  like  "sin", we get error messages:
> >
> > 	unhandled relocation type 18
>
> Does it also complain about a missing symbol for `sin'?

No, it does not.

We made sure to link the module with  the  math  library  to  resolve
those references.

But we still get those  error  messages;  the  first  is  always  for
lshrdi3  -  which is linked with our module (but also provided by the
kernel - could there be any problems?), and then we get a  long  list
of errors for pack and unpack functions - whatever they are.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
An Elephant is a mouse with an Operating System.              - Knuth

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
