Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id E1954DDE18
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 14:48:42 +1100 (EST)
Date: Thu, 14 Feb 2008 14:46:21 +1100
To: Manish Ahuja <ahuja@austin.ibm.com>
Subject: Re: [PATCH 2/8] pseries: phyp dump: reserve-release proof-of-concept
Message-ID: <20080214034621.GA6887@bakeyournoodle.com>
References: <47B13D2E.1070001@austin.ibm.com> <47B145E9.9020907@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <47B145E9.9020907@austin.ibm.com>
From: tony@bakeyournoodle.com (Tony Breeds)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 12, 2008 at 01:08:25AM -0600, Manish Ahuja wrote:
> 
> Initial patch for reserving memory in early boot, and freeing it later.
> If the previous boot had ended with a crash, the reserved memory would contain
> a copy of the crashed kernel data.
> 
> Signed-off-by: Manish Ahuja <mahuja@us.ibm.com>
> Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
> 
> ----
>  arch/powerpc/kernel/prom.c                 |   50 ++++++++++++++++++++
>  arch/powerpc/kernel/rtas.c                 |   32 +++++++++++++
>  arch/powerpc/platforms/pseries/Makefile    |    1 
>  arch/powerpc/platforms/pseries/phyp_dump.c |   71 +++++++++++++++++++++++++++++
>  include/asm-powerpc/phyp_dump.h            |   38 +++++++++++++++
>  include/asm/rtas.h                         |    3 +
>  6 files changed, 195 insertions(+)
> 
> Index: 2.6.24-rc5/include/asm-powerpc/phyp_dump.h
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ 2.6.24-rc5/include/asm-powerpc/phyp_dump.h	2008-02-12 06:12:37.000000000 -0600
> @@ -0,0 +1,38 @@
> +/*
> + * Hypervisor-assisted dump
> + *
> + * Linas Vepstas, Manish Ahuja 2007
> + * Copyright (c) 2007 IBM Corp.

Hi Manish,
	Sorry for the minor nits but this should be:

---
 * Linas Vepstas, Manish Ahuja 2008
 * Copyright 2008 IBM Corp.
---

You can optionally use the '©' symbol after word 'Copyright' but you
shouldn't use '(c)' anymore.

Also in at least one place you've misspelt "Copyright"

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
