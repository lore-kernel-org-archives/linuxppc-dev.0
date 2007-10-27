Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 85A8DDDF23
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Oct 2007 05:09:08 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2] [POWERPC] Fix CONFIG_SMP=n build break
Date: Sat, 27 Oct 2007 20:08:34 +0200
References: <20071026165510.GA2323@lixom.net>
	<200710262019.12094.arnd@arndb.de>
	<20071027172851.GA11930@lixom.net>
In-Reply-To: <20071027172851.GA11930@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710272008.35334.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 27 October 2007, Olof Johansson wrote:
> Fix two build errors on powerpc allyesconfig + CONFIG_SMP=n:
> 
> arch/powerpc/platforms/built-in.o: In function `cpu_affinity_set':
> arch/powerpc/platforms/cell/spu_priv1_mmio.c:78: undefined reference to `.iic_get_target_id'
> arch/powerpc/platforms/built-in.o: In function `iic_init_IRQ':
> arch/powerpc/platforms/cell/interrupt.c:397: undefined reference to `.iic_setup_cpu'
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> 

Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
