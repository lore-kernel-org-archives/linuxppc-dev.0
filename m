To: o_y <o_yahav@netvision.net.il>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC860T FEC problem 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 07 Sep 2002 18:59:02 +0200."
             <MBBBIOFIICDAPDMKHBDEKEDLCAAA.o_yahav@netvision.net.il>
Date: Sat, 07 Sep 2002 19:14:57 +0200
Message-Id: <20020907171502.BF3EFFA8A@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

in message <MBBBIOFIICDAPDMKHBDEKEDLCAAA.o_yahav@netvision.net.il> you wrote:
>
> I'm trying to port linux 2.2.14 on MPC860T and busybox as initrd.

2.2.14 is prehistoric stuff. Don't waste your time on  all  the  bugs
and problems that have been fixed since.

> I have not seen any initializetion of the BCSR4 so i initialize it with the
> value
> that ppcboot uses , so the ENABLE led is on too.

Ummm... What's BCSR4? If PPCBoot initializes it, why do you  have  to
initialize it again?

> The device isn't working even when i use ppcboot (i configured ppcboot to
> use it).

Sic! So get PPCBoot running first.

> 1. Why there is no initializetion of BCSR4 in the original code?
> 2. If BCSR4 must be initialized , what is the correct value?
> 3. Is any one have a code that succeeded getting FEC device to work?

Among all the things you don;t care to mention is which  bard  you're
working  on.  My  guess is that it simply never was really working in
that old kernel version.

As I said before: you are wasting your time. Use a current kernel.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The faster I go, the behinder I get.                 -- Lewis Carroll

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
