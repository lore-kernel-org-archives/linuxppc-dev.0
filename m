Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2AA3AB6EF7
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Sep 2010 18:05:42 +1000 (EST)
Received: from lpsc0174x.localnet (lpsc0174x.in2p3.fr [134.158.40.174])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with ESMTP id
	o8F85bGH000464
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Sep 2010 10:05:37 +0200
From: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Generating elf kernel ?
Date: Wed, 15 Sep 2010 10:07:50 +0200
References: <201009141053.11946.dargaud@lpsc.in2p3.fr>
	<20100914125713.GB5768@radix50.net>
In-Reply-To: <20100914125713.GB5768@radix50.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201009151007.50706.dargaud@lpsc.in2p3.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > How do I generate an elf file ?
> vmlinux?

Thanks.

The entry point address has change and I can't upload it:
New (bad) one:
$ readelf -h vmlinux
...
  Entry point address:               0xc0000000

Old (good) one:
$ readelf -h zImage.elf 
...
  Entry point address:               0x400000

How can I change the entry point address ?
-- 
Guillaume Dargaud
http://www.gdargaud.net/
