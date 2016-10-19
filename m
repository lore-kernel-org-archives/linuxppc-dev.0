Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3szRQz6xWjzDt0w
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2016 20:26:51 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id 128so1985833pfz.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2016 02:26:51 -0700 (PDT)
Date: Wed, 19 Oct 2016 20:26:44 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 6/7] powerpc: switch to using thin archives if
 COMPILE_TEST is set
Message-ID: <20161019202644.572f7eb3@roar.ozlabs.ibm.com>
In-Reply-To: <20161019165723.7fda6701@canb.auug.org.au>
References: <20161019031600.17933-1-npiggin@gmail.com>
 <20161019031600.17933-7-npiggin@gmail.com>
 <20161019165723.7fda6701@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 19 Oct 2016 16:57:23 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi Nick,
> 
> On Wed, 19 Oct 2016 14:15:59 +1100 Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > Enable thin archives build for powerpc when COMPILE_TEST is set.
> > Thin archives are explained in this commit:
> > 
> >   a5967db9af51a84f5e181600954714a9e4c69f1f  
> 
> This reference should be like this:
> 
>   a5967db9af51 ("kbuild: allow architectures to use thin archives instead of ld -r")
> 

Hi Stephen,

Good point, I'll change it.

Thanks,
Nick
