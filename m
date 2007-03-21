Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 38892DDFD6
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 03:17:30 +1100 (EST)
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l2LGHSb2017898
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 17:17:28 +0100
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id l2LGHSEo017896
	for linuxppc-dev@ozlabs.org; Wed, 21 Mar 2007 17:17:28 +0100
Date: Wed, 21 Mar 2007 17:17:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: linuxppc-dev@ozlabs.org
Subject: O= compilation failure in 2.6.21-rc
Message-ID: <20070321161728.GA17785@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

looks like 2.6.21-rc4 doesn't compile anymore when using objdir !=
srcdir.  The message is:

WRAP    arch/powerpc/boot/zImage.pseries
powerpc64-linux-ld: cannot open linker script file
arch/powerpc/boot/zImage.lds: No such file or directory
arch/powerpc/boot/zImage.pseries: No such file or directory

works fine for either building in the source dir or just doing a make
vmlinux instead of make so that the zImage wrapper isn't built.
