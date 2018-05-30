Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wtXp1llVzDr69
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2018 00:39:54 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linux-kbuild@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
 linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v5 0/4] powerpc patches for new Kconfig language
In-Reply-To: <20180530121922.22122-1-npiggin@gmail.com>
References: <20180530121922.22122-1-npiggin@gmail.com>
Date: Thu, 31 May 2018 00:39:47 +1000
Message-ID: <87o9gxyzpo.fsf@concordia.ellerman.id.au>
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

> This series of patches improves th powerpc kbuild system. The
> motivation was to to be compatible with the new Kconfig scripting
> language that Yamada-san has implemented here for merge:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git/log/?h=kconfig
>
> I have tested on top of that tree, powerpc now builds there.
>
> To avoid build breakage, the first 3 patches must go before the
> kconfig change, and the 4th patch must go after it.
>
> v5 changes:
> - Patch 4 update to syntax changed since kconfig-shell-v3 release.
> - Patch 4 suggestions from Masahiro Yamada, remove unnecessary "OK"
>   output from check mprofile script, and fold CC_USING_MPROFILE_KERNEL
>   into CONFIG_MPROFILE_KERNEL.
> - Reduce whitespace disturbance in patch 1.

I've put this series in a topic branch.

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/log/?h=topic/kbuild


I'll plan to merge the first three into the powerpc tree.

Masahiro, are you planning to merge your kconfig changes for 4.18? If so
you could merge the whole branch and everything should merge nicely.

cheers
