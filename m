Message-Id: <199912031016.LAA29598@denx.local.net>
To: kd@flaga.is
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel 2.2.13 network problems 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 03 Dec 1999 10:04:06 GMT."
             <OF09A0544A.557A1BF7-ON0025683C.00368333@flaga.is>
Date: Fri, 03 Dec 1999 11:16:19 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <OF09A0544A.557A1BF7-ON0025683C.00368333@flaga.is> you write:
> 
> I just recently compiled the 2.2.13 kernel for our custom mpc823 board.
> Everything seem to work except that the network is really slow and
> frequently there are nfs timeouts, e.g.
> 
> nfs server x.x.x.x not responding
> nfs server x.x.x.x o.k.
> 
> Has anyone had similar experience and/or solution?

I *bet* your NFS server is on a PowerPC system running LinuxPPC.

I have the very same problem here with all kinds of embedded 8xx
systems (823, 850, 860) and all different kernel versions.

Move the NFS server to another  system,  for  instance  an  Intel  PC
running Linux, and you'll be perfectly fine.

I have no idea *why* this is happening...

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Bus error -- please leave by the rear door.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
