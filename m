Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7C0A41A05FC
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Dec 2014 12:09:05 +1100 (AEDT)
Date: Mon, 8 Dec 2014 09:16:22 +1100
From: Paul Mackerras <paulus@samba.org>
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Subject: Re: [PATCH] arch: powerpc: kernel: sys_ppc32.c:  Remove unused
 function
Message-ID: <20141207221622.GA11372@iris.ozlabs.ibm.com>
References: <1417975014-13883-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1417975014-13883-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Dec 07, 2014 at 06:56:54PM +0100, Rickard Strandqvist wrote:
> Remove the function compat_sys_mmap2() that is not used anywhere.

It's referenced in 64-bit kernels from arch/powerpc/kernel/systbl.S,
via the SYS32ONLY(mmap2) line in arch/powerpc/include/asm/systbl.h.

Paul.
