Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A05C7DDF70
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Oct 2007 23:56:52 +1000 (EST)
In-Reply-To: <47075FA7.3030108@semihalf.com>
References: <47075FA7.3030108@semihalf.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9BA27CBC-1C24-4119-A216-A0A2C626E3D4@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 00/15] [POWERPC] TQM5200, CM5200 and Motion-PRO support
Date: Mon, 8 Oct 2007 08:57:08 -0500
To: Marian Balakowicz <m8@semihalf.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 6, 2007, at 5:12 AM, Marian Balakowicz wrote:

> Hello,
>
> The following series of patches adds arch/powerpc support for three  
> MPC5200 based boards:
> TQM5200, CM5200 and Motion-PRO.
>
> Included are also patches with modifications to common 52xx code.  
> New helper
> routine mpc52xx_find_and_map_path() is added, and is being used in  
> LED driver
> for Motion-PRO. Another patch adds mpc52xx_restart(), mpc52xx_halt()
> and mpc52xx_power_off(). This modification has been around for some  
> time now
> and relies on Sascha Hauer's patch.
>
> 01/15 [POWERPC] TQM5200 DTS
> 02/15 [POWERPC] TQM5200 defconfig
> 03/15 [POWERPC] TQM5200 board support
> 04/15 [POWERPC] cm5200 DTS
> 05/15 [POWERPC] cm5200 defconfig
> 06/15 [POWERPC] cm5200 board support
> 07/15 [POWERPC] Promess motionpro DTS
> 08/15 [POWERPC] Promess motionpro defconfig
> 09/15 [POWERPC] Promess motionpro board support
> 10/15 [POWERPC] Add mpc52xx_find_and_map_path(), refactor utility  
> functions.
> 11/15 [POWERPC] Motion-PRO: Add LED support.
> 12/15 [POWERPC] Add mpc52xx_restart(), mpc52xx_halt(),  
> mpc52xx_power_off().
> 13/15 [POWERPC] Init restart/halt/power_off machine hooks for tqm5200.
> 14/15 [POWERPC] Init restart/halt/power_off machine hooks for cm5200.
> 15/15 [POWERPC] Init restart/halt/power_off machine hooks for  
> motionpro.

Why don't you submit patch 12/15 first so you can just fold 13/14/15  
into their respect board support patches.  In general any generic  
clean patches first is usually a good idea followed by the patches  
that depend on them.

- k
