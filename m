Return-Path: <paulus@bilbo.ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9E476B7242
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Jun 2009 09:24:11 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7DB85DDDB6
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jun 2009 09:24:11 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <19001.31508.901222.288946@cargo.ozlabs.ibm.com>
Date: Thu, 18 Jun 2009 09:24:04 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 5/6] perf_counter: powerpc: Add processor back-end for
	MPC7450 family
In-Reply-To: <34BD6A89-A05E-40CC-A495-017BFB08B796@kernel.crashing.org>
References: <19000.55404.103840.393470@cargo.ozlabs.ibm.com>
	<19000.55631.802122.696927@cargo.ozlabs.ibm.com>
	<34BD6A89-A05E-40CC-A495-017BFB08B796@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kumar Gala writes:

> This should be something like:
> 
> obj64-$(CONFIG_PPC_PERF_CTRS)-$(PPC_BOOK3S_64)
> 
> > +obj32-$(CONFIG_PPC_PERF_CTRS)	+= mpc7450-pmu.o
> 
> obj32-$(CONFIG_PPC_PERF_CTRS)-$(PPC_BOOK3S_32)
> 
> Or use new Kconfig types as I suggested on patch 1/6

Feel free to send a patch making those changes along with adding the
code to support the Freescale embedded PMU. :)

Paul.
