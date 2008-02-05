Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3FF93DDF37
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Feb 2008 05:21:17 +1100 (EST)
Message-ID: <47A899EC.1000003@freescale.com>
Date: Tue, 05 Feb 2008 11:16:28 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Marco Stornelli <marco.stornelli@coritel.it>
Subject: Re: Kernel entry point
References: <47A88A73.5030101@coritel.it>
In-Reply-To: <47A88A73.5030101@coritel.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: LinuxPPC-Embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Marco Stornelli wrote:
> where is the main kernel entry point (the first function/instruction)
> for the powerpc arch called by uboot? In kernel 2.6.10 there was the
> head_fsl_booke.S (I'm using a booke processor) that it called the
> start_kernel function, and now?

It's the same.

-Scott
