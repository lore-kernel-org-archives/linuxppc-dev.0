Return-Path: <randy.dunlap@oracle.com>
Received: from rgminet01.oracle.com (rgminet01.oracle.com [148.87.113.118])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E5024DDE39
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 11:38:20 +1000 (EST)
Date: Mon, 17 Sep 2007 18:37:49 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Satyam Sharma <satyam@infradead.org>
Subject: Re: [PATCH] powerpc: Avoid pointless WARN_ON(irqs_disabled()) from
	panic codepath
Message-Id: <20070917183749.fd690505.randy.dunlap@oracle.com>
In-Reply-To: <alpine.LFD.0.999.0709180511070.8863@enigma.security.iitk.ac.in>
References: <46EA5CEB.7020104@linux.vnet.ibm.com>
	<a781481a0709140337u2c26f770h2af6d457bc39f280@mail.gmail.com>
	<alpine.LFD.0.999.0709180511070.8863@enigma.security.iitk.ac.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Linux, Paul Mackerras <paulus@samba.org>,
	Mailing List <linux-kernel@vger.kernel.org>,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 18 Sep 2007 05:13:40 +0530 (IST) Satyam Sharma wrote:

> Untested (not even compile-tested) patch.
> Could someone point me to ppc32/64 cross-compilers for i386?

OSDL had some, but those are gone now.
I downloaded all of them and still use them, although it would
be good to have some more recent versions of them.

I put the power* compiler tarballs here:

http://userweb.kernel.org/~rdunlap/cross-compilers/

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
