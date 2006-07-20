Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EF81D67BEE
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Jul 2006 23:54:51 +1000 (EST)
In-Reply-To: <44BF8634.2060009@cambridgebroadband.com>
References: <995B09A8299C2C44B59866F6391D2635058751@zch01exm21.fsl.freescale.net>
	<44BF787F.3020203@cambridgebroadband.com>
	<26296171-D21D-4FF3-B9C5-C6378064AF44@kernel.crashing.org>
	<44BF8634.2060009@cambridgebroadband.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <EFE44D26-140D-4E33-A6BF-8D2C13C89821@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [Linux-ATM-General] mpc8360sar
Date: Thu, 20 Jul 2006 08:54:34 -0500
To: Alex Zeffertt <ajz@cambridgebroadband.com>
Cc: linux-atm-general@lists.sourceforge.net, linuxppc-embedded@ozlabs.org,
	Li Tony-r64360 <Tony.Li@freescale.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jul 20, 2006, at 8:33 AM, Alex Zeffertt wrote:

>
>> Any reason we dont try to get your work up stream into the  
>> mainline kernel?
>> - kumar
>
> I'd like to see it upstreamed - the more people who use it the more  
> help I get!
>
> However, mpc8360sar is built on Freescale's BSP which adds basic  
> support for the
> board, the MPC832xE-MDS, to the stock linux kernel.  This support  
> consists of the
> following patches:
>
> Patch0          : patch-2.6.11.bz2
> Patch1          : linux-2.6.11-mpc8349e-general-20060414.patch
> Patch2          : linux-2.6.11-mpc8349e-pci-3.patch
> Patch3          : linux-2.6.11-mpc8349e-pci-agent.patch
> Patch4          : linux-2.6.11-mpc8349e-watchdog.patch
> Patch5          : linux-2.6.11-mpc83xx-sec2.patch
> Patch6          : mpc832x-sec2v15-config-1.patch
> Patch7          : linux-2.6.11-mpc8349e-usb-gadget.patch
> Patch8          : linux-2.6.11-mpc8349e-usb-host.patch
> Patch9          : linux-2.6.11-mpc8360-general-1.patch
> Patch10         : linux-2.6.11-mpc8360-pci-agent.patch
> Patch11         : linux-2.6.11-mpc832x-basic-4.patch
> Patch12         : linux-2.6.11-mpc832x-pci-agent.patch
> Patch13         : linux-2.6.11-mpc832x-spi-1.patch
> Patch14         : linux-2.6.11-mpc832x-BIT.patch
> Patch15         : linux-2.6.11-mpc83xx-ct-1.patch
> Patch16         : linux-2.6.11-mpc832x-usb-gadget.patch
> Patch17         : linux-2.6.11-mpc832x-atm-1.patch
>
> I guess there's no point upstreaming mpc8360sar until freescale have
> upstreamed these patches (and ported them to the current kernel).

True, a large number of these patches are upstream, and if I had  
access to MPC836x or MPC832x HW I'd work on getting the others that  
are reasonable.

> Alex
>
> PS It's probable that mpc8360sar actually only requires a handful of
> the above patches to be applied.

Agreed.

- kumar
