Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B5B1DDDE03
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 23:41:47 +1000 (EST)
In-Reply-To: <18179.13902.936820.573996@cargo.ozlabs.ibm.com>
References: <18179.13902.936820.573996@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A930AB10-3597-4F56-A403-3993411F110D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Patches added to powerpc.git for-2.6.24 branch
Date: Wed, 3 Oct 2007 08:41:51 -0500
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

> Jochen Friedrich (4):
>       [POWERPC] Fix copy'n'paste typo in commproc.c
>       [PPC] Fix cpm_dpram_addr returning phys mem instead of virt mem
>       [PPC] Compile fix for 8xx CPM Ehernet driver
>       [POWERPC] Fix cpm_uart driver
>
Some of these should already be Linus's tree (all but the 8xx CPM  
Ehernet)

- k
