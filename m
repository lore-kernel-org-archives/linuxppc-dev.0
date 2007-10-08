Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by ozlabs.org (Postfix) with ESMTP id 7C7F0DDF38
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Oct 2007 17:16:41 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so1655689wag
	for <linuxppc-dev@ozlabs.org>; Mon, 08 Oct 2007 00:16:39 -0700 (PDT)
Message-ID: <fa686aa40710080016ra8bad10l5e7a0fbb60f11aa@mail.gmail.com>
Date: Mon, 8 Oct 2007 01:16:39 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Marian Balakowicz" <m8@semihalf.com>
Subject: Re: [PATCH 00/15] [POWERPC] TQM5200, CM5200 and Motion-PRO support
In-Reply-To: <47075FA7.3030108@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47075FA7.3030108@semihalf.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/6/07, Marian Balakowicz <m8@semihalf.com> wrote:
> Hello,
>
> The following series of patches adds arch/powerpc support for three MPC5200 based boards:
> TQM5200, CM5200 and Motion-PRO.

Thanks for the patch series.

g.

>
> Included are also patches with modifications to common 52xx code. New helper
> routine mpc52xx_find_and_map_path() is added, and is being used in LED driver
> for Motion-PRO. Another patch adds mpc52xx_restart(), mpc52xx_halt()
> and mpc52xx_power_off(). This modification has been around for some time now
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
> 10/15 [POWERPC] Add mpc52xx_find_and_map_path(), refactor utility functions.
> 11/15 [POWERPC] Motion-PRO: Add LED support.
> 12/15 [POWERPC] Add mpc52xx_restart(), mpc52xx_halt(), mpc52xx_power_off().
> 13/15 [POWERPC] Init restart/halt/power_off machine hooks for tqm5200.
> 14/15 [POWERPC] Init restart/halt/power_off machine hooks for cm5200.
> 15/15 [POWERPC] Init restart/halt/power_off machine hooks for motionpro.
>
> Comments and review notes are welcome.
>
> Cheers,
> Marian Balakowicz
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
