Return-Path: <rsass@uncc.edu>
Received: from rsass-homer.uncc.edu (rsass-homer.uncc.edu [152.15.91.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1F47BDDF14
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Mar 2008 13:34:12 +1100 (EST)
Received: from uncc.edu (localhost.localdomain [127.0.0.1])
	by rsass-homer.uncc.edu (8.13.8/8.13.8) with ESMTP id m252Y6Um026382
	for <linuxppc-embedded@ozlabs.org>; Tue, 4 Mar 2008 21:34:07 -0500
Message-Id: <200803050234.m252Y6Um026382@rsass-homer.uncc.edu>
To: linuxppc-embedded@ozlabs.org
Subject: linux-headers (powerpc v. ppc)
From: "Ron Sass" <rsass@uncc.edu>
Date: Tue, 04 Mar 2008 21:34:06 -0500
Sender: rsass@uncc.edu
Reply-To: Ron Sass <rsass@uncc.edu>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I hope this is to the right list... the recent discussion of
retiring ppc arch encouraged me to ask.

Ultimately, I'm trying to build a native PPC 405 compiler (i.e
Canadian cross).  I've got a crosstool's generated cross-compiler
and I have glibc and a native bintools on my 405 root filesystem.

What I'd like to do is:

make ARCH=ppc headers_check
make ARCH=ppc INSTALL_HDR_PATH=dest headers_install

but that's not supported in the ppc tree.

So my question is, can I just ...

make ARCH=powerpc headers_check
make ARCH=powerpc INSTALL_HDR_PATH=dest headers_install

and then switch to ppc when I build the kernel?

I suspect it will work but just don't know if there is a
subtle difference that will come back to haunt me at
run-time.

Any advice would be greatly appreciated!

Ron
