Return-Path: <mgreer@mvista.com>
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id D972368A4D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Jan 2006 03:08:14 +1100 (EST)
Date: Wed, 11 Jan 2006 09:07:09 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: happa@wmlab.csie.ncu.edu.tw
Message-ID: <20060111160709.GA6405@mag.az.mvista.com>
References: <20060111102618.0F9251100F2@wmlab.csie.ncu.edu.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060111102618.0F9251100F2@wmlab.csie.ncu.edu.tw>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: About MMU setting in MPC8245
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Jan 11, 2006 at 06:26:18PM +0800, happa@wmlab.csie.ncu.edu.tw wrote:
> Hi,
> Sorry, I have very basic question about PPC MMU setting.
> 
> In "http://www.denx.de/wiki/PPCEmbedded/Kernel#BOOTLOADER",
> chapter 10.2. Memory Map, I get the following information.
>  
> "The bootloader is responsible for configuring the memory map before jumping to the Linux kernel."
> 
> Is anyone know what memory map should be done in bootloader? 

Are you in PCI host mode?  If so, the first sentence of chapter 3--
Address Maps of the 8245 manual states:

	"The MPC8245 in PCI host mode supports an address mapping
	configuration that is designated as address map B."

Map B == CHRP mapping.

> If I'm using ICE to load linux kernel, what kind of CPU registers need be configured first?
> Is IBAT/DBAT and Segment register need be set?

Why don't you just use U-boot or look at the U-Boot code to see how its
done?

Mark
