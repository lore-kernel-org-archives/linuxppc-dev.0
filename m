Return-Path: <glenn@aoi-industries.com>
Received: from aoi-industries.com (mail.aoi-industries.com [216.204.214.42])
	by ozlabs.org (Postfix) with ESMTP id 7DE1267B16
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Apr 2005 02:33:22 +1000 (EST)
Received: from loki (loki [192.168.2.30])
	by aoi-industries.com (Postfix) with ESMTP id 79C51C61C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Apr 2005 12:33:19 -0400 (EDT)
From: Glenn Burkhardt <glenn@aoi-industries.com>
To: linuxppc-embedded@ozlabs.org
Date: Wed, 27 Apr 2005 12:33:18 -0400
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200504271233.18856.glenn@aoi-industries.com>
Subject: Re: Status of Linux 2.6 for 40x and 44x CPUs
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

=46rom the looks of the benchmarks described here:

http://www.denx.de/twiki/bin/view/Know/Linux24vs26

and the results are basically confirmed here:

http://www.2cpu.com/articles/98_1.html

there are good reasons to avoid using the 2.6 kernel.  Frankly, I'm surpris=
ed=20
and would have thought that the changes in the scheduler would have brought=
=20
improvements, as did the report here:

http://www.lynuxworks.com/corporate/news/2004/linux-kernel-2.6.php

But it looks like the major improvements are in filesystem performance, so =
for=20
embedded use, 2.4 will be around for quite a while.
