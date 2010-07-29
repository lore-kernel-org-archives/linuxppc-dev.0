Return-Path: <horms@verge.net.au>
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
	by ozlabs.org (Postfix) with ESMTP id A63FCB70B2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 29 Jul 2010 18:33:28 +1000 (EST)
Date: Thu, 29 Jul 2010 17:33:25 +0900
From: Simon Horman <horms@verge.net.au>
To: Matthew McClintock <msm@freescale.com>
Subject: Re: [PATCH v2 5/7] Add support for ramdisk on ppc32 for uImage-ppc
	and Elf-ppc
Message-ID: <20100729083324.GC10021@verge.net.au>
References: <1279656900-27458-1-git-send-email-msm@freescale.com>
	<1279656900-27458-2-git-send-email-msm@freescale.com>
	<1279656900-27458-3-git-send-email-msm@freescale.com>
	<1279656900-27458-4-git-send-email-msm@freescale.com>
	<1279656900-27458-5-git-send-email-msm@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1279656900-27458-5-git-send-email-msm@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 20, 2010 at 03:14:58PM -0500, Matthew McClintock wrote:
> This fixes --reuseinitrd and --ramdisk option for ppc32 on
> uImage-ppc and Elf. It works for normal kexec as well as for
> kdump.
> 
> When using --reuseinitrd you need to specifify retain_initrd
> on the command line. Also, if you are doing kdump you need to make
> sure your initrd lives in the crashdump region otherwise the
> kdump kernel will not be able to access it. The --ramdisk option
> should always work.

Thanks, I have applied this change.
I had to do a minor merge on the Makefile,
could you verify that the result is correct?
