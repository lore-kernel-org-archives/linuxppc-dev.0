Return-Path: <mingo@elte.hu>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 867ECB70E7
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 14 Jun 2009 07:16:57 +1000 (EST)
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 16386DDD0B
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Jun 2009 07:16:56 +1000 (EST)
Date: Sat, 13 Jun 2009 23:16:45 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Mackerras <paulus@samba.org>,
	Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH RFC] powerpc: perf_counter: Enable use of software
	counters on 32-bit powerpc
Message-ID: <20090613211645.GA21611@elte.hu>
References: <18995.39910.109998.926269@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18995.39910.109998.926269@cargo.ozlabs.ibm.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Paul Mackerras <paulus@samba.org> wrote:

> +extern void set_perf_counter_pending(void);

btw., Mike Frysinger pointed out that this prototype should be in 
include/linux/perf_counter.h, not spread out in every architecture 
pointlessly.

	Ingo
