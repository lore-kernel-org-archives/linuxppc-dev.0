Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3AEEB67A64
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jun 2006 22:45:58 +1000 (EST)
In-Reply-To: <17561.418.97341.74610@cargo.ozlabs.ibm.com>
References: <17561.418.97341.74610@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3F041A9D-F1D9-4FF9-977F-E09D924D0741@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: please pull powerpc.git 'merge' branch
Date: Wed, 21 Jun 2006 07:45:48 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, torvalds@osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Jon Loeliger:
>       [POWERPC] Guard L3CR references with CPU_FTR_L3CR.
>       [POWERPC] Prevent duplicate lmb reservations for Device Tree  
> blob.
>       [POWERPC] Add the mpc8641 hpcn Kconfig and Makefiles.
>       [POWERPC] Add mpc8641_hpcn_defconfig config file.
>       [POWERPC] Add 8641 CPU table entry.
>       [POWERPC] Add starting of secondary 86xx CPUs.
>       [POWERPC] Add the MPC8641 HPCN platform files.
>       [POWERPC] Add mpc8641hpcn PCI/PCI-Express platform files.
>       [POWERPC] Add 8641 Register space and IRQ definitions.
>       [POWERPC] Document I2C_MPC option for 86xx too.
>       [POWERPC] Add Vitesse 8244 PHY for MPC8641 HPCN platform.

Paul, some of the 8641 patches still need some cleanup, any reason  
you included them?

- kumar
