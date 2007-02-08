Return-Path: <christophe.alayrac@cresitt.com>
Received: from min.univ-orleans.fr (min.univ-orleans.fr [193.49.83.6])
	by ozlabs.org (Postfix) with ESMTP id 4F7B6DDE3F
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Feb 2007 18:16:47 +1100 (EST)
Subject: Re: ML403 Hard TEMAC, PLB and Linux 2.6
From: alayrac <christophe.alayrac@cresitt.com>
To: Mohammad Sadegh Sadri <mamsadegh@hotmail.com>
In-Reply-To: <BAY115-W1CC92C2510304D9E26E06B29E0@phx.gbl>
References: <BAY115-W1CC92C2510304D9E26E06B29E0@phx.gbl>
Content-Type: text/plain; charset=utf-8
Date: Thu, 08 Feb 2007 06:51:45 +0100
Message-Id: <1170913906.4850.7.camel@Serge-Linux>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Reply-To: christophe.alayrac@cresitt.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Le mercredi 07 février 2007 à 22:30 +0000, Mohammad Sadegh Sadri a
écrit :
Hi Mohammad,

Please find here after some answer

> 1- I want to use, ML403, Hard TEMAC and PLB TEMAC cores. Is there any ready to use design, or any reference design available for this?
> I'm using EDK 8.1 and I understood that, when I choose the ML403 board , EDK does not use hard temac, so , should I add it manually? ( well this is funny, but the wizard does not use hard temac , is it true? )
> Is there any ready EDK projects for ML403, with TEMAC and PLB TEMAC modules already inserted and cofigured? (I don't want to use GSRD ) ( If yes would you please put the link here )
> 
You can start from XAPP 902 from Xilinx, this design demonstrate TEMAC
use in loopback mode. Some memers from that community have tried from
that design as a starting point. I did not nknow if the succeed.
I would recommand to get EDK 8.2 SP2 and use the Wizard to build a new
design with TEMAC.

> 2- Simply, Is there any driver available for linux 2.6 , for PLB TEMAC and Hard TEMAC modules? If yes , can you put the link here, so that I can download it?
> 
For the kernel you can get it from Montavista source code site using GIT
to download it (linux-xilinx-26). This is 2.6.17.4 version (last week!)

Then you will need to pacth the Kernel with TEMAC drivers (look for
TEMAC PAULUS MVISTA with google, or follow my messages in that mailing
list)
NOTE: If you use that TEMAC patch do not use SGDMA on your TEMAC, use
FIFO.

> thanks
Regards

Chris
> _________________________________________________________________
> Personalize your Live.com homepage with the news, weather, and photos you care about.
> http://www.live.com/getstarted.aspx?icid=T001MSN30A0701
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
