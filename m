To: "sruel@oerlikon.ca" <sruel@oerlikon.ca>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Trivial Interrupt Driver for MPC860 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 16 Jan 2002 12:10:05 EST."
             <3C45B3ED.5010302@oerlikon.ca>
Date: Wed, 16 Jan 2002 18:26:54 +0100
Message-Id: <20020116172659.1FC6010BC6@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3C45B3ED.5010302@oerlikon.ca> you wrote:
>
> I'm trying to compile the "tid" Trivial Interrupt Driver for MPC860, but
> there are errors in the compilation.
> I'm using Denx kernel  "linux-2.4.4-2001-11-24" with the RPX-CLLF (rev
> BW31) with the HardHard Linux CDK 1.2.

The TID example was developed for Linux 2.2.13; it will  not  compile
for a 2.4.x kernel without modification of the sources.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A door is what a dog is perpetually on the wrong side of.
                                                        - Ogden Nash

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
