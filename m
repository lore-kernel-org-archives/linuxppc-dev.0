Return-Path: <bunk@stusta.de>
Received: from mailhub.stusta.mhn.de (emailhub.stusta.mhn.de [141.84.69.5])
	by ozlabs.org (Postfix) with ESMTP id 29D6FDDE03
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 23:38:33 +1000 (EST)
Date: Tue, 17 Jul 2007 15:37:53 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] remove awacs dmasound
Message-ID: <20070717133752.GC3801@stusta.de>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
	<1184678911.27780.5.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1184678911.27780.5.camel@johannes.berg>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 17, 2007 at 03:28:31PM +0200, Johannes Berg wrote:
> This patch kills the obsolete awacs dmasound because it is in
> the way of doing power management improvements since it uses
> ancient API.
> 
> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Adrian Bunk <bunk@stusta.de>
> 
> ---
> This patch contains only the patch for the first two files here, please
> remove the other ones manually:
> 
> git rm -- sound/oss/dmasound/awacs_defs.h
> git rm -- sound/oss/dmasound/dac3550a.c
> git rm -- sound/oss/dmasound/dmasound_awacs.c
> git rm -- sound/oss/dmasound/tas3001c.c
> git rm -- sound/oss/dmasound/tas3001c.h
> git rm -- sound/oss/dmasound/tas3001c_tables.c
> git rm -- sound/oss/dmasound/tas3004.c
> git rm -- sound/oss/dmasound/tas3004.h
> git rm -- sound/oss/dmasound/tas3004_tables.c
> git rm -- sound/oss/dmasound/tas_common.c
> git rm -- sound/oss/dmasound/tas_common.h
> git rm -- sound/oss/dmasound/tas_eq_prefs.h
> git rm -- sound/oss/dmasound/tas_ioctl.h
> git rm -- sound/oss/dmasound/trans_16.c
> 
>  sound/oss/dmasound/Kconfig           |   14 

That's not in your patch, most likely because it's already removed as 
scheduled.

>  sound/oss/dmasound/Makefile          |    6 
>  sound/oss/dmasound/awacs_defs.h      |  251 --
>  sound/oss/dmasound/dac3550a.c        |  209 --
>  sound/oss/dmasound/dmasound_awacs.c  | 3215 -----------------------------------
>  sound/oss/dmasound/tas3001c.c        |  849 ---------
>  sound/oss/dmasound/tas3001c.h        |   64 
>  sound/oss/dmasound/tas3001c_tables.c |  375 ----
>  sound/oss/dmasound/tas3004.c         | 1138 ------------
>  sound/oss/dmasound/tas3004.h         |   77 
>  sound/oss/dmasound/tas3004_tables.c  |  301 ---
>  sound/oss/dmasound/tas_common.c      |  214 --
>  sound/oss/dmasound/tas_common.h      |  284 ---
>  sound/oss/dmasound/tas_eq_prefs.h    |   24 
>  sound/oss/dmasound/tas_ioctl.h       |   24 
>  sound/oss/dmasound/trans_16.c        |  898 ---------
>  16 files changed, 7943 deletions(-)
>...

The option is already removed from the Kconfig file, and the code 
removal is scheduled for 2.6.24. I'll take care of this (I'll send
a patch through Andrew).

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
