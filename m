To: Gerhard Jaeger <g.jaeger@sysgo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC5200Lite and PCI issues... 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 01 Mar 2004 09:20:12 +0100."
             <200403010920.12424.g.jaeger@sysgo.com>
Date: Mon, 01 Mar 2004 10:12:59 +0100
Message-Id: <20040301091304.6AF90C0655@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200403010920.12424.g.jaeger@sysgo.com> you wrote:
>
> Ah I see, thanks for this hint. My major problem seems, that some PCI
> cards esp. grafic adapter simply did not appear in the PCI list of i.e.
> u-boot. The cards work fine in a EBONY EVA board.

Are these really 3.3V cards? (sorry, I don't  know  the  ebony  board
that well)

> Are there any known problems with PCI timings or is the power supply
> the problem?

There is a known issue with SDRAM  timings  which  probably  explains
most  of  the  problems  people  experience,  but I don't think it is
related to your PCI troubles.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"More software projects have gone awry for lack of calendar time than
for all other causes combined."
                         - Fred Brooks, Jr., _The Mythical Man Month_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
