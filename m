Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A8215DDDFE
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 23:36:10 +1100 (EST)
In-Reply-To: <32F3CC26D4DAC44E8ECD07155727A46E816A9D@zch01exm20.fsl.freescale.net>
References: <32F3CC26D4DAC44E8ECD07155727A46E816A9D@zch01exm20.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <89913836fb5b7a4de773ee13c27977c8@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch][5/5] powerpc: Add the general support for Embedded
	Floating-Point instructions
Date: Fri, 12 Jan 2007 13:36:40 +0100
To: "Zhu Ebony-r57400" <ebony.zhu@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> CONFIG_SPE doesn't force the whole math emulation to be built. If 
> CONFIG_SPE is set,
> only the new SPFP/DPFP/VSPFP instructions in arch/powerpc/math-emu 
> will be built,
> while the previous FPU instructions won't.

And the other way around I suppose.

> Therefore, what I'm trying to do is to build directory 
> arch/powerpc/math-emu if
> CONFIG_MATH_EMULATION or CONFIG_SPE is set. Do you have any idea?

Maybe you should really have a separate CONFIG_SPE_MATH_EMU?
Or that might complicate things more than it solves, dunno.


Segher
