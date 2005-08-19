Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 7855667F9A
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Aug 2005 06:14:51 +1000 (EST)
In-Reply-To: <43062C9D.5060703@ru.mvista.com>
References: <43062C9D.5060703@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F4D5471D-290B-4D17-8B3A-07A49EFF5F1C@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 19 Aug 2005 15:14:47 -0500
To: Vitaly Bordug <vbordug@ru.mvista.com>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] ppc32: 8xx pq platform system descriptions
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

+/* access ports */
+#define setbits32(_addr, _v) out_be32(&(_addr), in_be32(&(_addr)) |   
(_v))
+#define clrbits32(_addr, _v) out_be32(&(_addr), in_be32(&(_addr)) & ~ 
(_v))
+
+#define setbits16(_addr, _v) out_be16(&(_addr), in_be16(&(_addr)) |   
(_v))
+#define clrbits16(_addr, _v) out_be16(&(_addr), in_be16(&(_addr)) & ~ 
(_v))
+

Needs to go.

+#define MPC8xx_INT_FEC1        SIU_LEVEL1
+#define MPC8xx_INT_FEC2        SIU_LEVEL3
+
+#define MPC8xx_INT_SCC1        (CPM_IRQ_OFFSET + CPMVEC_SCC1)
+#define MPC8xx_INT_SCC2        (CPM_IRQ_OFFSET + CPMVEC_SCC2)
+#define MPC8xx_INT_SCC3        (CPM_IRQ_OFFSET + CPMVEC_SCC3)
+#define MPC8xx_INT_SCC4        (CPM_IRQ_OFFSET + CPMVEC_SCC4)
+#define MPC8xx_INT_SMC1        (CPM_IRQ_OFFSET + CPMVEC_SMC1)
+#define MPC8xx_INT_SMC2        (CPM_IRQ_OFFSET + CPMVEC_SMC2)

Marcelo, we should look at what effect moving CPMVEC_* out of  
commproc.h into irq.h and cleaning things up has on the world.

- kumar

On Aug 19, 2005, at 2:01 PM, Vitaly Bordug wrote:

> Added ppc_sys device and system definitions for PowerQUICC I devices.
>
> Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
> -- 
> Sincerely,
> Vitaly
>
> <8xx_plats.diff>
> <ATT292304.txt>
>
