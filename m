Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 4750BDDF19
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Mar 2008 13:57:24 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org,
 Ron Sass <rsass@uncc.edu>
Subject: Re: linux-headers (powerpc v. ppc)
Date: Wed, 5 Mar 2008 03:51:57 +0100
References: <200803050234.m252Y6Um026382@rsass-homer.uncc.edu>
In-Reply-To: <200803050234.m252Y6Um026382@rsass-homer.uncc.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200803050351.57968.arnd@arndb.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wednesday 05 March 2008, Ron Sass wrote:
> So my question is, can I just ...
> 
> make ARCH=powerpc headers_check
> make ARCH=powerpc INSTALL_HDR_PATH=dest headers_install
> 
> and then switch to ppc when I build the kernel?

Yes, that is exactly what you are meant to do. The headers
need to be compatible, otherwise we would have bigger problems
running user space programs built against an older kernel
on current machines.

	Arnd <><
