From: kd@flaga.is
Subject: Re: Kernel 2.2.13 network problems
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OF7F381384.4DD53729-ON0025683C.0039B947@flaga.is>
Date: Fri, 3 Dec 1999 10:31:05 +0000
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


No, I am using Debian 2.1 i386 with upgraded Glibc to 2.1 as nfs server.
The problems are only visible with kernel 2.2.13 in the mpc823 board. If I
am using kernel 2.2.5 everything works fine.

K.D.

"Software is like sex- the best is for free"
-Linus Torvalds



                                                                                                                                                    
                    Wolfgang Denk <wd@denx.de>                                                                                                      
                    Sent by:                                To:     kd@flaga.is                                                                     
                    owner-linuxppc-embedded@lists.li        cc:     linuxppc-embedded@lists.linuxppc.org                                            
                    nuxppc.org                              Subject:     Re: Kernel 2.2.13 network problems                                         
                                                                                                                                                    
                                                                                                                                                    
                    12/03/99 10:16 AM                                                                                                               
                                                                                                                                                    
                                                                                                                                                    





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
