Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 19F672C00D6
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 May 2013 09:25:45 +1000 (EST)
Message-ID: <1367623431.4389.132.camel@pasglop>
Subject: Re: [PATCH] arch/powerpc: advertise ISA2.07, HTM, DSCR, EBB and
 ISEL bits in HWCAP2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Date: Sat, 04 May 2013 09:23:51 +1000
In-Reply-To: <20130503231933.GA29436@linux.vnet.ibm.com>
References: <20130503231933.GA29436@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Michael Neuling <michael.neuling@au1.ibm.com>,
 Michael R Meissner <mrmeissn@us.ibm.com>, sjmunroe@us.ibm.com,
 bergner@us.ibm.com, Ryan Arnold <ryanarn@us.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-05-03 at 16:19 -0700, Nishanth Aravamudan wrote:
> +/* in AT_HWCAP2 */
> +#define PPC_FEATURE2_ARCH_2_07         0x80000000
> +#define PPC_FEATURE2_HTM               0x40000000
> +#define PPC_FEATURE2_DSCR              0x20000000
> +#define PPC_FEATURE2_EBB               0x10000000
> +#define PPC_FEATURE2_ISEL              0x08000000

Should we "adjust" (ie filter out) some of these based
on CONFIG_ options (such as transactional memory enabled,
EBB supported by the hypervisor, etc...) ?

Cheers,
Ben.
