Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3szTVb3G3MzDt4V
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2016 22:00:07 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 6/7] powerpc: switch to using thin archives if
 COMPILE_TEST is set
In-Reply-To: <20161019031600.17933-7-npiggin@gmail.com>
References: <20161019031600.17933-1-npiggin@gmail.com>
 <20161019031600.17933-7-npiggin@gmail.com>
Date: Wed, 19 Oct 2016 22:00:06 +1100
Message-ID: <87wph44n9l.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> Enable thin archives build for powerpc when COMPILE_TEST is set.
> Thin archives are explained in this commit:
>
>   a5967db9af51a84f5e181600954714a9e4c69f1f
>
> This is a gradual way to introduce the option to testers.

I think I'd rather this was actually a user-selectable option, eg.

config USE_THIN_ARCHIVES
	bool "Build the kernel using thin archives"
        default n
	select THIN_ARCHIVES
	help
	  Build the kernel using thin archives.
	  If you're unsure say N.


cheers
