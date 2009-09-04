Return-Path: <BATV+a98c0c5cb446abe23156+2203+infradead.org+dwmw2@casper.srs.infradead.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DF2F3B7079
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  4 Sep 2009 18:52:03 +1000 (EST)
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 844F9DDD01
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Sep 2009 18:52:03 +1000 (EST)
Subject: Re: [PATCH] powerpc/mpc52xx/mtd: fix mtd-ram access for 16-bit
	Local Plus Bus
From: David Woodhouse <dwmw2@infradead.org>
To: Albrecht =?ISO-8859-1?Q?Dre=DF?= <albrecht.dress@arcor.de>
In-Reply-To: <1244911551.3423.0@antares>
References: <1244911551.3423.0@antares>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 04 Sep 2009 09:51:50 +0100
Message-Id: <1252054310.4483.539.camel@macbook.infradead.org>
Mime-Version: 1.0
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2009-06-13 at 18:45 +0200, Albrecht Dreß wrote:
> Am 11.06.09 19:28 schrieb(en) Grant Likely:
> > So; the solution to me seems to be on an MPC5200 platform replace the  
> > offending hooks with MPC5200 specific variants at runtime.
> 
> Will re-work the patch that way!  BTW, a dumb question: what is the  
> proper way to determine which cpu the system is running on?  Check the  
> CPU node of the of tree?

Surely the solution is for it to be a 'complex' mapping, where it can
provide its own I/O functions instead of polluting the inline versions
designed for 'simple' maps with special cases?

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation
