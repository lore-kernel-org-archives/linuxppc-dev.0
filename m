Message-ID: <380DCAF0.75A58DB1@switchboard.ericsson.se>
Date: Wed, 20 Oct 1999 16:00:16 +0200
From: Magnus Damm <damm@kieraypc01.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
CC: Jim Lewis <jlewis@mvista.com>
Subject: Re: PCMCIA use
References: <380DCA0D.B272F889@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



> Hello,
> 
> Has anyone out there done anything with PCMCIA on the 8xx?

Have a look at the IDE code. (8xx specific part)!
And check out the fadsrom code.

I tried to do some CIS parsing code a while ago, but I ended
up with some cards working, some not. 

Maybe we should use the pcmcia-cs package and modify it?
 
Good luck! 

/ magnus

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
