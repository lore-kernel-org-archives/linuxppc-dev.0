To: GOTZON ASTONDOA <gastondoa@fagorautomation.es>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: IDE on PCMCIA error 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 25 Oct 2001 16:08:04 +0200."
             <CA78D1B723D8D411AF0300508BDCF74F3F9D10@NTCORREO>
Date: Thu, 25 Oct 2001 16:42:51 +0200
Message-Id: <20011025144256.B79D310CD9@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <CA78D1B723D8D411AF0300508BDCF74F3F9D10@NTCORREO> you wrote:
>
> I´m trying to install direct IDE on PCMCIA port on a MPC823FADS board.
> (Excuse me for the long mail)

Don't apologize - I always prefer a long and detailed error report to
the short message "XXX doen't work for me."

> I configured the ppcboot (1.0.0) and the kernel to do this. I am using a
> "PCMCIA type III ATA card".

Which vendor, which type?

>       PCMCIA:unknown card type

You're pretty lost here; when  PPCBoot  cannot  recognize  the  card,
Linux  will not understand it, either (both use more or less the same
code for that purpose). Also, Linux relies on the  initialization  of
the PCMCIA interface performed by PPCBoot.

>  I don´t see any similar question in the mailing list.
>  What do i forget or what and where i am doing wrong? I´m using an
> unsupported card?

Yes, for some reason your card is not recognized. Either you dig into
the PPCBoot code to find out whats going wrong, or I can  offer  that
we  do  that  for  you  - but you'd have to donate one of your PCMCIA
cards ;-)


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
If the odds are a million to one against something occuring,  chances
are 50-50 it will.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
