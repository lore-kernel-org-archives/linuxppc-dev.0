Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D605BDDFEA
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 May 2007 02:24:21 +1000 (EST)
Subject: Re: [U-Boot-Users] Where do you find *.dtb files?
From: Jon Loeliger <jdl@freescale.com>
To: Alex Zeffertt <ajz@cambridgebroadband.com>
In-Reply-To: <4639E9BF.40902@cambridgebroadband.com>
References: <4639B9ED.7030902@cambridgebroadband.com>
	<4639E6A9.2040708@smiths-aerospace.com>
	<4639E9BF.40902@cambridgebroadband.com>
Content-Type: text/plain
Message-Id: <1178209451.17201.59.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Thu, 03 May 2007 11:24:11 -0500
Cc: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>,
	"linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 2007-05-03 at 08:55, Alex Zeffertt wrote:
	
> ... but when I try to compile it I get an error:
> 
> 	$ /opt/freescale/ltib/usr/bin/dtc -I dts -O dtb powerpc/arch/powerpc/boot/dts/mpc832x_mds.dts
> 	DTC: dts->dtb  on file "powerpc/arch/powerpc/boot/dts/mpc832x_mds.dts"
> 	syntax error at line 14
> 	FATAL ERROR: Couldn't read input tree
> 
> Perhaps my dtc is out of date - it came with the BSP from freescale which uses
> the 2.6.11 kernel.
> 
> Do you know where I can find an up to date dtc?  Is there any documentation regarding its use?

Read:

    linux-2.6/Documentation/powerpc/booting-without-of.txt

Get current DTC from:

    www.jdl.com/git_repos

HTH,
jdl
