Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from mail95-dub-R.bigfish.com (mail-dub.bigfish.com [213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C6C8867BE7
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 04:31:30 +1100 (EST)
Message-ID: <457EE768.6040606@am.sony.com>
Date: Tue, 12 Dec 2006 09:31:20 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Subject: Re: [PATCH 4/15] celleb: interfaces to the hypervisor of Celleb
References: <200612120323.kBC3NjEW004119@toshiba.co.jp>
In-Reply-To: <200612120323.kBC3NjEW004119@toshiba.co.jp>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ishizaki Kou wrote:
> This patch creates Celleb platform dependent file which adds interfaces
> to call hypervisor.
> 
> Signed-off-by: Kou Ishizaki <kou.ishizaki.co.jp>
> ---
> 
> Index: linux-powerpc-git/arch/powerpc/platforms/celleb/beat_sys.h
> diff -u /dev/null linux-powerpc-git/arch/powerpc/platforms/celleb/beat_sys.h:1.1
> --- /dev/null	Mon Dec 11 20:37:33 2006
> +++ linux-powerpc-git/arch/powerpc/platforms/celleb/beat_sys.h	Wed Dec  6 08:43:15 2006
...
> +static inline int64_t beat_allocate_memory(uint64_t __in0, uint64_t __in1, uint64_t __in2, uint64_t __in3,void** __out0,uint64_t* __out1) {


These at least need to be re-formated to meet the 80 char
width limit.

In general though, we need to work out a common hcall mechanism
for all the hypevisors.

-Geoff
