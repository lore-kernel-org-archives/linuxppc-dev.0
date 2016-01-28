Return-Path: <heiko.carstens@de.ibm.com>
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B58C1A030F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jan 2016 02:27:59 +1100 (AEDT)
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <heiko.carstens@de.ibm.com>;
 Thu, 28 Jan 2016 15:27:56 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id CF204219005C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2016 15:27:41 +0000 (GMT)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0SFRsXA852286
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2016 15:27:54 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0SFRrcA026601
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2016 08:27:54 -0700
Date: Thu, 28 Jan 2016 16:27:51 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 Joe Perches <joe@perches.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Amitkumar Karwar <akarwar@marvell.com>,
 Nishant Sarmukadam <nishants@marvell.com>,
 Kalle Valo <kvalo@codeaurora.org>, Steve French <sfrench@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] param: convert some "on"/"off" users to strtobool
Message-ID: <20160128152751.GB3926@osiris>
References: <1453990627-19164-1-git-send-email-keescook@chromium.org>
 <1453990627-19164-4-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1453990627-19164-4-git-send-email-keescook@chromium.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 28, 2016 at 06:17:07AM -0800, Kees Cook wrote:
> This changes several users of manual "on"/"off" parsing to use strtobool.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Cc: x86@kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-s390@vger.kernel.org
> ---
>  arch/powerpc/kernel/rtasd.c                  | 10 +++-------
>  arch/powerpc/platforms/pseries/hotplug-cpu.c | 11 +++--------
>  arch/s390/kernel/time.c                      |  8 ++------
>  arch/s390/kernel/topology.c                  |  8 +++-----
>  arch/x86/kernel/aperture_64.c                | 13 +++----------
>  include/linux/tick.h                         |  2 +-
>  kernel/time/hrtimer.c                        | 11 +++--------
>  kernel/time/tick-sched.c                     | 11 +++--------
>  8 files changed, 21 insertions(+), 53 deletions(-)

For the s390 bits:

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
