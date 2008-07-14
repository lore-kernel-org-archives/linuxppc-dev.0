Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4B58ADDEF5
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jul 2008 23:17:11 +1000 (EST)
Message-Id: <501E46CC-4D2C-41E6-8954-1DC13CD510C5@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20080714182118.f5a20643.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: powerpc/master: build failure
Date: Mon, 14 Jul 2008 08:16:57 -0500
References: <20080714182118.f5a20643.sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 14, 2008, at 3:21 AM, Stephen Rothwell wrote:

> Hi Kumar,
>
> A build of today's powerpc/master tree for mpc85xx_defconfig fails  
> like this:
>
> DTC: dts->dtb  on file "arch/powerpc/boot/dts/ksi8560.dts"
> ERROR (phandle_references): Reference to non-existent node or label  
> "mpic"
> ERROR (phandle_references): Reference to non-existent node or label  
> "mpic"
> ERROR (phandle_references): Reference to non-existent node or label  
> "mpic"
> ERROR (phandle_references): Reference to non-existent node or label  
> "mpic"
> ERROR: Input tree has errors, aborting (use -f to force output)
> make[2]: *** [arch/powerpc/boot/ksi8560.dtb] Error 2
>
> Probably commit dee805532a30183c4462305b4614e58bd83a7bc1 ("powerpc:  
> Add
> dma nodes to 83xx, 85xx and 86xx boards").

I have fixes, just need benh to pull them.

- k
