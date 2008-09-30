Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id DD7CE474C1
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Oct 2008 03:25:43 +1000 (EST)
Date: Tue, 30 Sep 2008 21:25:40 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Mohan Kumar M <mohan@in.ibm.com>
Subject: Re: [PATCH] Remove legacy kdump kernel build support
Message-ID: <20080930172540.GA21378@oksana.dev.rtsoft.ru>
References: <20080930124828.GA1945@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20080930124828.GA1945@in.ibm.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, paulus@samba.org,
	kexec@lists.infradead.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 30, 2008 at 06:18:28PM +0530, Mohan Kumar M wrote:
> Remove legacy kdump kernel build support
> 
> This patch removes legacy kdump kernel build support(i.e compiling  a
> kdump kernel at a fixed hardcoded address 32MB). With the relocatable
> kernel support its now possible to use the regular kernel binary for
> capturing the dump also. Relocatable kdump kernel does not require
> trampoline code for exception handlers. It removes kdump.h as most of the
> macros defined in kdump.h are not used any more. Also the relocatable
> kdump kernel allows us to load kdump kernel any where as specified by
> crashkernel parameter instead of hardcoded address 32MB.

Can we leave the legacy support for a while? On PPC32 we don't have
the relocatable kernel support, but we have kdump patches floating
around[1], and they use the `hard-coded values' approach, so far.

I'm not sure if anybody is currently working on a PPC32 kernel
relocation support.. but for sure it will take some time to implement.

Thanks,

[1] http://ozlabs.org/pipermail/linuxppc-dev/2008-August/061161.html

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
