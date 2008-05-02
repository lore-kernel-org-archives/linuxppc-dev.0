Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.180])
	by ozlabs.org (Postfix) with ESMTP id 67AB1DDE1D
	for <linuxppc-dev@ozlabs.org>; Fri,  2 May 2008 22:13:59 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id z59so1653468pyg.27
	for <linuxppc-dev@ozlabs.org>; Fri, 02 May 2008 05:13:58 -0700 (PDT)
Subject: Re: [PATCH] [POWERPC] Fix bootwrapper builds with newer gcc versions
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.64.0805020311310.28690@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0805020311310.28690@blarg.am.freescale.net>
Content-Type: text/plain
Date: Fri, 02 May 2008 07:13:55 -0500
Message-Id: <1209730435.2946.160.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: jwboyer@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-05-02 at 03:11 -0500, Kumar Gala wrote:
> GCC 4.4.x looks to be adding support for generating out-of-line register
> saves/restores based on:
> 
> http://gcc.gnu.org/ml/gcc-patches/2008-04/msg01678.html
> 
> This breaks the bootwrapper as we'd need to link with libgcc to get the
> implementation of the register save/restores.

We don't link with libgcc anywhere in the kernel.  Is this going to have
similar impacts for building the vmlinux itself?

What are they actually error messages you see with that version of GCC,
out of curiosity?

josh
