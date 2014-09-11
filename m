Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 69A391A005A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Sep 2014 07:50:32 +1000 (EST)
Date: Fri, 12 Sep 2014 07:50:31 +1000
From: Anton Blanchard <anton@samba.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 6/6] powerpc: Separate ppc32 symbol exports into
 ppc_ksyms_32.c
Message-ID: <20140912075031.49059205@kryten>
In-Reply-To: <20140823012509.37afb89e@canb.auug.org.au>
References: <1408485605-10490-1-git-send-email-anton@samba.org>
 <1408485605-10490-6-git-send-email-anton@samba.org>
 <20140823012509.37afb89e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Stephen,

> You removed export.h ...
> 
> > +EXPORT_SYMBOL(flush_dcache_range);
> > +EXPORT_SYMBOL(flush_icache_range);
> 
> But still use EXPORT_SYMBOL ...

Thanks, fixed!

Anton
