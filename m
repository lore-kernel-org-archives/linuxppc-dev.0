Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 49015B6F9C
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jun 2011 15:39:16 +1000 (EST)
Subject: RE: powerpc: Add printk companion for ppc_md.progress
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: dtcarroll@gmail.com
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 17 Jun 2011 15:39:04 +1000
Message-ID: <1308289144.32158.33.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(Original mail lost in my email cleanup so this isn't a proper reply)

I'll apply that for now, but I'd very much like somebody to just get rid
of the whole ppc_md.progress business.

We have printk working early enough nowadays (and we can use udbg for
debugging).

It was meant to display magic numbers on the panel of IBM machines, I
don't think it was every useful...

Cheers,
Ben.
