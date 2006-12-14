Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3FD8B67C58
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 12:35:46 +1100 (EST)
Date: Thu, 14 Dec 2006 10:35:36 +0900 (JST)
Message-Id: <200612140135.kBE1Zb0f028635@toshiba.co.jp>
To: geoffrey.levand@am.sony.com
Subject: Re: [PATCH 4/15] celleb: interfaces to the hypervisor of Celleb
In-Reply-To: <457EE768.6040606@am.sony.com>
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Ishizaki Kou wrote:
> > This patch creates Celleb platform dependent file which adds interfaces
> > to call hypervisor.
> > 
> > Signed-off-by: Kou Ishizaki <kou.ishizaki.co.jp>
> > ---
> > 
> > Index: linux-powerpc-git/arch/powerpc/platforms/celleb/beat_sys.h
> > diff -u /dev/null linux-powerpc-git/arch/powerpc/platforms/celleb/beat_sys.h:1.1
> > --- /dev/null     Mon Dec 11 20:37:33 2006
> > +++ linux-powerpc-git/arch/powerpc/platforms/celleb/beat_sys.h	Wed Dec  6 08:43:15 2006
> ...
> > +static inline int64_t beat_allocate_memory(uint64_t __in0, uint64_t __in1, uint64_t __in2, uint64_t __in3,void** __out0,uint64_t* __out1) {


> These at least need to be re-formated to meet the 80 char
> width limit.

I see.
Because this file is machine-generated from our hypervisor call
table, we have to fix file generator.

We have rewritten hypervisor calls in assembly language.
They'll be posted in next time.

> In general though, we need to work out a common hcall mechanism
> for all the hypevisors.

Agreed.

Best regards,
Kou Ishizaki
