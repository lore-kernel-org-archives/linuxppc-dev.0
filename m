Return-Path: <galak@kernel.crashing.org>
Message-Id: <94160B3F-AA16-4A1A-AED1-F6238235316B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Wolfgang Grandegger <wg@grandegger.com>
In-Reply-To: <4847AE52.5000809@grandegger.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH v2 4/4] [POWERPC] 85xx: correct vendor prefix in DTS files
	for TQM85xx modules
Date: Thu, 5 Jun 2008 09:01:53 -0500
References: <4847AE52.5000809@grandegger.com>
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 5, 2008, at 4:13 AM, Wolfgang Grandegger wrote:

> Like for the TQM5200, the vendor prefix "tqc," is now used for all
> TQM85xx modules from TQ-Components GmbH (http://www.tqc.de) in the
> corresponding DTS files.
>
> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
> ---
> arch/powerpc/boot/dts/tqm8540.dts          |    4 ++--
> arch/powerpc/boot/dts/tqm8541.dts          |    4 ++--
> arch/powerpc/boot/dts/tqm8548-bigflash.dts |    4 ++--
> arch/powerpc/boot/dts/tqm8548.dts          |    4 ++--
> arch/powerpc/boot/dts/tqm8555.dts          |    4 ++--
> arch/powerpc/boot/dts/tqm8560.dts          |    4 ++--
> arch/powerpc/platforms/85xx/tqm85xx.c      |   10 +++++-----

any reason that tqm8548*.dts just dont have these changes to begin  
with (since they are new)?

- k
