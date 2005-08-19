Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A1133680D7
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Aug 2005 01:06:23 +1000 (EST)
In-Reply-To: <4305D42A.2080803@ru.mvista.com>
References: <4305D42A.2080803@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6c1a48b29ad7e3d4c7f830f14ee7333d@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Fri, 19 Aug 2005 11:06:06 -0400
To: Vitaly Bordug <vbordug@ru.mvista.com>
Cc: "Schaefer-Hutter, Peter" <Peter.Schaefer-Hutter@tfk-racoms.com>,
	Kumar Gala <galak@freescale.com>,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [RFC][PATCH] [1/2] 8xx platform definitions
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Aug 19, 2005, at 8:44 AM, Vitaly Bordug wrote:

> +#define MPC8xx_INT_FEC1		SIU_LEVEL1
> +#define MPC8xx_INT_FEC2		SIU_LEVEL3
> +
> +#define MPC8xx_INT_SCC1		(CPM_IRQ_OFFSET + CPMVEC_SCC1)
> +#define MPC8xx_INT_SCC2		(CPM_IRQ_OFFSET + CPMVEC_SCC2)
> +#define MPC8xx_INT_SCC3		(CPM_IRQ_OFFSET + CPMVEC_SCC3)
> +#define MPC8xx_INT_SCC4		(CPM_IRQ_OFFSET + CPMVEC_SCC4)
> +#define MPC8xx_INT_SMC1		(CPM_IRQ_OFFSET + CPMVEC_SMC1)
> +#define MPC8xx_INT_SMC2		(CPM_IRQ_OFFSET + CPMVEC_SMC2)
> +
> +/* Offset from IMMAP base address */
> +#define MPC8xx_SCC1_OFFSET	(0xa00)
> +#define MPC8xx_SCC1_SIZE	(0x18)
> +#define MPC8xx_SCC2_OFFSET	(0xa20)
> +#define MPC8xx_SCC2_SIZE	(0x18)
> +#define MPC8xx_SCC3_OFFSET	(0xa40)
> +#define MPC8xx_SCC3_SIZE	(0x18)
> +#define MPC8xx_SCC4_OFFSET	(0xa60)
> +#define MPC8xx_SCC4_SIZE	(0x18)
> +#define MPC8xx_SMC1_OFFSET	(0xa82)
> +#define MPC8xx_SMC1_SIZE	(0x0f)
> +#define MPC8xx_SMC2_OFFSET	(0xa92)
> +#define MPC8xx_SMC2_SIZE	(0x0d)
> +#define MPC8xx_FEC1_OFFSET	(0xe00)
> +#define MPC8xx_FEC1_SIZE	(0x88)
> +#define MPC8xx_FEC2_OFFSET	(0x1e00)
> +#define MPC8xx_FEC2_SIZE	(0x88)
> +
> +#define MPC8xx_DPARAM_SCC1_OFFSET	(0x3C00)
> +#define MPC8xx_DPARAM_SCC1_SIZE	(0x80)
> +#define MPC8xx_DPARAM_SCC2_OFFSET	(0x3D00)
> +#define MPC8xx_DPARAM_SCC2_SIZE	(0x80)
> +#define MPC8xx_DPARAM_SCC3_OFFSET	(0x3E00)
> +#define MPC8xx_DPARAM_SCC3_SIZE	(0x80)
> +#define MPC8xx_DPARAM_SCC4_OFFSET	(0x3F00)
> +#define MPC8xx_DPARAM_SCC4_SIZE	(0x80)
> +#define MPC8xx_DPARAM_SMC1_OFFSET	(0x3E80)
> +#define MPC8xx_DPARAM_SMC1_SIZE	(0x40)
> +#define MPC8xx_DPARAM_SMC2_OFFSET	(0x3F80)
> +#define MPC8xx_DPARAM_SMC2_SIZE	(0x40)

All of these #defines should already be in a header file somewhere,
and if they aren't, should be in the generic CPM header file.
Please clean this up.

Thanks.

	-- Dan
