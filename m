Date: Sat, 25 Sep 1999 11:48:27 -0500
From: Shaw Terwilliger <sterwill@io.nu>
To: Martin Costabel <costabel@wanadoo.fr>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [patch] Paul's rsync kernel compile fix
Message-ID: <19990925114827.B8312@io.nu>
References: <19990924222214.A7489@io.nu> <37EC952C.9285EA6C@wanadoo.fr> <19990925110256.A8137@io.nu> <37ECF9A9.10B58B88@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <37ECF9A9.10B58B88@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Martin Costabel wrote:
> Oh, I see. We are indeed not talking about the same thing. I have the
> development tree (2.3.18), and there arch/ppc/kernel/pmac_setup.c does
> include <asm/dma.h>. 
> What if you just plug a "#include <asm/dma.h>" in there? But then I
> don't know whether the declarations in question are there in this
> version.

Yep, dma.h holds the declarations, and sticking it in pmac_setup.c
corrects my problems.  I thought there must have been a much more
complicated solution because I couldn't imagine I was the only one
seeing this error.  :)

> BTW, Paul's 2.3.18 compiles cleanly (and boots, in contrast to the
> 2.3.18 version from the cvs tree at openprojects), at least if HFS
> support is switched off.

I've got 2.2.12 working very nicely with my Lombard, and generally
I'm aware of the differences between stable/dev kernels, but is
there anything really cool in 2.3.18 for the PPC (from Paul's
archive) that might lead me to switch to it?

-- 
Shaw Terwilliger (sterwill@io.nu)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
