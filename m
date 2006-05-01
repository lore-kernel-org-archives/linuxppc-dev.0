Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (71-214-132-244.roch.qwest.net
	[71.214.132.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3B39667B53
	for <linuxppc-dev@ozlabs.org>; Tue,  2 May 2006 09:33:18 +1000 (EST)
Subject: Re: ioremap
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: Srinivas Murthy <codevana@gmail.com>
In-Reply-To: <7cb1293c0605011425w1cc34197h4d5fa73ad1077d5a@mail.gmail.com>
References: <7cb1293c0605011425w1cc34197h4d5fa73ad1077d5a@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 01 May 2006 17:45:34 -0500
Message-Id: <1146523534.3697.3.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-05-01 at 14:25 -0700, Srinivas Murthy wrote:
> Hi,
>  Why does ioremap() not allow normal system RAM to be mapped in using
> ioremap().
>  
>  We have a need to access a portion of the normal system RAM to be
> mapped in non-cached.
>  
>  To simulate, I used kmalloc() to allocate the memory and then passed
> the virt_to_phys() of the memory to ioremap() but then noticed that
> ioremap() wont allow it.
>  
>  Is there another way to access this memory non-cached?

Limit the amount of memory the kernel consumes using mem=XXM.  Then you
should be able to use ioremap on the remainder.

josh
