From: Nathan Sheeley <nsheeley@ibmoto.com>
Message-Id: <199906231408.JAA16450@shippy.ibmoto.com>
Subject: Re: bug in head.S
To: Paul.Mackerras@cs.anu.edu.au
Date: Wed, 23 Jun 1999 09:08:54 -0500 (CDT)
Cc: nsheeley@ibmoto.com, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <199906230045.KAA02613@tango.anu.edu.au> from "Paul Mackerras" at Jun 23, 99 10:45:22 am
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



> > Has anyone tried to build/run a pmac SMP kernel with a recent (2.2.9)
> > version of Linux?  
> 
> I have 2.2.10 running on my 2-cpu powermac at home (it's a 7500 with a
> 2 x 604e 200MHz cpu card in it).  It mostly runs fine but has frozen
> up on me a couple of times - I haven't tracked down why/where yet.

I pulled the MP card from the 9500, and installed it in an 8500;
where it works fine w/2.2.0.  The 9500 (even with a single CPU) 
still appears to hang just after opening the display.  Perhaps
a problem w/ the mach64 driver that only affects older versions
of the card?

Nate

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
