Return-Path: <a.p.zijlstra@chello.nl>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3BBB4B7097
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 27 Jun 2009 18:40:19 +1000 (EST)
Received: from viefep19-int.chello.at (viefep19-int.chello.at [62.179.121.39])
	by ozlabs.org (Postfix) with ESMTP id EC979DDD01
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jun 2009 18:40:17 +1000 (EST)
Subject: Re: [PATCH 2/2] perf_counter: powerpc: Add callchain support
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <19013.44722.893263.275594@cargo.ozlabs.ibm.com>
References: <19013.44646.549261.100582@cargo.ozlabs.ibm.com>
	<19013.44722.893263.275594@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Sat, 27 Jun 2009 10:34:44 +0200
Message-Id: <1246091684.31755.210.camel@twins>
Mime-Version: 1.0
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2009-06-27 at 15:31 +1000, Paul Mackerras wrote:
> +       if (regs) {
> +               if (current_is_64bit())
> +                       perf_callchain_user_64(regs, entry);
> +               else
> +                       perf_callchain_user_32(regs, entry);
> +       }

Ingo do we need 32 on 64 stuff like that too?
