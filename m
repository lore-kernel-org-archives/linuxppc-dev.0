Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6655CDDE19
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Jan 2009 05:03:36 +1100 (EST)
Message-ID: <4970CBA9.60809@freescale.com>
Date: Fri, 16 Jan 2009 12:02:17 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jean-Michel Hautbois <jhautbois@gmail.com>
Subject: Re: [MPC8272ADS]Cannot start my Linux Kernel
References: <8cad0aa0901150342s2362e53bqf9472c1dc239636c@mail.gmail.com>	
	<496F318D.6010302@denx.de>	
	<8cad0aa0901150510o7a8146f1m2045e252c5e1cf24@mail.gmail.com>	
	<496F4760.1010007@denx.de>	
	<8cad0aa0901150706u72538941rbc22655d5a8905ea@mail.gmail.com>	
	<8cad0aa0901160406l3db9c025ubdcac40b4b464d23@mail.gmail.com>	
	<20090116172903.GA722@ld0162-tx32.am.freescale.net>	
	<8cad0aa0901160944l48bd0e99wa13f23907838376d@mail.gmail.com>
	<8cad0aa0901160953te6c7d1cg3a4df7de7da7d182@mail.gmail.com>
In-Reply-To: <8cad0aa0901160953te6c7d1cg3a4df7de7da7d182@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jean-Michel Hautbois wrote:
> OK, I just tried a make of my kernel (already compiled yesterday), and
> it generated a cuImage.mpc8272ads kernel image (which it didn't do
> yesterday).
> I don't know why this image was generated, but I tried to reboot using this one.

Use uImage if you are providing a device tree from u-boot.  cuImage is 
for older u-boots that don't support this, though you could still try 
using it on a modern u-boot with a one- or two-argument bootm command to 
try to isolate the problem.

-Scott
