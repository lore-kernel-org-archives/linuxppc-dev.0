To: Okehee Goh <ogoh@asu.edu>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: How to dissable COM1 of MBX860 in order for SMC1 to be serial Console port?? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 04 Dec 2001 14:42:46 MST."
             <CPEELCODKANPCLBCAGOFIELICAAA.ogoh@asu.edu>
Date: Tue, 04 Dec 2001 23:24:11 +0100
Message-Id: <20011204222416.8E1D6F9C0@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <CPEELCODKANPCLBCAGOFIELICAAA.ogoh@asu.edu> you wrote:
>
>  The system MBX860's EPPC-Bug uses COM1 as a serial port instead of SMC1.
>  I want to know how to disable COM1 of MBX860 in order for SMC1 to be serial
> Console port??

How about using some existing firmware?

>  Is there any other thing I have to do for this work?
>  The following is my source code.

Don't re-invent  the  wheel  again  and  again.  All  this  has  been
implemented  so  many  times  before.  Grab  for instance the PPCBoot
sources, and use these.

Or even better,  check  if  PPCBoot  does  not  provide  exactly  the
functions  you are trying to implement yourslef (and if it doesn't it
may still be simpler to contribute your extensions to PPCBoot instead
of starting from scratch).

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
At the source of every error which is blamed on the computer you will
find at least two human errors, including the error of blaming it  on
the computer.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
