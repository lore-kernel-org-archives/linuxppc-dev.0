To: Sylvain Munaut <tnt@246tnt.com>
Cc: "Robert P. J. Day" <rpjday@mindspring.com>,
	Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: kernel option "Command line partition table parsing" 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 29 Jun 2004 14:46:30 +0200."
             <40E164A6.8060502@246tNt.com>
Date: Tue, 29 Jun 2004 16:37:10 +0200
Message-Id: <20040629143715.2AF7EC109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <40E164A6.8060502@246tNt.com> you wrote:
>
> I'd suggest having a look at the comment on top of
>
> drivers/mtd/cmdlinepart.c
>
> But I'm not sure if rpxlite.c . From what I see, it may require to add
> a "probe" to look at the command line. Someone ?

It's tested and working in our version of the linuxppc_2_4_devel tree.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"...all the  good  computer  designs  are  bootlegged;  the  formally
planned  products,  if  they  are built at all, are dogs!" - David E.
Lundstrom, "A Few Good Men From Univac", MIT Press, 1987

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
