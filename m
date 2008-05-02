Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 96CEADDDEE
	for <linuxppc-dev@ozlabs.org>; Fri,  2 May 2008 21:54:26 +1000 (EST)
In-Reply-To: <Pine.LNX.4.64.0805020311310.28690@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0805020311310.28690@blarg.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <bfc75e2dc32ba86b93751cb21df97e56@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Fix bootwrapper builds with newer gcc versions
Date: Fri, 2 May 2008 13:54:15 +0200
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> GCC 4.4.x looks to be adding support for generating out-of-line 
> register
> saves/restores based on:
>
> http://gcc.gnu.org/ml/gcc-patches/2008-04/msg01678.html
>
> This breaks the bootwrapper as we'd need to link with libgcc to get the
> implementation of the register save/restores.
>
> To workaround this issue, we just stole the save/restore code from gcc
> and simplified it down for our needs (integer only).

Why can't we link with libgcc, instead?


Segher
