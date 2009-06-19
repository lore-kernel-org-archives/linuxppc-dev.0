Return-Path: <mingo@elte.hu>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 508EFB7243
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 20 Jun 2009 02:27:31 +1000 (EST)
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CC0BEDDD1B
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Jun 2009 02:27:30 +1000 (EST)
Date: Fri, 19 Jun 2009 18:27:18 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 6/6] perf_counter: tools: Makefile tweaks for 64-bit
	powerpc
Message-ID: <20090619162718.GB15197@elte.hu>
References: <19000.55404.103840.393470@cargo.ozlabs.ibm.com>
	<19000.55666.866148.559620@cargo.ozlabs.ibm.com>
	<20090618091334.GB21191@elte.hu>
	<19003.18793.605755.277949@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19003.18793.605755.277949@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Paul Mackerras <paulus@samba.org> wrote:

> Ingo Molnar writes:
> 
> > Note, i left out this bit from the commit - we need to find a 
> > better solution than to allow ugly warnings on PowerPC.
> > 
> > Could we use the kernel's u64 type directly perhaps? That would 
> > allow us to change all __u64 to u64 in all of tools/perf/ which 
> > is a nice clean-up in any case.
> 
> This is userspace, we can use "u64" however we like. :) I'll cook 
> up a patch to add "typedef unsigned long long u64" and change 
> __u64 to u64.

Thanks, i've applied the patch. Note, it crossed with a few changes 
from Peter - i fixed up the conflicts - please double check whether 
it's still fine on PowerPC too.

	Ingo
