Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 9CFB767D6A
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 05:20:48 +1100 (EST)
Date: Mon, 11 Dec 2006 21:20:57 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] [POWERPC] Fix kernel build errors for mpc8272ads and
	mpc8560ads.
Message-ID: <20061211212057.285791e6@vitb.ru.mvista.com>
In-Reply-To: <20061211181226.18108.86788.stgit@localhost.localdomain>
References: <20061211181226.18108.86788.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 11 Dec 2006 21:12:26 +0300
Vitaly Bordug <vbordug@ru.mvista.com> wrote:

> 
> Recent update of asm-powerpc/io.h caused cpm-related stuff to break in the
> current kernel. Current patch fixes it, and includes other overhaul and
> improvements (incomplete list is below). Required for proper functioning of
> the 8xx stuff as well.
> 
> - Updated dts with a chosen node with interrupt controller, 
> - fixed messed device IDs among CPM2 SoC devices, 
> - corrected odd header name and fixed type in defines,
> - Added 82xx subdir to the powerpc/platforms Makefile, new
>   solely-powerpc header for 8260 family (was using one from arch/ppc, this
>   one cleaned up from the extra stuff).
> ---
Just noticed last 3 patches came out without Signed-off-by: for some reason.
Hence, I'll resend, sorry about that.

-- 
Sincerely, 
Vitaly
