Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.248])
	by ozlabs.org (Postfix) with ESMTP id 78E59DDFBD
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Nov 2007 04:20:45 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id b2so91788ana
	for <linuxppc-dev@ozlabs.org>; Fri, 09 Nov 2007 09:20:44 -0800 (PST)
Message-ID: <fa686aa40711090920n3e931cbbwf63a66cedd5504de@mail.gmail.com>
Date: Fri, 9 Nov 2007 10:20:44 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Marian Balakowicz" <m8@semihalf.com>
Subject: Re: [PATCH v4 00/13] [POWERPC] Add TQM5200/CM5200/Motion-PRO board
	support
In-Reply-To: <20071109171137.16289.39575.stgit@hekate.izotz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071109171137.16289.39575.stgit@hekate.izotz.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/9/07, Marian Balakowicz <m8@semihalf.com> wrote:
> This is a yet another version of the patches that add arch/powerpc support for
> three MPC5200 based boards: TQ-Components TQM5200, Schindler CM5200
> and Promess Motion-PRO.
>
> Updates include modifications to mpc5200_simple_probe() routine in the
> generic support for simple MPC5200 based boards, changes to
> leds-motionpro driver - using common compatility property for both LEDs,
> and few other .dts cleanups.
>
> [POWERPC] Promess Motion-PRO defconfig
> [POWERPC] Promess Motion-PRO DTS
> [POWERPC] Motion-PRO: Add LED support.
> [POWERPC] CM5200 defconfig
> [POWERPC] CM5200 DTS
> [POWERPC] TQM5200 defconfig
> [POWERPC] TQM5200 DTS
> [POWERPC] Use EXPORT_SYMBOL_GPL for 52xx common routines symbol export
> [POWERPC] Export mpc52xx_map_node() routine symbol
> [POWERPC] Add generic support for simple MPC5200 based boards
> [POWERPC] Add common mpc52xx_setup_pci() routine
> [POWERPC] Add 'fsl,lpb' bus type for MPC5200 LocalPlus Bus
> [POWERPC] Add 'model: ...' line to common show_cpuinfo()
>
> Please review, and if everything is ok schedule for 2.6.24-rc3.

Just to be clear, I won't be picking up these changes until the 2.6.25
merge window.

The .24 tree is closed for new board support patches and is in bug fix
only mode.

Thanks,
g.

>
> Cheers,
> m.
>
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
