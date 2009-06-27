Return-Path: <mingo@elte.hu>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 93FC1B7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 28 Jun 2009 02:58:58 +1000 (EST)
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1F450DDD01
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Jun 2009 02:58:57 +1000 (EST)
Date: Sat, 27 Jun 2009 18:58:45 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 2/2] perf_counter: powerpc: Add callchain support
Message-ID: <20090627165845.GA20794@elte.hu>
References: <19013.44646.549261.100582@cargo.ozlabs.ibm.com>
	<19013.44722.893263.275594@cargo.ozlabs.ibm.com>
	<1246091684.31755.210.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1246091684.31755.210.camel@twins>
Cc: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> On Sat, 2009-06-27 at 15:31 +1000, Paul Mackerras wrote:
> > +       if (regs) {
> > +               if (current_is_64bit())
> > +                       perf_callchain_user_64(regs, entry);
> > +               else
> > +                       perf_callchain_user_32(regs, entry);
> > +       }
> 
> Ingo do we need 32 on 64 stuff like that too?

hm, indeed.

	Ingo
