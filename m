Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 34C7C67C66
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Oct 2006 04:43:21 +1000 (EST)
In-Reply-To: <20061003223054.06e25136@localhost.localdomain>
References: <20061003223054.06e25136@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E0C344B6-3149-46E4-8573-6EA220F4D7FE@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Please pull upstream branch of linux-2.6-PQ.git...
Date: Tue, 3 Oct 2006 13:43:35 -0500
To: Vitaly Bordug <vbordug@ru.mvista.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 3, 2006, at 1:30 PM, Vitaly Bordug wrote:

> Paul,
>
> Please do a pull from
>
> git://git.kernel.org/pub/scm/linux/kernel/git/vitb/linux-2.6- 
> PQ.git, upstream branch.
>
> Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
>
>
> To receive the updated 8272 addition to the  arch/powerpc.
> All the comments have been addressed, and it has a minor bugfix  
> addressed too in order to make both pq2 and pq3
> co-exist happily in fsl_soc.c. CPM PIC now has "compatible"  
> property that could be "CPM2" or "CPM1" for PQ/8xx.
>
> I think it should go to rc1, because relevant stuff in ppc/ is more  
> or less broken now, with new irq engine.
>
> --
>
>  arch/powerpc/Kconfig                      |    1
>  arch/powerpc/boot/dts/mpc8272ads.dts      |  223 ++++++++++
>  arch/powerpc/platforms/82xx/Kconfig       |   21
>  arch/powerpc/platforms/82xx/Makefile      |    5
>  arch/powerpc/platforms/82xx/m82xx_pci.h   |   19
>  arch/powerpc/platforms/82xx/mpc82xx.c     |  111 +++++
>  arch/powerpc/platforms/82xx/mpc82xx_ads.c |  661 ++++++++++++++++++ 
> ++++++++++++
>  arch/powerpc/platforms/82xx/pq2ads.h      |   67 +++
>  arch/powerpc/sysdev/cpm2_pic.c            |    2
>  arch/powerpc/sysdev/cpm2_pic.h            |    2
>  arch/powerpc/sysdev/fsl_soc.c             |   62 ++
>  11 files changed, 1165 insertions(+), 9 deletions(-)

Are there updates to the flat dev spec for the CPM nodes?  That is my  
only hold up on ack'ing all this good PQ2/PQ3 CPM work.

- k
