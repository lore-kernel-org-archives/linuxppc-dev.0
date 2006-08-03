Return-Path: <lombardo@mdivac.com>
Received: from mail.mdivac.com (adsl-68-253-104-89.dsl.bcvloh.ameritech.net
	[68.253.104.89]) by ozlabs.org (Postfix) with ESMTP id 343CD67BDC
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Aug 2006 04:53:58 +1000 (EST)
Message-ID: <44D24643.1090208@mdivac.com>
Date: Thu, 03 Aug 2006 14:53:55 -0400
From: Frank D Lombardo <lombardo@mdivac.com>
MIME-Version: 1.0
To: dhlii@comcast.net
Subject: Re: Xilinx TEMAC
References: <44CE4C1D.6050103@datadesigncorp.net>	<44CE5EA5.3030306@gmail.com>	<44CF89B5.7080906@datadesigncorp.net>	<44D07B38.5060700@gmail.com>
	<44D1991A.2070208@dlasys.net>
In-Reply-To: <44D1991A.2070208@dlasys.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

David H. Lynch Jr. wrote:
> Ameet Patil wrote:
>   
>>  > Did you happen to get an Ethernet mac going on the virtex2 or
>>  > virtex4 with the 2.6 kernel?
>>
>> Nope! :-(
>> Rumour has it that Montavista is soon going to release the source for 
>> 2.6 kernel to run on Xilinx platforms.
>>
>>   
>>     
>     I have 2 different TEMAC's working under 2.6 with a V4.
>
>     The MontaVista driver that has been posted on the list that I think
> is from MontaVista for the PLB TEMAC with very minor modifications to
> get it to work at speeds other than GigaBit.
>
>     A driver I wrote for the LocalLink TEMAC that works limpingly. I
> have been unable to figure out how to get a receive interrupt from the
> LocalLink TEMAC so receives are polled and performance is poor.
>     I have pretty much abandoned work on it  - my client wants the
> smallest possible FPGA footprint BUTanother OS I am porting requires
> interrupt driven  IO and we are looking for a single minimal hardware
> implimentation for all platforms.
>
>     Anyway, if anyone wants the LL TEMAC in its current state I can post it.
>     Currently it sends fine. It drops about 50% of all received packets
> - but that is probably debugging overhead and poll rate tuning.
>    
>
>
>
>
>   
I would be interested looking at the LL TEMAC patch. Hopefully I can 
pick up where you left off. We would require an interrupt driven TEMAC
