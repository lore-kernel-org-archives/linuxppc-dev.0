To: joakim.tjernlund@lumentis.se
Cc: "Michael Meriin" <Michael@KSWaves.com>,
	"linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: SPI Driver for 8xx 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 11 Sep 2002 12:26:20 +0200."
             <IGEFJKJNHJDCBKALBJLLAEFNFGAA.joakim.tjernlund@lumentis.se>
Date: Wed, 11 Sep 2002 12:50:33 +0200
Message-Id: <20020911105038.2375DFA8B@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Jocke,

in message <IGEFJKJNHJDCBKALBJLLAEFNFGAA.joakim.tjernlund@lumentis.se> you wrote:
> Great, I too need a SPI driver for mpc8xx.

:-)

> I took a quick look at the cpm_spi.* driver and looks fine to me, but I have a question:
> The driver turns off interrupts during transmission. The comment in the file
> says: ... we may need to call it from interrupt handlers.
>
> I can not see any call from a interrupt handler in this code. Where is the call(s) from/to
> interrupt handlers? Or is this just a future extension?

We use the SPI communication inside another device  driver  (for  CAN
bus).  It is this other driver that will call the SPI I/O function in
it's interrupt handler.

> I would like to keep the interrupts on, if possible.

Feel free to modify the driver according to your needs. It should not
be a problem except for special cases like ours.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"If the code and  the  comments  disagree,  then  both  are  probably
wrong."                                                - Norm Schryer

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
