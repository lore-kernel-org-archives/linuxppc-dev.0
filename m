Return-Path: <dhlii@dlasys.net>
Received: from sccrmhc12.comcast.net (sccrmhc12.comcast.net [63.240.77.82])
	by ozlabs.org (Postfix) with ESMTP id C4296679A6
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Aug 2006 16:35:12 +1000 (EST)
Message-ID: <44D1991A.2070208@dlasys.net>
Date: Thu, 03 Aug 2006 02:35:06 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Ameet Patil <ammubhai@gmail.com>,  edb@datadesigncorp.net,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Xilinx TEMAC
References: <44CE4C1D.6050103@datadesigncorp.net>
	<44CE5EA5.3030306@gmail.com>	<44CF89B5.7080906@datadesigncorp.net>
	<44D07B38.5060700@gmail.com>
In-Reply-To: <44D07B38.5060700@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Reply-To: dhlii@comcast.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Ameet Patil wrote:
>  > Did you happen to get an Ethernet mac going on the virtex2 or
>  > virtex4 with the 2.6 kernel?
>
> Nope! :-(
> Rumour has it that Montavista is soon going to release the source for 
> 2.6 kernel to run on Xilinx platforms.
>
>   
    I have 2 different TEMAC's working under 2.6 with a V4.

    The MontaVista driver that has been posted on the list that I think
is from MontaVista for the PLB TEMAC with very minor modifications to
get it to work at speeds other than GigaBit.

    A driver I wrote for the LocalLink TEMAC that works limpingly. I
have been unable to figure out how to get a receive interrupt from the
LocalLink TEMAC so receives are polled and performance is poor.
    I have pretty much abandoned work on it  - my client wants the
smallest possible FPGA footprint BUTanother OS I am porting requires
interrupt driven  IO and we are looking for a single minimal hardware
implimentation for all platforms.

    Anyway, if anyone wants the LL TEMAC in its current state I can post it.
    Currently it sends fine. It drops about 50% of all received packets
- but that is probably debugging overhead and poll rate tuning.
   




-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
