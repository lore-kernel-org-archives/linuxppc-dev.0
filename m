Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 139E0DDF12
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Sep 2008 00:54:00 +1000 (EST)
Message-Id: <18BF734B-F71B-4FDD-B3C9-62AA5EB54283@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <Pine.LNX.4.64.0809121546530.6192@blarg.am.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: Please pull from 'for-2.6.27'
Date: Tue, 16 Sep 2008 09:53:52 -0500
References: <Pine.LNX.4.64.0809121546530.6192@blarg.am.freescale.net>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 12, 2008, at 3:47 PM, Kumar Gala wrote:

> Please pull from 'for-2.6.27' branch of
>
> 	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git  
> for-2.6.27
>
> to receive the following updates:
>
> arch/powerpc/boot/dts/mpc8610_hpcd.dts |    8 +--
> arch/powerpc/sysdev/cpm1.c             |   74 ++++++++++++++++++++++ 
> +----------
> 2 files changed, 56 insertions(+), 26 deletions(-)
>
> Jochen Friedrich (1):
>      powerpc/cpm1: Fix race condition in CPM1 GPIO library.
>
> Timur Tabi (1):
>      powerpc: fix interrupt values for DMA2 in MPC8610 HPCD device  
> tree

Paul, I know you are hiding out at ks, but what's going on with this  
fix? :)

- k
