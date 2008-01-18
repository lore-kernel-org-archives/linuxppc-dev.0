Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 70651DDE9E
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Jan 2008 09:48:36 +1100 (EST)
Message-ID: <47912CDA.9020603@freescale.com>
Date: Fri, 18 Jan 2008 16:48:58 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: DI BACCO ANTONIO - technolabs <Antonio.DiBacco@technolabs.it>
Subject: Re: ping 127.0.0.1 takes too much
References: <F1F6EC0C8B75034F9E3A79FC85122E8E264A1A@aquib01a>
In-Reply-To: <F1F6EC0C8B75034F9E3A79FC85122E8E264A1A@aquib01a>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

DI BACCO ANTONIO - technolabs wrote:
> I have two different boards: one with MPC875 running at 66 MHz cpu/66 
> MHz bus, one with MPC880 running at 132 MHz cpu /66MHz bus, I load the 
> same kernel and root file system on both the boards that have only 
> different u-boot(s).
> 
> If I do a ping 127.0.0.1 on the MPC875 I get a round trip of 0.300 ms, 
> while on the other one I get 0.900 ms, I expected the opposite.
> 
> Could be an issue with memory configuration? In the formula to calculate 
> the PTx on the MPC885RM manual I used 66 MHz as "system clock" for the 
> first board and 132 MHz for the second board. Probably this is a mistake 
> because "system clock" should be the bus clock but how this can so 
> adversely affect the ping round trip?

Are you sure the timebase clock is what the kernel thinks it is?  Does 
the time-of-day clock progress at the correct rate?

-Scott
