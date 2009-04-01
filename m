Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CEB13DDE17
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 11:34:08 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n310V2W3022181
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 18:31:02 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n310Y6v0231158
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 18:34:06 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n310Y4AS018830
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 18:34:05 -0600
Date: Tue, 31 Mar 2009 20:33:21 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: Add hvc_console to MAINTAINERS
Message-ID: <20090401003321.GA11682@zod.rchland.ibm.com>
References: <49BF956B.9030109@gmail.com>
	<20090330133531.f5d99c09.akpm@linux-foundation.org>
	<20090330205553.GA19278@yoda.jdub.homelinux.org>
	<20090330141852.59baaeda.akpm@linux-foundation.org>
	<20090331132944.GB2332@yoda.jdub.homelinux.org>
	<1238543040.6522.10.camel@localhost>
	<20090331235057.GB563@zod.rchland.ibm.com>
	<1238544253.6522.14.camel@localhost>
	<1238545250.6522.17.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1238545250.6522.17.camel@localhost>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	roel.kluin@gmail.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 01, 2009 at 11:20:50AM +1100, Michael Ellerman wrote:
>Add a MAINTAINERS entry for the hypervisor virtual console driver.
>
>Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

>---
> MAINTAINERS |    6 ++++++
> 1 files changed, 6 insertions(+), 0 deletions(-)
>
>How about this?
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 1c2ca1d..854437a 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -1918,6 +1918,12 @@ L:	lm-sensors@lm-sensors.org
> W:	http://www.kernel.org/pub/linux/kernel/people/fseidel/hdaps/
> S:	Maintained
>
>+HYPERVISOR VIRTUAL CONSOLE DRIVER
>+L:	linuxppc-dev@ozlabs.org
>+L:	linux-kernel@vger.kernel.org
>+S:	Odd Fixes
>+F:	drivers/char/hvc_*
>+
> GSPCA FINEPIX SUBDRIVER
> P:	Frank Zago
> M:	frank@zago.net
>-- 
>1.6.1.2
>
>
>
