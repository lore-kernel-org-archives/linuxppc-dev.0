To: greggiraud@netcourrier.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC8266ADS 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 26 Mar 2003 08:42:26 +0700."
             <mnet1.1048664546.22205.greggiraud@netcourrier.com>
Date: Wed, 26 Mar 2003 16:40:47 +0100
Message-Id: <20030326154052.4D658C58BA@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <mnet1.1048664546.22205.greggiraud@netcourrier.com> you wrote:
>
> I am using a MPC8266ADS card, and I want to put a PPCBOOT1.2.1 into it.

You should use U-Boot instead of PPCBoot for new projects.

> => The file board/mpc8260ads/mpc8260ads.c contain a function named
> intdram. In that file, we init a local sdram and the sdram on the 60x
> bus. We mustn't intilializase the local sdram.

Well, so comment out this part of the code.


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Fascinating, a totally parochial attitude.
	-- Spock, "Metamorphosis", stardate 3219.8

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
