Message-ID: <37ED04AD.B09AA95@arcormail.de>
Date: Sat, 25 Sep 1999 18:21:51 +0100
From: Michael Fenske <michael.fenske@arcormail.de>
Reply-To: michael.fenske@arcormail.de
MIME-Version: 1.0
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: [patch] Paul's rsync kernel compile fix
References: <19990924222214.A7489@io.nu> <37EC952C.9285EA6C@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Martin Costabel wrote:
> 
> I think you are:
> - these variables are used by any number of drivers
> - they are declared in <asm/dma.h>
> 
> Maybe you should rsync again?

I rsync'd today. Nevertheless I get warnings various variables are
declared but not defined or defined but not used. I think (hope) this is
because I selected only the necessary drivers for my Wallstreet PB to
compile into the kernel.

Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
