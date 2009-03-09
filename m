Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6C735DE067
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 02:52:38 +1100 (EST)
Message-Id: <A811318D-E6DB-4DDB-A8F5-50A076F1C013@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <1236200130-12012-1-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] powerpc: add fsl,
	fifo-depth property to Freescale SSI device nodes
Date: Mon, 9 Mar 2009 10:52:28 -0500
References: <1236200130-12012-1-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 4, 2009, at 2:55 PM, Timur Tabi wrote:

> The Freescale Serial Synchronous Interface (SSI) is an audio device  
> present on
> some Freescale SOCs.  Various implementations of the SSI have a  
> different
> transmit and receive FIFO depth, but are otherwise identical.  To  
> support
> these variations, add a new property fsl,fifo-depth to the SSI node  
> that
> specifies the depth of the FIFOs.
>
> Also update the MPC8610 HPCD device tree with this property.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>
> Updates to the SSI audio driver will come later.  Currently, this  
> driver
> supports only one Freescale SOC, and so it's hard-coded to use the  
> value 8.
> If/when this driver is updated to support other SOCs (e.g. the i.MX  
> parts
> that have a FIFO depth of 15), the driver will check for this  
> property.  I
> just want to get this DTS change in now.
>
> Documentation/powerpc/dts-bindings/fsl/ssi.txt |    2 ++
> arch/powerpc/boot/dts/mpc8610_hpcd.dts         |    2 ++
> 2 files changed, 4 insertions(+), 0 deletions(-)

applied to next

- k
