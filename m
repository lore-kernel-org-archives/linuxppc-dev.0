Message-Id: <200003300704.JAA30539@denx.local.net>
To: greyham@research.canon.com.au (Graham Stoney)
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Tiny fix to fec.c for RPX boards using only fast ethernet 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 30 Mar 2000 12:47:03 +1000."
             <20000330024703.3E3C0355E8@elph.research.canon.com.au>
Date: Thu, 30 Mar 2000 09:04:13 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20000330024703.3E3C0355E8@elph.research.canon.com.au>
Graham Stoney wrote:
>
> the same MAC address. The munged address is still in their OUI block, whereas
> using the same address on two interfaces is definitely illegal.

Why should this be illegal?

You will run into problem when you try  to  connect  both  interfaces
(having  athe same MAC address) to the same subnet, but why would you
want to do this?

For a common example just look at Sun workstations:  they  _all_  are
using  the  same MAC address for all ethernet interfaces there are in
one box...

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
8 Catfish                                               = 1 Octo-puss

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
