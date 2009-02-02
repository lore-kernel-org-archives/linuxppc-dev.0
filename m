Return-Path: <galak@kernel.crashing.org>
Message-Id: <29132097-D949-491C-861A-F09B3CF386D3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Wolfgang Grandegger <wg@grandegger.com>
In-Reply-To: <4981A5CD.1050203@grandegger.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] PowerPC: MPC85xx: TQM85xx: add i2c device nodes for LM75
Date: Mon, 2 Feb 2009 09:39:55 -0600
References: <4981A5CD.1050203@grandegger.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 29, 2009, at 6:49 AM, Wolfgang Grandegger wrote:

> Automatic I2C device probing is not done any more. Therefore we need
> proper DTS device node definitions for the I2C LM75 thermal sensor on
> the TQM85xx modules.
>
> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
> ---
> arch/powerpc/boot/dts/tqm8540.dts          |    5 +++++
> arch/powerpc/boot/dts/tqm8541.dts          |    5 +++++
> arch/powerpc/boot/dts/tqm8548-bigflash.dts |    5 +++++
> arch/powerpc/boot/dts/tqm8548.dts          |    5 +++++
> arch/powerpc/boot/dts/tqm8555.dts          |    5 +++++
> arch/powerpc/boot/dts/tqm8560.dts          |    5 +++++
> 6 files changed, 30 insertions(+)


applied to next

- k
