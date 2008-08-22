Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8020ADF6B9
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Aug 2008 06:18:55 +1000 (EST)
Message-ID: <48AF1F03.8030409@freescale.com>
Date: Fri, 22 Aug 2008 15:18:11 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Laxmikant Rashinkar <lk.atwork@yahoo.com>
Subject: Re: porting linux 2.6.27 to embedded powerpc board
References: <484406.39935.qm@web46302.mail.sp1.yahoo.com>
In-Reply-To: <484406.39935.qm@web46302.mail.sp1.yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Laxmikant Rashinkar wrote:
> When I attempt to boot my image it just hangs w/o any output. I dearly 
> wish I could get some console output.

Make sure you have /chosen/linux,stdout-path in your device tree.  For 
output from the kernel itself, make sure the serial clock-frequency is 
correct.

> 1) the load address and entry point for the kernel (see above) are 
> non-zero. When we load via uImage, they are always zero. Is this normal? 

Yes, it's normal.

> 2) When I build my kernel, I get two warnings. Could these be causing a 
> problem?

Probably not.

-Scott
