Return-Path: <scottwood@freescale.com>
Message-ID: <4898C434.4040408@freescale.com>
Date: Tue, 05 Aug 2008 16:20:52 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: John Rigby <jrigby@freescale.com>
Subject: Re: [PATCH add immr alias 2/4] powerpc: 5121: Add immr alias
	to	MPC5121 ADS device tree.
References: <1217967220-30557-1-git-send-email-jrigby@freescale.com>		<1217967220-30557-2-git-send-email-jrigby@freescale.com>		<fa686aa40808051405j7268c216j8e5b526d6ad526c9@mail.gmail.com>	<fa686aa40808051405j7ea96957t9242e007c93d8e74@mail.gmail.com>
	<4898C34C.5000305@freescale.com>
In-Reply-To: <4898C34C.5000305@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

John Rigby wrote:
>    I would like to use mpc83xx_add_bridge for 5121.  This is why I
>    moved it to fsl_pci.c.  It currently uses get_immrbase and adds
>    0x8300 and 0x8304 to it to pass to setup_indirect_pci as the
>    cfg_addr, and cfg_data addresses.
> 
>    I'm more than willing to change mpc83xx_add_bridge to not use
>    get_immrbase.  One simple solution is to pass the cfg_addr and
>    cfg_data addresses in.  If that seems ok then thats what I will do.

We should really be putting those addresses in the "reg" property of the 
PCI node.

-Scott
