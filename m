Return-Path: <randy.dunlap@oracle.com>
Received: from rgminet01.oracle.com (rgminet01.oracle.com [148.87.113.118])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7E6BCDDED4
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 01:37:43 +1000 (EST)
Date: Wed, 19 Sep 2007 08:29:47 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Satyam Sharma <satyam@infradead.org>
Subject: Re: [PATCH] powerpc: Avoid pointless WARN_ON(irqs_disabled()) from
	panic codepath
Message-Id: <20070919082947.d9a33a70.randy.dunlap@oracle.com>
In-Reply-To: <alpine.LFD.0.999.0709191844360.7697@enigma.security.iitk.ac.in>
References: <46EA5CEB.7020104@linux.vnet.ibm.com>
	<a781481a0709140337u2c26f770h2af6d457bc39f280@mail.gmail.com>
	<alpine.LFD.0.999.0709180511070.8863@enigma.security.iitk.ac.in>
	<20070917183749.fd690505.randy.dunlap@oracle.com>
	<20070917204625.64b97392@vader.jdub.homelinux.org>
	<alpine.LFD.0.999.0709191844360.7697@enigma.security.iitk.ac.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Mailing List <linux-kernel@vger.kernel.org>,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Linux@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 19 Sep 2007 19:15:00 +0530 (IST) Satyam Sharma wrote:

> 
> In fact, it turns out OSDL's cross-compiler toolchains were built with
> crosstool itself. Should also add that those OSDL compilers are too old
> (gcc version 3.4.x-3.5.x mostly -- my build was totally spammed with those
> "+m" in asm constraints related warnings), so I'll try and build a few
> more recent ones (at least for the more popular platforms) over the
> weekend too.

Hi,
Please let us know if/when you have newer cross-compiler tarballs
available.

Thanks.
---
~Randy
