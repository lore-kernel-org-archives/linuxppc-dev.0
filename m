From: kd@flaga.is
Subject: Re: Kernel 2.2.13 network problems
To: Dan Malek <dan@netx4.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OF473DC304.3647F6EE-ON0025683C.005F32A9@flaga.is>
Date: Fri, 3 Dec 1999 17:25:22 +0000
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



It is a custom board.
So I might have fucked up the configuration of the ethernet and serial
ports when going from kernel 2.2.5 to kernel 2.2.13. Actually it is likely.
8-)  I never seem to get those kind of information accross files correctly.
8-) Besides the configureation of the ethernetport is partly automated (in
make config) so I definitly did something wrong in enet.c.
Actually it is so obvious that I don't know why I was bothering the list
with this.

Sorry about the noise.

K.D.



                                                                                                                                 
                    Dan Malek                                                                                                    
                    <dan@netx4.co        To:     kd@flaga.is                                                                     
                    m>                   cc:     linuxppc-embedded@lists.linuxppc.org                                            
                    Sent by:             Subject:     Re: Kernel 2.2.13 network problems                                         
                    dan@netx4.com                                                                                                
                                                                                                                                 
                                                                                                                                 
                    12/03/99                                                                                                     
                    04:48 PM                                                                                                     
                                                                                                                                 
                                                                                                                                 




kd@flaga.is wrote:
>
> No, I am using Debian 2.1 i386 with upgraded Glibc to 2.1 as nfs server.
> The problems are only visible with kernel 2.2.13 in the mpc823 board.


Is this a standard board from someone that I may have in my
office, or is this something custom?


     -- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
