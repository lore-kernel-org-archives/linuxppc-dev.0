To: "Walser, Martin" <mwalser@harris.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: enet rx doesn't work 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 12 Mar 2002 10:42:22 EST."
             <8D4C69676E66D511A1CB00508BBBB1921BCF0C@ranmx1.ran.harris.com>
Date: Tue, 12 Mar 2002 17:35:43 +0100
Message-Id: <20020312163548.2EDEE10BF3@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <8D4C69676E66D511A1CB00508BBBB1921BCF0C@ranmx1.ran.harris.com> you wrote:
>
> I've tried to use the enet over the LXT905. Tx seems to work, but I'm not able
> to receive data from it.
> I've measured the rxd, rclk and rena pins (the RENA signal is aktive high), but
> they seems to be ok too.
>
> But I get no rx interrupt, the scc_enet_interrupt is never called when receiving
> data.

Checked the pin configuration and the clock routing?

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
There's another way to survive.  Mutual trust -- and help.
	-- Kirk, "Day of the Dove", stardate unknown

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
