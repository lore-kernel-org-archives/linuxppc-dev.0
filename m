To: "Stephan Linke" <Stephan.Linke@epygi.de>
Cc: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: problems running I2C and/or SPI on 857 board 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 25 Mar 2002 13:59:23 +0100."
             <FCEAKDJJAPHPLJFINDAJCEMMCDAA.Stephan.Linke@epygi.de>
Date: Mon, 25 Mar 2002 14:11:02 +0100
Message-Id: <20020325131107.8D3B6109F3@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <FCEAKDJJAPHPLJFINDAJCEMMCDAA.Stephan.Linke@epygi.de> you wrote:
>
> I'm trying to get I2C and/or SPI running on a 857 board. Register settings
> and BDs look good. But when the start command is issued nearly nothing
> happens as if there would be no clock.

I guess your implementation is basedon existing code? Which one?
[Hint: we have I2C running on a couple of systems...]

> Is there anyone who has an idea?

Start from some code that is known to work?

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The existence of god implies a violation of causality.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
