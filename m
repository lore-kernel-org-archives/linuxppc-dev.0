Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D8DC3DE88A
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 03:44:28 +1100 (EST)
Message-Id: <659A0204-FBEE-4415-9E38-36FC92FFDA7F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Martyn Welch <martyn.welch@gefanuc.com>
In-Reply-To: <20081013151537.19033.25006.stgit@ubuntu8041.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH v3] powerpc: FPGA support for GE Fanuc SBC610
Date: Mon, 13 Oct 2008 11:44:16 -0500
References: <20081013151537.19033.25006.stgit@ubuntu8041.localdomain>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 13, 2008, at 10:16 AM, Martyn Welch wrote:

> Support for the SBC610 VPX Single Board Computer from GE Fanuc  
> (PowerPC
> MPC8641D).
>
> This patch adds support for the registers held in the devices main  
> FPGA,
> exposing extra information about the revision of the board through  
> cpuinfo.
>
> Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
> ---
>
> Stephen: Thanks for spotting that error.
>
> New to rev 3:
> * Added of_node_put()
>
> arch/powerpc/boot/dts/gef_sbc610.dts     |    4 +++
> arch/powerpc/platforms/86xx/gef_sbc610.c |   40 +++++++++++++++++++++ 
> +++++++++
> 2 files changed, 44 insertions(+), 0 deletions(-)

applied.

- k
