Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EF60FDDE46
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Mar 2008 09:58:21 +1100 (EST)
Message-ID: <47C88E25.2050306@freescale.com>
Date: Fri, 29 Feb 2008 16:58:45 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Steve Heflin <sheflin@newagemicro.com>
Subject: Re: Sequoia build with KDBG
References: <20080221213313.97814DDF55@ozlabs.org>	<20080222164210.48628DE0A9@ozlabs.org>	<20080222145224.7349cf36@weaponx>	<200802292133.m1TLXqv3012273@e36.co.us.ibm.com>	<20080229153534.684aebf9@zod.rchland.ibm.com>
	<20080229223046.1B332DDE0A@ozlabs.org>
In-Reply-To: <20080229223046.1B332DDE0A@ozlabs.org>
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

Steve Heflin wrote:
> I assumed that because I've always needed a debugger when 
> implementing kernel level components. Since you've implemented kernel 
> level support for several 44x processors, I just assumed that you 
> needed kdbg at some point. So you're saying that your additions 
> worked right out of the gate and you never needed a debugger?  You're my hero!

There are ways of debugging that don't involve a debugger.

-Scott
