Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 0E6C367BD5
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 01:37:32 +1000 (EST)
Date: Thu, 21 Sep 2006 19:37:50 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: "Li Yang" <leoli@freescale.com>
Subject: Re: [PATCH 2/11] qe_lib: Add common files
Message-ID: <20060921193750.1f98a1e3@vitb.ru.mvista.com>
In-Reply-To: <F6AD7E21CDF4E145A44F61F43EE6D9399B44FE@tmnt04.transmode.se>
References: <F6AD7E21CDF4E145A44F61F43EE6D9399B44FE@tmnt04.transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 21 Sep 2006 17:21:39 +0200
"Joakim Tjernlund" <joakim.tjernlund@transmode.se> wrote:

> > diff --git a/include/asm-powerpc/qe.h b/include/asm-powerpc/qe.h
> > +#define QE_MURAM_DATAONLY_BASE	((uint)0x0)
> > +#define QE_MURAM_NOSPACE		((uint)0x7fffffff)
> > +#define QE_MURAM_DATAONLY_SIZE	((uint)(48 * 1024) - 
> > QE_MURAM_DATAONLY_BASE)
> 
> QE_MURAM_DATAONLY_SIZE is 16*1024 on 8321
> 
> Also, you have line wrapping that has mangled all long lines in all
> patches.
> 
Definitely. That is why I gave up on thunderbird a while ago...

I'd suggest to use either STGit embedded abilities, or git-send-email (combined with git-format-patch)
if non-attached stuff is required.

-- 
Sincerely, 
Vitaly
