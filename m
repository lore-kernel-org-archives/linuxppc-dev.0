Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 9F19567D69
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 05:21:35 +1100 (EST)
Date: Mon, 11 Dec 2006 12:20:41 -0600
From: Olof Johansson <olof@lixom.net>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: Re: [PATCH 4/6] [POWERPC] 8xx: powerpc port of core CPM, CPM PIC, etc.
Message-ID: <20061211122041.21b1037d@pb15>
In-Reply-To: <20061211162848.17227.91021.stgit@localhost.localdomain>
References: <20061211192347.47700906@localhost.localdomain>
	<20061211162848.17227.91021.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Mon, 11 Dec 2006 19:28:48 +0300 Vitaly Bordug <vbordug@ru.mvista.com> wrote:

> This covers common CPM access functions, CPM interrupt controller code,
> micropatch and a few compatibility things to kee the same driver base
> working with arch/ppc. This version is refined with all the comments
> (mostly PIC-related) addressed.
> 
> Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
> ---
> 
>  arch/powerpc/sysdev/Makefile     |    2 
>  arch/powerpc/sysdev/commproc.c   |  398 ++++++++++++++++++++
>  arch/powerpc/sysdev/micropatch.c |  743 ++++++++++++++++++++++++++++++++++++++
>  arch/powerpc/sysdev/mpc8xx_pic.c |  197 ++++++++++
>  arch/powerpc/sysdev/mpc8xx_pic.h |   12 +
>  include/asm-powerpc/fs_pd.h      |   44 ++
>  include/asm-powerpc/mpc8xx.h     |   24 +
>  include/asm-powerpc/time.h       |    2 
>  8 files changed, 1412 insertions(+), 10 deletions(-)

Are these devices common for more platforms than 8xx? The 8xx in the
filenames seems to indicate that they're not.

If so, shouldn't the drivers go under platforms/8xx instead?


-Olof
