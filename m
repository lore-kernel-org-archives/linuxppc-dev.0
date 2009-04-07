Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DEA3EDDF7C
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Apr 2009 16:18:49 +1000 (EST)
Message-Id: <48390008-A237-49FB-AF8F-FC3E15D38108@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Wolfgang Grandegger <wg@grandegger.com>
In-Reply-To: <49BE143A.6020109@grandegger.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 1/3] PowerPC: MPC85xx: TQM85xx: correct address of LM75
	I2C device nodes
Date: Tue, 7 Apr 2009 01:18:40 -0500
References: <49BE143A.6020109@grandegger.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 16, 2009, at 3:56 AM, Wolfgang Grandegger wrote:

> Commit 0f73a449a649acfca91404a98a35353a618b9555 added I2C device nodes
> for the LM75 thermal sensor on the TQM85xx modules, unfortunately with
> the wrong I2C address. The LM75s are located at address 0x48.
>
> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
> ---
> arch/powerpc/boot/dts/tqm8540.dts          |    4 ++--
> arch/powerpc/boot/dts/tqm8541.dts          |    4 ++--
> arch/powerpc/boot/dts/tqm8548-bigflash.dts |    4 ++--
> arch/powerpc/boot/dts/tqm8548.dts          |    4 ++--
> arch/powerpc/boot/dts/tqm8555.dts          |    4 ++--
> arch/powerpc/boot/dts/tqm8560.dts          |    4 ++--
> 6 files changed, 12 insertions(+), 12 deletions(-)

applied

- k
