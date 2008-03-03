Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 348CDDDE9C
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2008 09:38:39 +1100 (EST)
Subject: Re: locking problem in sata_sil24?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rune Torgersen <runet@innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B0410A524@ismail.innsys.innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B0410A524@ismail.innsys.innovsys.com>
Content-Type: text/plain
Date: Tue, 04 Mar 2008 09:37:46 +1100
Message-Id: <1204583866.21545.31.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2008-03-03 at 16:10 -0600, Rune Torgersen wrote:
> Hi I am trying to get PREEMPT_RT pach to wokr on my 2.6.24 kernel, but
> kept gettign a BUG() (kernel BUG at kernel/rtmutex.c:692).
> While tryiong to figure out what it was, I saw some mention of trying
> LOCKDEP to see what is going on, so I patched my -rt1 kernel with some
> lockdep patches from BenH.
> 
> Now I get an "inconsistent locking state", but I need help in trying to
> fiure out what I should look for.
> kernel is fo an Freescale 8280 and the locking seems to occur in the
> driver for a Silicon Image SII3124 SATA disk driver

What core is in the 8280 ? At this stage, I wouldn't rule out a bug in
the lockdep patches, I need to do more work on them.

Cheers,
Ben.
