Message-ID: <3DD11A09.B58EDAE0@imc-berlin.de>
Date: Tue, 12 Nov 2002 16:11:05 +0100
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Stephan Linke <Stephan.Linke@epygi.de>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Using ioctl from with the kernel ???
References: <FCEAKDJJAPHPLJFINDAJCEACCLAA.Stephan.Linke@epygi.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Stephan,

> Your right IOCTL is not applicable for this. You can simply call the driver
> functions directly. If these functions are called different from different
> context(s) (like your driver and the IOCTL function) you have to add some
> protection mechanism. (The code is not reentrant right?) You may try
> spin_lock() for this job (linux/spinlock.h). If you are calling the
> functions from interrupt contect too some extra protection is required...

Thanks for your reply.

But how could I call the ioctl handler of the driver?
I would need some (dummy) inode...

Steven

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
