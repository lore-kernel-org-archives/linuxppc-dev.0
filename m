Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 99EB0DDF0D
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Oct 2008 07:54:31 +1000 (EST)
Message-Id: <398EE654-3AC7-4939-91DC-49E9520D2B18@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <1223050450-32234-1-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH v2] powerpc: make Freescale QE support a selectable
	Kconfig option
Date: Fri, 3 Oct 2008 16:54:21 -0500
References: <1223050450-32234-1-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 3, 2008, at 11:14 AM, Timur Tabi wrote:

> Modify the Kconfig so that Freescale QUICC Engine (QE) support is a  
> selectable
> option, thereby allowing users to compile kernels without any QE  
> support.
>
> The drawback is that QE support is now disabled by default on  
> platforms that
> have a QE, and so a defconfig is needed to enable QE and QE devices  
> (like
> UCC GETH).  Fortunately, all the current relevant defconfigs do that  
> already.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>
> This patch should be applied to Kumar's branch for 2.6.28 patches.
>
> arch/powerpc/platforms/83xx/Kconfig |    5 -----
> arch/powerpc/platforms/85xx/Kconfig |    1 -
> arch/powerpc/platforms/Kconfig      |    3 ++-
> 3 files changed, 2 insertions(+), 7 deletions(-)

applied

- k
