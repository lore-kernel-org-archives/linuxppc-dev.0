Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B2D19DDF7B
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Oct 2008 00:51:05 +1000 (EST)
Message-Id: <E3BAFDF8-561A-47E9-8286-922929D908AE@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Martyn Welch <martyn.welch@gefanuc.com>
In-Reply-To: <20080930142942.28193.943.stgit@ubuntu8041.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc: GE Fanuc's FPGA based PIC controller on the
	SBC610
Date: Tue, 30 Sep 2008 09:50:58 -0500
References: <20080930142942.28193.943.stgit@ubuntu8041.localdomain>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 30, 2008, at 9:29 AM, Martyn Welch wrote:

>
> arch/powerpc/boot/dts/gef_sbc610.dts     |   38 ++++
> arch/powerpc/platforms/86xx/gef_sbc610.c |   25 +++
> arch/powerpc/sysdev/Makefile             |    2
> arch/powerpc/sysdev/gef_pic.c            |  258 +++++++++++++++++++++ 
> +++++++++
> arch/powerpc/sysdev/gef_pic.h            |   11 +

The gef_pic should really live in platforms/86xx/ since its specific  
to your board.

- k
