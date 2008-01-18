Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 042B0DDE3E
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Jan 2008 10:16:53 +1100 (EST)
Message-ID: <47913371.3040908@freescale.com>
Date: Fri, 18 Jan 2008 17:17:05 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: DI BACCO ANTONIO - technolabs <Antonio.DiBacco@technolabs.it>
Subject: Re: ping 127.0.0.1 takes too much
References: <F1F6EC0C8B75034F9E3A79FC85122E8E264A1A@aquib01a>
	<47912CDA.9020603@freescale.com>
	<F1F6EC0C8B75034F9E3A79FC85122E8E264A1B@aquib01a>
In-Reply-To: <F1F6EC0C8B75034F9E3A79FC85122E8E264A1B@aquib01a>
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
> 
>  >Are you sure the timebase clock is what the kernel thinks it is?  Does
>  >the time-of-day clock progress at the correct rate?
> 
> The kernel receives the CPU clock from the bdinfo structure and thus I 
> think the kernel knows how fast the CPU is.

That wasn't what I asked.  I asked whether you checked whether it was 
actually correct or not.  I've seen it be wrong quite often.

-Scott
