Message-ID: <387FA3C6.18E1DB1A@jlc.net>
Date: Fri, 14 Jan 2000 17:31:34 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Grant Erickson <grant@lcse.umn.edu>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: *_find_end_of_memory Mach Dep?
References: <Pine.SGI.4.10.10001141448520.254646-100000@brule.borg.umn.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Grant Erickson wrote:
> 
> Instead of having a mess of ifdef's and such in MMU_init for {apus, pmac,
> m8xx, oak, chrp, etc}_find_end_of_memory, is there any compelling reason
> not to make a ppc_md machine dependency entry for these?

I didn't see a mess of ifdef's.....in fact a ppc_md entry wouldn't
change the ifdef's, it would just remove a couple of lines of code
in MMU_init().

I put the ifdef's there originally to remove lots of code from the 8xx
port that isn't needed.  Perhaps with your 40x stuff we should consider
a more modular MMU_init() instead of the ifdef's, like creating multiple
mm/xxx_init.c files for the different MMU configurations (I can't believe
I said this, as I hate multiple files like this :-).

> If no one is in disagreement, I'd like to put a patch together for it.

Let's see what it looks like........


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
