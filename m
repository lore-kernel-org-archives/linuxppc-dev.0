Return-Path: <mgalassi@c-cor.com>
Received: from penguin.ncube.com (penguin.ncube.com [134.242.67.78])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 733CF67A39
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Nov 2006 03:39:07 +1100 (EST)
Message-Id: <200611291638.kATGcb5a008093@penguin.ncube.com>
To: "Ming Liu" <eemingliu@hotmail.com>
From: Michael Galassi <mgalassi@c-cor.com>
Subject: Re: Some questions about the Xilinx Temac driver. 
In-reply-to: Your message of "Wed, 29 Nov 2006 14:33:37 GMT."
	<BAY110-F289C3474171EF7F5FA8CA8B2E40@phx.gbl>
Date: Wed, 29 Nov 2006 08:38:37 -0800
Sender: mgalassi@c-cor.com
Cc: akonovalov@ru.mvista.com, linuxppc-embedded@ozlabs.org
Reply-To: Michael Galassi <mgalassi@c-cor.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

If you use the latest xilinx ISE/EDK/IP update and let it overlay your
mvl source tree with it's files it shouldn't take you more than a few
hours to patch things up to where you can compile a kernel which will
work on the 3.00b IP.  The PHY support is useless but you can work
around that easily enough.  I've not tried to get any of that working
with a semi-current kernel so if you're not using mvl's flavor of 2.6.10
you may run into other issues.

-michael

>Dear Andrei,
>I have some questions about your xilinx Temac driver. If possible, please 
>give me a hand on such confusing problems. 
>
>1. I am using the driver from 
>http://source.mvista.com/~ank/paulus-powerpc/20060309/, and the IP cores of 
>plb_temac and hard_temac whose hardware versions are 2.00a and 1.00a 
>specifically. I know the newest versions of those hardwares are 3.00a and 
>3.00a. Is your driver support the 3.00a version hardware? Also, is the 
>driver from http://source.mvista.com/~ank/paulus-powerpc/20060309/ the 
>latest one for Xilinx Temac? If you have some updated version, please tell 
>me the address. 
>
>2. Is that driver from the above address able to support SGDMA? In fact, I 
>am testing the throughput of the Temac enet by my own little program which 
>is very simple. In the program running on the board, the pseudo code looks 
>just like this:
>     for(;;){
>           select();
>           if(FD_ISSET()){
>                 recvfrom();
>           }
>           
>           sendto();
>     }
>
>The program is just to receive packets from a pc and then transfer them 
>back. But in this condition, the embedded PowerPC CPU is easily used by 
>100&. So I suspect that maybe the DMA is not running properly. Could you 
>please say something about the DMA in your driver? 
>
>Thanks a lot for your telling.
>
>Regards
>Ming
>
>_________________________________________________________________
>Ãâ·ÑÏÂÔØ MSN Explorer:   http://explorer.msn.com/lccn/  
>
>
>--===============1695844909==
>Content-Type: text/plain; charset="us-ascii"
>MIME-Version: 1.0
>Content-Transfer-Encoding: 7bit
>Content-Disposition: inline
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>--===============1695844909==--
