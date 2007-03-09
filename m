Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D997DDDEBA
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Mar 2007 17:03:21 +1100 (EST)
In-Reply-To: <17904.60099.441388.484204@cargo.ozlabs.ibm.com>
References: <17904.60099.441388.484204@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FADB4DD7-E3D2-45C0-87ED-9F2AF081ECED@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: patches pushed to powerpc.git for-2.6.22 branch
Date: Fri, 9 Mar 2007 00:02:18 -0600
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 8, 2007, at 11:04 PM, Paul Mackerras wrote:

> I have committed the patches listed below and pushed them to the
> for-2.6.22 branch of the powerpc.git repository.
>
> If your patch isn't there and you think it should be, let me know.  I
> am aware of Sylvain's uevent patches, but I haven't had time to review
> them properly yet and neither has Ben H or anyone else, so I haven't
> put them in.  There are some other patches that depend on those
> (e.g. the ibmebus patches) so they haven't gone in yet either.
>
> Paul.

[snip]

> Segher Boessenkool (1):
>       [POWERPC] PowerPC: select default image for Linkstation

I pulled this into my 2.6.21 tree for you as it fixes a build issue.

> Stephen Rothwell (8):
>       [POWERPC] Allocate syscall number for sys_getcpu

Should this go into 2.6.21 ?

>       [POWERPC] Make ppc64_defconfig without CONFIG_PPC_PSERIES build
>       [POWERPC] Create and use set_pci_dma_ops
>       [POWERPC] Create and use get_pci_dma_ops()
>       [POWERPC] Make iSeries build without CONFIG_PCI
>       [POWERPC] Allow pSeries to build without CONFIG_PCI
>       [POWERPC] Allow xmon to build without CONFIG_DEBUG_BUGVERBOSE
>       [POWERPC] Make find_and_init_pbs() a void function
>
> Stuart Yoder (3):
>       [POWERPC] Remove interrupt-controller as a property under / 
> chosen
>       [POWERPC] Remove unused, undocumented #cpus property from  
> cpus node
>       [POWERPC] Update interrupt info in booting-without-of.txt
>
> Zang Roy-r61911 (1):
>       [POWERPC] Remove fixed setting of ROOT_DEV for 7448HPC2  
> platforms

I'll drop this from my tree now.

- k
