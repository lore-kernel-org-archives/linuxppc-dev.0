Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3szvtN29Z7zDsxk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 14:48:44 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id r16so4180078pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2016 20:48:44 -0700 (PDT)
Date: Thu, 20 Oct 2016 14:48:37 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 6/7] powerpc: switch to using thin archives if
 COMPILE_TEST is set
Message-ID: <20161020144837.42fb443b@roar.ozlabs.ibm.com>
In-Reply-To: <87wph44n9l.fsf@concordia.ellerman.id.au>
References: <20161019031600.17933-1-npiggin@gmail.com>
 <20161019031600.17933-7-npiggin@gmail.com>
 <87wph44n9l.fsf@concordia.ellerman.id.au>
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

On Wed, 19 Oct 2016 22:00:06 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > Enable thin archives build for powerpc when COMPILE_TEST is set.
> > Thin archives are explained in this commit:
> >
> >   a5967db9af51a84f5e181600954714a9e4c69f1f
> >
> > This is a gradual way to introduce the option to testers.  
> 
> I think I'd rather this was actually a user-selectable option, eg.
> 
> config USE_THIN_ARCHIVES
> 	bool "Build the kernel using thin archives"
>         default n
> 	select THIN_ARCHIVES
> 	help
> 	  Build the kernel using thin archives.
> 	  If you're unsure say N.

Okay, that should be easy. I'll respin the series.

Thanks,
Nick
