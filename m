Return-Path: <markos@codex.gr>
Received: from lvps87-230-20-158.dedicated.hosteurope.de
	(lvps87-230-20-158.dedicated.hosteurope.de [87.230.20.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9213FDE52E
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 02:19:13 +1000 (EST)
Received: from vector.lan (athedsl-252509.home.otenet.gr [85.73.33.251])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by lvps87-230-20-158.dedicated.hosteurope.de (Postfix) with ESMTPSA id
	80FD8BF3808C
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 18:10:12 +0200 (CEST)
From: Konstantinos Margaritis <markos@codex.gr>
To: linuxppc-dev@ozlabs.org
Subject: libfreevec benchmarks
Date: Thu, 21 Aug 2008 19:09:15 +0300
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200808211909.16852.markos@codex.gr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benh suggested that I made this more known, and in particular to this list, so 
I send this mail in hope that some people might be interested. In particular, 
I ran the following benchmarks against libfreevec/glibc:

http://www.freevec.org/content/libfreevec_104_benchmarks_updated

libfreevec has reached a very stable point, where me and a couple of others 
(the OpenSuse PowerPC port developer being one) have been using it for weeks 
(personally I've been using it for months), using the LD_PRELOAD mechanism (as 
explained here: 
http://www.freevec.org/content/howto_using_libfreevec_using_ld_preload).
The OpenSuse guys even consider using it by default on the ppc port even, but 
that's not final of course.

glibc integration _might_ happen if glibc developers change their attitude (my 
mails have been mostly ignored).

Last, I've also been working on a libm rewrite, though this will take some 
time still. I've reimplemented most math functions at the algorithm level, eg. 
so far, most functions achieve 50%-200% speed increase at full IEEE754 
accuracy (mathematically proven, soon to be published online) without using 
Altivec yet, just by choosing a different approximation method (Taylor 
approximation is pretty dumb if you ask me anyway).

Regards

Konstantinos Margaritis
Codex
http://www.codex.gr
