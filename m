Return-Path: <martyn.welch@gefanuc.com>
Received: from ext-nj2ut-4.online-age.net (ext-nj2ut-4.online-age.net
	[64.14.54.233])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-nj2ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 2ED4A474C3
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 21:15:23 +1100 (EST)
Received: from int-nj2ut-7.online-age.net (int-nj2ut-7.online-age.net
	[3.159.237.76])
	by ext-nj2ut-4.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id n08A6P5c002580
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Jan 2009 05:06:25 -0500
Received: from cinmlip01.e2k.ad.ge.com (int-nj2ut-7.online-age.net
	[3.159.237.76])
	by int-nj2ut-7.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id n08A6P2h028448
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Jan 2009 05:06:25 -0500
Message-ID: <4965D021.30702@gefanuc.com>
Date: Thu, 08 Jan 2009 10:06:25 +0000
From: Martyn Welch <martyn.welch@gefanuc.com>
MIME-Version: 1.0
To: Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH 1/2] watchdog: Basic support for GE Fanuc's FPGA based
	watchdog timer
References: <20081110123101.8608.352.stgit@ubuntu8041.localdomain>
	<20081110123125.8608.2251.stgit@ubuntu8041.localdomain>
	<A23D61BC-CA79-490C-8C70-F4341E7844EA@kernel.crashing.org>
	<20090107214834.GF11454@infomag.infomag.iguana.be>
In-Reply-To: <20090107214834.GF11454@infomag.infomag.iguana.be>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wim Van Sebroeck wrote:
> Hi All,
> 
>> Any status of acceptance of this?
> 
> I changed the ioctl to an unlocked ioctl and removed the temperature ioctl call.
> It's now in my linux-2.6-watchdog-next tree. Can someone verify that it still works?
> (http://git.kernel.org/?p=linux/kernel/git/wim/linux-2.6-watchdog-next.git;a=summary)
> 

Hi Wim,

Thank you for reviewing these patches. I have made the changes you have on my dev tree and, whilst I don't have an SBC610 to hand, I have checked the driver on a similar board which also uses the same watchdog and it's still working as expected.

Martyn

-- 
Martyn Welch MEng MPhil MIET (Principal Software Engineer)   T:+44(0)1327322748
GE Fanuc Intelligent Platforms Ltd,        |Registered in England and Wales
Tove Valley Business Park, Towcester,      |(3828642) at 100 Barbirolli Square,
Northants, NN12 6PF, UK T:+44(0)1327359444 |Manchester,M2 3AB  VAT:GB 729849476
