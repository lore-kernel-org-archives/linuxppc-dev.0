To: greggiraud@netcourrier.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: boot linux on a MPC8266ADS board 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 09 Apr 2003 12:13:57 EST."
             <mnet1.1049883237.12439.greggiraud@netcourrier.com>
Date: Wed, 09 Apr 2003 12:26:29 +0200
Message-Id: <20030409102634.7ACFDC5877@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <mnet1.1049883237.12439.greggiraud@netcourrier.com> you wrote:
>
> I 've installed PPCBOOT1.2 (eldk2.0), it runs OK.
> Now I have generate a kernel Linux2.4.4, so I follow these steps:
> ->in the file /linux-2.4.4/include/asm-ppc/mpc8260ads/mpc8260ads.h

For  the  mpc8260ads  you  should  rather  usethe  kernel  from   the
linuxppc_2_4_devel tree.


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
365 Days of drinking Lo-Cal beer.                       = 1 Lite-year

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
