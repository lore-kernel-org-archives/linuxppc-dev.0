To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: kernel option "Command line partition table parsing" 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 29 Jun 2004 08:24:51 EDT."
             <Pine.LNX.4.60.0406290821150.19485@localhost.localdomain>
Date: Tue, 29 Jun 2004 14:57:05 +0200
Message-Id: <20040629125710.B6B28C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <Pine.LNX.4.60.0406290821150.19485@localhost.localdomain> you wrote:
>
>    i'm intrigued by the above kernel option.  currently, i define my
> MTD partitions in drivers/mtd/maps/rpxlite.c, using structs map_info,
> mtd_info, etc., and calling the appropriate routines, which works just
> fine.
>
>    will this kernel option actually let me define the basic MTD
> partitions completely from the kernel command line without messing
> with rpxlite.c?  or am i misreading the purpose of this option?

Yes, it will.

See http://www.denx.de/twiki/bin/view/DULG/BootTimeConfigurationOfMTDPartitions

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Even if you aren't in doubt, consider the mental welfare of the  per-
son who has to maintain the code after you, and who will probably put
parens in the wrong place.          - Larry Wall in the perl man page

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
