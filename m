Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net
	[151.189.21.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8815ADDEF2
	for <linuxppc-dev@ozlabs.org>; Sat, 26 May 2007 00:05:30 +1000 (EST)
In-Reply-To: <20070525031917.GC13575@localhost.localdomain>
References: <20070525031917.GC13575@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f10ea4097b7f0341dbe4e8a606abd81d@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Fix compiler/assembler flags for Ebony platform boot files
Date: Fri, 25 May 2007 16:05:24 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> The recent addition of assembler flags for 44x.c and ebony.c in the
> bootwrapper to make them compile on certain toolchains was not correct
> and could break other platforms.  This patch switches to using a
> compiler flag instead, which implies the appropriate assembler flag,
> and also stops the compiler itself generating instructions which are
> invalid for the platform in question.
>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Acked-by: Segher Boessenkool <segher@kernel.crashing.org>
