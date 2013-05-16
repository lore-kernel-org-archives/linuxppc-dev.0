Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C96452C0098
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 May 2013 14:47:52 +1000 (EST)
Message-ID: <1368679657.9603.32.camel@pasglop>
Subject: SATA FSL and upstreaming
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Qiang Liu <qiang.liu@freescale.com>, Shaohui Xie
 <Shaohui.Xie@freescale.com>, Andy Fleming <afleming@freescale.com>
Date: Thu, 16 May 2013 14:47:37 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi folks !

So I was trying to use my 5020ds to test some stuff today. Since I
hadn't used it in a while, I decided to "upgrade" it to the latest NOR
etc...

Interestingly I discovered that the SATA (which was supposedly dead on
the rev1 chip) was actually working with the SDK kernel, while it's
still completely busted upstream.

A quick git compare shows about 5 or 6 commits in the SDK tree, some as
old as 2011, fixing various erratas in that chip, that never made their
way upstream.

Any reason for that ? Being GPL, I can submit them to Tejun myself but
it would be better form if you guys did :-)

BTW. Also what's the status with getting the network working upstream ?
Even if sub-standard the code could at least go into staging...

Cheers,
Ben.
