To: Gerhard Jaeger <g.jaeger@sysgo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC5200Lite and PCI issues... 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 27 Feb 2004 09:35:06 +0100."
             <200402270935.06816.g.jaeger@sysgo.com>
Date: Fri, 27 Feb 2004 09:56:54 +0100
Message-Id: <20040227085659.B2B2CC0655@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200402270935.06816.g.jaeger@sysgo.com> you wrote:
>
> while playing around with a Lite5200 eval-board, I noticed that
> there seems to be some problems with the PCI bus. Some cards
> are detected without any problems and also can be accessed
> some cards not. Apart for the 5V/3.3V issues, I think there are
> some problems with this board.
> Are there any experiences? Explanations? Solutions, or workarounds?

Remember that there is just one PCI interrupt on the LITE5200;  cards
that require another one will not work.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Every time history repeats itself the price goes up.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
