To: Dan Malek <dan@embeddededge.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel Mode Software Emulation NIP: 00001FFC - cache coherency problem on m8xx processors 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 26 Mar 2004 01:51:44 EST."
             <4063D300.2060006@embeddededge.com>
Date: Fri, 26 Mar 2004 10:04:16 +0100
Message-Id: <20040326090421.B103EC118A@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <4063D300.2060006@embeddededge.com> Dan Malek wrote:
>
> Let's put a big comment around this. Indicate it was a problem for one
> person with an 855T. I don't have any 855T parts, if anyone else has
> some and can do some heavy network testing, I'd appreciate knowing the

Can you define which sort of network load is suitable to  sfficiently
stress  the  system? We ave many kinds of systems of all types in the
lab, and I can easily run such a test.

But I actually doubt that we would see any  problem,  as  we  perform
such  testing  on  a regular base, and never had any such problems on
8xx systems.

> results. Like I keep saying, I've seen similar problems on the 860T
> parts, but it was clearly my fault programming the UPM. Once that was
> fixed, problem solved.

I agree 100%.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Quantum Mechanics is God's version of "Trust me."

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
