Return-Path: <matt@genesi-usa.com>
Received: from mail.genesippc.com (mithrandir.softwarenexus.net [66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A5C1367B32
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 22:17:28 +1000 (EST)
From: "Matt Sealey" <matt@genesi-usa.com>
To: "'Albert Cahalan'" <acahalan@gmail.com>,
	"'Paul Mackerras'" <paulus@samba.org>
Subject: RE: PowerPC paxtest results w/ gcc-4.1
Date: Mon, 14 Aug 2006 14:17:21 +0200
Message-ID: <000401c6bf9b$9be32ab0$99dfdfdf@bakuhatsu.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <787b0d920608122111p79f29d74r600382658599cd63@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, 'debian-powerpc' <debian-powerpc@lists.debian.org>
Reply-To: matt@genesi-usa.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



> That looks like a 64-bit system, which doesn't have the 
> granularity problem anyway. 32-bit powerpc seems to be 
> decent. The heap shares with the executable itself, and of 
> course there is the yucky 2 GB limit.

One thing I'm curious about, has anyone EVER made a system which
actually used the 36-bit addressing on the G4?

I always wondered why such support was never in Linux but then
again if nobody connected the other 4 address lines on any PowerPC
board ever made that ran Linux, there's nothing ever to test it
on anyway. It wouldn't be any more problematic (same way as the NX
bit..) than Intel PAE support, right?

-- 
Matt Sealey <matt@genesi-usa.com>
Manager, Genesi, Developer Relations
