Message-ID: <37E19DCC.6D01FD8A@netx4.com>
Date: Thu, 16 Sep 1999 21:47:56 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Graham Stoney <greyham@research.canon.com.au>
CC: Dan Malek <dan@penguin.netx4.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: mpc8xx-2.3.10 configuration questions.
References: <19990917004810.870CB730@elph.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Graham Stoney wrote:


> > I pretty sure I got it right in the 2.3.18 kernel.
> 
> I'm using the linux-2.3.18 snapshot kernel from the ftp site, which has it
> wrong I'm afraid.

Damn it!  I forgot to check it in and I don't have the new version
here at home with me.  I'll fix this and add the Ericsson updates,
make sure it works on the Classic and CLLF.


> I've reconfigured/recompiled my kernel for the Classic, but it sounds like it
> won't Just Work(tm).

The Classic should work, I just never finished all of the FEC
when I got stalled on the CLLF.  If anyone has a Classic, there is
a zero ohm resistor that must be installed to get the MII interrupt
to Port C.  I'll document this, too.


> ...I'm happy to alpha test any mods you're working on;


Oh, you will :-).



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
