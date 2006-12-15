Return-Path: <svallet@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id 7AD5867BD5
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Dec 2006 06:58:16 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so905823ugf
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Dec 2006 11:58:15 -0800 (PST)
Date: Fri, 15 Dec 2006 20:58:12 +0100
From: Simon Vallet <svallet@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: atomic_clear_mask() on PPC ?
Message-ID: <20061215205812.623b68d2@mlejnas.priv.castalie.org>
In-Reply-To: <37F182F3-71D2-4A8C-84B0-A036684B447B@watson.ibm.com>
References: <6473fb3e0612150325w3c6f01b0rdd4953dc9cb6430e@mail.gmail.com>
	<37F182F3-71D2-4A8C-84B0-A036684B447B@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 15 Dec 2006 09:08:19 -0500
Jimi Xenidis <jimix@watson.ibm.com> wrote:

> powerpc 32-bit seems to have it:
>    arch/powerpc/kernel/misc_32.S _GLOBAL 742 _GLOBAL(atomic_clear_mask)

Hmmm... I guess the grep was a bit too quick : fact is I just 
looked at include/ ;-)

> Assuming its the "thing" you actually want, since atomic_t is always  
> an int, the exact same code sequence will be fine under 64bit, I  
> guess PPc64 never needed it?

Well, I'll try with this -- thanks for the info.

Simon
