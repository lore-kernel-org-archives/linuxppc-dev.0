Return-Path: <jwboyer@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.237])
	by ozlabs.org (Postfix) with ESMTP id 7FC47DE7B4
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 01:29:00 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id c48so69826wra.1
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 08:28:58 -0700 (PDT)
Subject: Re: [PATCH] Remove experimental status of kdump on PPC64
From: Josh Boyer <jwboyer@gmail.com>
To: Bernhard Walle <bwalle@suse.de>
In-Reply-To: <1214485035-26041-1-git-send-email-bwalle@suse.de>
References: <1214485035-26041-1-git-send-email-bwalle@suse.de>
Content-Type: text/plain
Date: Thu, 26 Jun 2008 11:28:52 -0400
Message-Id: <1214494132.2791.0.camel@weaponx>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, vgoyal@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-06-26 at 14:57 +0200, Bernhard Walle wrote:
> This patch removes the experimental status of kdump on IA64. kdump is on IA64
> now since more than one year and it has proven to be stable.

I think you mean PPC64?

josh

> For i386/x86_64, a similar patch has been accepted by Ingo Molnar and Vivek
> Goyal.
> 
> 
> Signed-off-by: Bernhard Walle <bwalle@suse.de>
> ---
>  arch/powerpc/Kconfig |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 3934e26..2a116b9 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -308,8 +308,8 @@ config KEXEC
>  	  strongly in flux, so no good recommendation can be made.
>  
>  config CRASH_DUMP
> -	bool "Build a kdump crash kernel (EXPERIMENTAL)"
> -	depends on PPC_MULTIPLATFORM && PPC64 && EXPERIMENTAL
> +	bool "Build a kdump crash kernel"
> +	depends on PPC_MULTIPLATFORM && PPC64
>  	help
>  	  Build a kernel suitable for use as a kdump capture kernel.
>  	  The kernel will be linked at a different address than normal, and
