Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F1D6DB6EEB
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Apr 2010 10:50:31 +1000 (EST)
Subject: Re: Continual reading from the PowerPc time base register is not
	stable
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kim Phillips <kim.phillips@freescale.com>
In-Reply-To: <20100421194419.3edf2c80.kim.phillips@freescale.com>
References: <43c137a81003241941p84cba56y3e02e40cb22623e2@mail.gmail.com>
	<o2y43c137a81004092014z1511cecdxb7154825dc07b49f@mail.gmail.com>
	<20100421194419.3edf2c80.kim.phillips@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 22 Apr 2010 10:50:16 +1000
Message-ID: <1271897416.2330.186.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Csdncannon <csdncannon@gmail.com>,
	zhouminggang@hotmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-04-21 at 19:44 -0500, Kim Phillips wrote:
> I took an 8377 rdb board, and let it run timebase.c (with the isync &
> long long casts) all weekend, and have failed to reproduce the issue.
> That was on linux 2.6.33, and I've got another machine running the
> same
> thing under 2.6.28 for the last couple of hours, still unable to
> reproduce the issue.

Do we need to add an isync to the vdso and kernel gettimeofday() ?

Cheers,
Ben.
