Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F4000DDE0A
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 20:30:25 +1100 (EST)
Message-Id: <9C12D718-CEE4-4533-BD88-F3F8A4CA0BE9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
In-Reply-To: <11997159321859-git-send-email-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 0/7] Powerpc support for SBC8560 board
Date: Thu, 24 Jan 2008 03:30:15 -0600
References: <11997159321859-git-send-email-paul.gortmaker@windriver.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 7, 2008, at 8:25 AM, Paul Gortmaker wrote:

>
> This is a respin of the sbc8560 patches, incorporating the feedback  
> and
> suggested changes from everyone.  Changes include:
>
> -coding style and missing of_put (Stephen Rothwell)
>
> -minor dtc cleanups for gianfar, mdio, mpic etc. (David Gibson /  
> Kumar Gala)
>
> -use for_each macros in legacy_serial to improve readability, and as
> groundwork for next change (me)
>
> -convert dtc "duart" + "device-type="soc" thing to be an epld entry
> listed as compatible with "localbus" -- plus add localbus as an  
> acceptable
> parent in legacy_serial (David Gibson / Scott Wood)
>
> -rtc is now a child of the epld/localbus and does not use device_type
> in the dtc, nor in the platform detection code (David Gibson)
>
> -add CPM2 data to dts for FCC ports (on optional daughterboard) based
> on the MPC8560ADS dts (me)
>
> -add dts aliases, conversion to dts-v1 (Kumar)
>
> Patches are as follows:
>
> 1  powerpc-use-for_each-in-legacy_serial.txt
> 2  powerpc-allow-localbus-compatible-serial-ports-for-console- 
> device.txt
> 3  sbc8560-add-support-for-Wind-River-SBC8560-in-arch-powerpc.txt
> 4  sbc8560-Add-device-tree-source-for-Wind-River-SBC8560-board.txt
> 5  sbc8560-Convert-WRS-SBC8560-device-tree-to-v1-format.txt
> 6  CPM2-Make-support-for-the-CPM2-optional-on-8560-based-boards.txt
> 7  sbc8560-Add-default-.config-file-for-Wind-River-SBC8560.txt
>
> Thanks again to all those who provided feedback.

Have we closed on these patches?

the sbc8560 is the last board that we need to close on for me to kill  
85xx in arch/ppc.

- k
