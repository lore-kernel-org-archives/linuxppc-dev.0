Date: Sat, 25 Sep 1999 11:44:42 -0500
From: Shaw Terwilliger <sterwill@io.nu>
To: Michael Fenske <michael.fenske@arcormail.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [patch] Paul's rsync kernel compile fix
Message-ID: <19990925114442.A8312@io.nu>
References: <19990924222214.A7489@io.nu> <37EC952C.9285EA6C@wanadoo.fr> <37ED04AD.B09AA95@arcormail.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <37ED04AD.B09AA95@arcormail.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Fenske wrote:
> I rsync'd today. Nevertheless I get warnings various variables are
> declared but not defined or defined but not used. I think (hope) this is
> because I selected only the necessary drivers for my Wallstreet PB to
> compile into the kernel.

The patch I keep around actually fixes errors in my compile.  Without
it, pmac_setup.c is referencing variables that aren't defined
anywhere in its scope.  The variables are declared in asm/dma.h, 
which isn't included.  I just can't compile a kernel without a fix.  :)


-- 
Shaw Terwilliger (sterwill@io.nu)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
