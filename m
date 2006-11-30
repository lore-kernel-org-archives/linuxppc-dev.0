Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc1-s9.bay0.hotmail.com (bay0-omc1-s9.bay0.hotmail.com
	[65.54.246.81]) by ozlabs.org (Postfix) with ESMTP id AD3CA67B6D
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Dec 2006 03:37:27 +1100 (EST)
Message-ID: <BAY110-F40D23F776DA18A9693D6EBB2DB0@phx.gbl>
In-Reply-To: <200611291638.kATGcb5a008093@penguin.ncube.com>
From: "Ming Liu" <eemingliu@hotmail.com>
To: mgalassi@c-cor.com
Subject: Re: Some questions about the Xilinx Temac driver.
Date: Thu, 30 Nov 2006 16:37:23 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Michael,
Now I update my Xilinx design software from 8.1 to 8.2 and notice that 
there is already linux_2_6 support. Then I generated the BSP for linux 2.6. 
I found that there are some differences from the older version, e.g. there 
are some files such as XMakefile, xps_connected.cud, etc. I am confused 
with this. So could you please give me a hand on how to use such a 
generated BSP to build my linux 2.6 kernel? I cannot find any guidance on 
how to do that. Thanks for your help. 

BR
Ming


>From: Michael Galassi <mgalassi@c-cor.com>
>Reply-To: Michael Galassi <mgalassi@c-cor.com>
>To: "Ming Liu" <eemingliu@hotmail.com>
>CC: akonovalov@ru.mvista.com, linuxppc-embedded@ozlabs.org
>Subject: Re: Some questions about the Xilinx Temac driver. 
>Date: Wed, 29 Nov 2006 08:38:37 -0800
>
>If you use the latest xilinx ISE/EDK/IP update and let it overlay your
>mvl source tree with it's files it shouldn't take you more than a few
>hours to patch things up to where you can compile a kernel which will
>work on the 3.00b IP.  The PHY support is useless but you can work
>around that easily enough.  I've not tried to get any of that working
>with a semi-current kernel so if you're not using mvl's flavor of 2.6.10
>you may run into other issues.
>
>-michael
>
> >Dear Andrei,
> >I have some questions about your xilinx Temac driver. If possible, 
please
> >give me a hand on such confusing problems.
> >
> >1. I am using the driver from
> >http://source.mvista.com/~ank/paulus-powerpc/20060309/, and the IP cores 
of
> >plb_temac and hard_temac whose hardware versions are 2.00a and 1.00a
> >specifically. I know the newest versions of those hardwares are 3.00a 
and
> >3.00a. Is your driver support the 3.00a version hardware? Also, is the
> >driver from http://source.mvista.com/~ank/paulus-powerpc/20060309/ the
> >latest one for Xilinx Temac? If you have some updated version, please 
tell
> >me the address.
> >
> >2. Is that driver from the above address able to support SGDMA? In fact, 
I
> >am testing the throughput of the Temac enet by my own little program 
which
> >is very simple. In the program running on the board, the pseudo code 
looks
> >just like this:
> >     for(;;){
> >           select();
> >           if(FD_ISSET()){
> >                 recvfrom();
> >           }
> >
> >           sendto();
> >     }
> >
> >The program is just to receive packets from a pc and then transfer them
> >back. But in this condition, the embedded PowerPC CPU is easily used by
> >100&. So I suspect that maybe the DMA is not running properly. Could you
> >please say something about the DMA in your driver?
> >
> >Thanks a lot for your telling.
> >
> >Regards
> >Ming
> >
> >_________________________________________________________________
> >免费下载 MSN Explorer:   http://explorer.msn.com/lccn/
> >
> >
> >--===============1695844909==
> >Content-Type: text/plain; charset="us-ascii"
> >MIME-Version: 1.0
> >Content-Transfer-Encoding: 7bit
> >Content-Disposition: inline
> >
> >_______________________________________________
> >Linuxppc-embedded mailing list
> >Linuxppc-embedded@ozlabs.org
> >https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >--===============1695844909==--

_________________________________________________________________
与联机的朋友进行交流，请使用 MSN Messenger:  http://messenger.msn.com/cn  
