To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: HHL setserial and MPC8xx SCC/SMC 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 08 Mar 2002 15:31:25 +0100."
             <3C88CB3D.4752A3E1@imc-berlin.de>
Date: Fri, 08 Mar 2002 17:00:23 +0100
Message-Id: <20020308160028.930BF109EF@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3C88CB3D.4752A3E1@imc-berlin.de> you wrote:
>
> i tried to use setserial (version 2.17, 27-Jan-2000) that comes with HHL
> 2.0 on my custom board (MPC855T).

I think setserial is pretty much specific to "PC" type hardware.
It has not even a minimal understanding of MPC8xx systems.

> PS: Actually I was just looking for an easy way to test my serial
> ports...

Run some data through them ;-)

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Concept, n.:    Any "idea" for which an outside consultant billed you
more than $25,000.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
