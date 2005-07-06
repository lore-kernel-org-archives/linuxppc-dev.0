Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E9D2D67C89
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Jul 2005 16:38:35 +1000 (EST)
Date: Wed, 6 Jul 2005 08:38:30 +0200
From: Olaf Hering <olh@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Message-ID: <20050706063830.GA1968@suse.de>
References: <17016.29775.224816.691409@cargo.ozlabs.ibm.com>
	<20050703172955.GA25976@suse.de>
	<20050703183237.GC16764@smtp.west.cox.net>
	<20050705181448.GA28142@suse.de>
	<20050705194724.GB6878@smtp.west.cox.net>
	<20050705195441.GA15455@suse.de>
	<20050705195819.GD6878@smtp.west.cox.net>
	<20050705202717.GA26014@suse.de>
	<20050705212213.GA8358@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20050705212213.GA8358@smtp.west.cox.net>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Set cpu explicitly in kernel compiles
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Tue, Jul 05, Tom Rini wrote:

> That's very wierd.  What is the default then?  Thinking back to May, I
> thought it was 'common', and that was why Paul wanted to change things.

This is an odd biarch compiler, the one that Paul talked about:

Target: powerpc64-suse-linux
Configured with: ../configure --enable-threads=posix --prefix=/usr
--with-local-prefix=/usr/local --infodir=/usr/share/info
--mandir=/usr/share/man --libdir=/usr/lib --libexecdir=/usr/lib
--enable-languages=c,c++,objc,f95,java,ada --enable-checking
--with-gxx-include-dir=/usr/include/c++/4.0.1 --with-slibdir=/lib
--with-system-zlib --enable-shared --enable-__cxa_atexit
--without-system-libunwind --with-cpu=default32
--host=powerpc64-suse-linux
Thread model: posix
gcc version 4.0.1 20050701 (prerelease) (SUSE Linux)
