To: Dan Malek <dan@mvista.com>
Cc: Wolfgang Grandegger <wg@denx.de>,
	Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Multi-level CPM Interrupts 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 01 Nov 2001 13:16:01 EST."
             <3BE19161.8060402@mvista.com>
Date: Thu, 01 Nov 2001 19:28:38 +0100
Message-Id: <20011101182844.0C3BA11269@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3BE19161.8060402@mvista.com> you wrote:
>
> Well, I know that other people are running RTLinux without the same
> modification, so "easy" must be a relative :-).

Running RTAI or RTLinux is one thing, registering an interrupt for  -
say - a port C pin for a RT task is a different story.

> > We need this for RTAI, and I don't see any problems with it.
>
> The problem I have is that it is a reasonable argument for exactly
> the _one_ board you have.  We have tried to do what you are asking

What makes you think so? IMHO this is  a  generic  modification  that
will work on all 8xx CPUs and all boards based on 8xx CPUs.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Do not simplify the design of a program if a way can be found to make
it complex and wonderful.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
