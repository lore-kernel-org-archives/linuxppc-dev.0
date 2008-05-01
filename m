Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CB128DDDFD
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 13:58:59 +1000 (EST)
Message-Id: <AC86E46C-F3D5-4197-9152-C1D257071B08@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
In-Reply-To: <20080430164558.03b5f517.randy.dunlap@oracle.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] rapidio: fix current kernel-doc notation
Date: Wed, 30 Apr 2008 22:57:14 -0500
References: <Pine.LNX.4.64.0804292009000.18219@shark.he.net>
	<20080430113500.dfe21880.akpm@linux-foundation.org>
	<51A34080-7981-4958-B225-4921FC95B84A@kernel.crashing.org>
	<20080430121239.28492328.akpm@linux-foundation.org>
	<18456.60948.463017.139935@cargo.ozlabs.ibm.com>
	<20080430151149.063920cf.randy.dunlap@oracle.com>
	<63DC9937-3C82-4744-8281-B9FDB941FEE1@kernel.crashing.org>
	<4818EFEC.4080003@oracle.com>
	<20080430164558.03b5f517.randy.dunlap@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	torvalds@linux-foundation.org, Wei.Zhang@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 30, 2008, at 6:45 PM, Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
>
> Fix current (-git16) missing docbook/kernel-doc notation in RapidIO  
> files.
>
> Warning(linux-2.6.25-git16//include/linux/rio.h:187): No description  
> found for parameter 'sys_size'
> Warning(linux-2.6.25-git16//include/linux/rio.h:187): No description  
> found for parameter 'phy_type'
>
> Warning(linux-2.6.25-git16//arch/powerpc/sysdev/fsl_rio.c:188): No  
> description found for parameter 'mport'
> Warning(linux-2.6.25-git16//arch/powerpc/sysdev/fsl_rio.c:224): No  
> description found for parameter 'mport'
> Warning(linux-2.6.25-git16//arch/powerpc/sysdev/fsl_rio.c:245): No  
> description found for parameter 'mport'
> Warning(linux-2.6.25-git16//arch/powerpc/sysdev/fsl_rio.c:270): No  
> description found for parameter 'mport'
> Warning(linux-2.6.25-git16//arch/powerpc/sysdev/fsl_rio.c:311): No  
> description found for parameter 'mport'
> Warning(linux-2.6.25-git16//arch/powerpc/sysdev/fsl_rio.c:996): No  
> description found for parameter 'dev'
>
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> ---
> arch/powerpc/sysdev/fsl_rio.c |    9 +++++++--
> include/linux/rio.h           |    2 ++
> 2 files changed, 9 insertions(+), 2 deletions(-)

applied.

- k
