Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B19F0679FF
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Jul 2006 01:16:57 +1000 (EST)
In-Reply-To: <20060630185542.102af583.kim.phillips@freescale.com>
References: <20060630185542.102af583.kim.phillips@freescale.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D3DE039C-5E92-4A28-8485-4057C598661D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Documentation: correct values in MPC5848E SEC example node
Date: Sat, 1 Jul 2006 10:16:50 -0500
To: Kim Phillips <kim.phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The patch still had typo issues in the comments.  5848 -> 8548.

- k

On Jun 30, 2006, at 6:55 PM, Kim Phillips wrote:

> (this patch had apparently slipped through the cracks)
>
> Documentation: correct values in MPC5848E SEC example node
>
> ---
> commit 27ef8f30208ceb62c5387e834a335558e7e88c70
> tree e96c74f732489115651ea00d0514e66e8050c60a
> parent 1f4a90670bacbf61f2fcc19a9e0e78748c932a25
> author Kim Phillips <kim.phillips@freescale.com> Tue, 02 May 2006  
> 11:38:23 -0500
> committer Kim Phillips <kim.phillips@freescale.com> Tue, 02 May  
> 2006 11:38:23 -0500
>
>  Documentation/powerpc/booting-without-of.txt |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/powerpc/booting-without-of.txt b/ 
> Documentation/powerpc/booting-without-of.txt
> index 217e517..3c62e66 100644
> --- a/Documentation/powerpc/booting-without-of.txt
> +++ b/Documentation/powerpc/booting-without-of.txt
> @@ -1436,9 +1436,9 @@ platforms are moved over to use the flat
>                 interrupts = <1d 3>;
>                 interrupt-parent = <40000>;
>                 num-channels = <4>;
> -               channel-fifo-len = <24>;
> +               channel-fifo-len = <18>;
>                 exec-units-mask = <000000fe>;
> -               descriptor-types-mask = <073f1127>;
> +               descriptor-types-mask = <012b0ebf>;
>         };
>
>
