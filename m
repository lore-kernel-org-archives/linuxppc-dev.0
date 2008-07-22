Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4189FDDDE7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Jul 2008 02:57:51 +1000 (EST)
Message-ID: <48861161.8050707@freescale.com>
Date: Tue, 22 Jul 2008 11:57:05 -0500
From: Jon Loeliger <jdl@freescale.com>
MIME-Version: 1.0
To: joachim.bader@diehl-aerospace.de
Subject: Re: Help: Kernel BUG with U-boot 1.1.4 and kernel 2.6.23 scanning
	PCIe on	a MPC8641D board
References: <OFB15FD6AA.EA941C67-ONC125748E.00488CEE-C125748E.004A8A08@diehl-gruppe.de>
In-Reply-To: <OFB15FD6AA.EA941C67-ONC125748E.00488CEE-C125748E.004A8A08@diehl-gruppe.de>
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

joachim.bader@diehl-aerospace.de wrote:
> 
> Hello folks,
> 
> we run a proprietary board with Freescale MPC8641D using U-boot 1.1.4 
> and Linux kernel 2.6.23
> 

> I read in the logs some messages that 2.6.23 does contain some bugs 
> related to PCIe

Correct.

> and it would be a good choice to upgrade to 2.6.25. Is 
> this one of that cases?

Almost certainly.  You should pick up top of tree if you can.

> Currently we would like to prevent switching the kernel version.

You could back-port the PCIe bug fixes and rewrite if you wanted.
My guess is that a _trial_ run of the current top of tree,
or at least 2.6.26 might Just Work and fix your issues.

It would be less work to try it than do discover-n-back-port...

jdl
