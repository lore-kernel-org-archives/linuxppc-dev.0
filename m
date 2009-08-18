Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 16BE6B7B75
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 18 Aug 2009 14:23:58 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 56055DDD0B
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Aug 2009 14:23:57 +1000 (EST)
Subject: Re: [PATCH 3/3 v3] perf_counter: powerpc: Add callchain support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <19081.57647.221116.68329@cargo.ozlabs.ibm.com>
References: <19081.57584.173693.798535@cargo.ozlabs.ibm.com>
	<19081.57647.221116.68329@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Tue, 18 Aug 2009 14:23:49 +1000
Message-Id: <1250569429.19007.19.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-08-18 at 09:01 +1000, Paul Mackerras wrote:
> This adds support for tracing callchains for powerpc, both 32-bit
> and 64-bit, and both in the kernel and userspace, from PMU interrupt
> context.

> Signed-off-by: Paul Mackerras <paulus@samba.org>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
