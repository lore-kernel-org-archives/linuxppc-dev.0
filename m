Return-Path: <AZeffertt@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6C3B967BC2
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Jul 2006 02:15:17 +1000 (EST)
Message-ID: <44BFABFD.1070904@cambridgebroadband.com>
Date: Thu, 20 Jul 2006 17:14:53 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [Linux-ATM-General] mpc8360sar
References: <995B09A8299C2C44B59866F6391D2635058751@zch01exm21.fsl.freescale.net>
	<44BF787F.3020203@cambridgebroadband.com>
	<26296171-D21D-4FF3-B9C5-C6378064AF44@kernel.crashing.org>
	<44BF8634.2060009@cambridgebroadband.com>
	<EFE44D26-140D-4E33-A6BF-8D2C13C89821@kernel.crashing.org>
In-Reply-To: <EFE44D26-140D-4E33-A6BF-8D2C13C89821@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Kumar Gala wrote:
> 
> On Jul 20, 2006, at 8:33 AM, Alex Zeffertt wrote:
> 
>>
>>> Any reason we dont try to get your work up stream into the mainline 
>>> kernel?
>>> - kumar
>>
>> I'd like to see it upstreamed - the more people who use it the more 
>> help I get!
>>
>> However, mpc8360sar is built on Freescale's BSP which adds basic 
>> support for the
>> board, the MPC832xE-MDS, to the stock linux kernel.  This support 
>> consists of the
>> following patches:
>>
>> Patch0          : patch-2.6.11.bz2
>> Patch1          : linux-2.6.11-mpc8349e-general-20060414.patch
>> Patch2          : linux-2.6.11-mpc8349e-pci-3.patch
>> Patch3          : linux-2.6.11-mpc8349e-pci-agent.patch
>> Patch4          : linux-2.6.11-mpc8349e-watchdog.patch
>> Patch5          : linux-2.6.11-mpc83xx-sec2.patch
>> Patch6          : mpc832x-sec2v15-config-1.patch
>> Patch7          : linux-2.6.11-mpc8349e-usb-gadget.patch
>> Patch8          : linux-2.6.11-mpc8349e-usb-host.patch
>> Patch9          : linux-2.6.11-mpc8360-general-1.patch
>> Patch10         : linux-2.6.11-mpc8360-pci-agent.patch
>> Patch11         : linux-2.6.11-mpc832x-basic-4.patch
>> Patch12         : linux-2.6.11-mpc832x-pci-agent.patch
>> Patch13         : linux-2.6.11-mpc832x-spi-1.patch
>> Patch14         : linux-2.6.11-mpc832x-BIT.patch
>> Patch15         : linux-2.6.11-mpc83xx-ct-1.patch
>> Patch16         : linux-2.6.11-mpc832x-usb-gadget.patch
>> Patch17         : linux-2.6.11-mpc832x-atm-1.patch
>>
>> I guess there's no point upstreaming mpc8360sar until freescale have
>> upstreamed these patches (and ported them to the current kernel).
> 
> True, a large number of these patches are upstream, and if I had access 
> to MPC836x or MPC832x HW I'd work on getting the others that are 
> reasonable.
> 
>> Alex
>>
>> PS It's probable that mpc8360sar actually only requires a handful of
>> the above patches to be applied.
> 
> Agreed.
> 
> - kumar


Tony, can you let me know when CONFIG_MPC832XE_MDS support is upstreamed
to a kernel.org kernel.  I'll then try to get the mpc8360sar working with this
kernel and then upstream it.

Alex

PS I'm not entirely sure how "upstreaming" is done.
