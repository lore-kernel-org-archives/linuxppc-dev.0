Return-Path: <mingo@elte.hu>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C6AE0B7227
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Jun 2009 00:22:02 +1000 (EST)
Received: from mx3.mail.elte.hu (mx3.mail.elte.hu [157.181.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 526F4DDDA2
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jun 2009 00:22:01 +1000 (EST)
Date: Wed, 17 Jun 2009 16:21:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/6] perf_counter: powerpc: Enable use of software
	counters on 32-bit powerpc
Message-ID: <20090617142151.GB6846@elte.hu>
References: <19000.55404.103840.393470@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19000.55404.103840.393470@cargo.ozlabs.ibm.com>
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

> This depends on the generic atomic64_t patches, which are now in 
> Linus' tree.  Ingo, if you're putting these in, please pull Linus' 
> tree in first.

Note, i've created a new branch, tip:perfcounters/powerpc, so we can 
keep these things separate and Ben can pull them too. I see there 
was some review feedback - do you want to send a v2 version perhaps?

	Ingo
