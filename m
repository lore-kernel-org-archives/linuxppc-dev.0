Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0008.hostedemail.com
 [216.40.44.8])
 by lists.ozlabs.org (Postfix) with ESMTP id AE8151A0024
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 05:25:52 +1100 (AEDT)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave06.hostedemail.com (Postfix) with ESMTP id 3DC821725D3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Feb 2015 18:16:00 +0000 (UTC)
Message-ID: <1424024154.2685.1.camel@perches.com>
Subject: Re: [PATCH net-next 1/6] ppc: Kconfig: Enable BPF JIT on ppc32
From: Joe Perches <joe@perches.com>
To: Denis Kirjanov <kda@linux-powerpc.org>
Date: Sun, 15 Feb 2015 10:15:54 -0800
In-Reply-To: <1424023605-2416-2-git-send-email-kda@linux-powerpc.org>
References: <1424023605-2416-1-git-send-email-kda@linux-powerpc.org>
 <1424023605-2416-2-git-send-email-kda@linux-powerpc.org>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2015-02-15 at 21:06 +0300, Denis Kirjanov wrote:
[]
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
[]
> @@ -126,7 +126,7 @@ config PPC
>  	select IRQ_FORCED_THREADING
>  	select HAVE_RCU_TABLE_FREE if SMP
>  	select HAVE_SYSCALL_TRACEPOINTS
> -	select HAVE_BPF_JIT if PPC64
> +	select HAVE_BPF_JIT

trivia:

Should this be the last patch of the series?
