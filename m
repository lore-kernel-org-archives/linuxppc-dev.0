Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 97DC8DE0FF
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2008 22:03:03 +1000 (EST)
Subject: Re: ide pmac breakage
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
In-Reply-To: <200807291341.14724.bzolnier@gmail.com>
References: <1217208596.11188.144.camel@pasglop>
	<20080729141750V.fujita.tomonori@lab.ntt.co.jp>
	<1217308857.11188.237.camel@pasglop>
	<200807291341.14724.bzolnier@gmail.com>
Content-Type: text/plain
Date: Tue, 29 Jul 2008 22:02:51 +1000
Message-Id: <1217332971.11188.249.camel@pasglop>
Mime-Version: 1.0
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-ide@vger.kernel.org,
	petkovbb@gmail.com, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-07-29 at 13:41 +0200, Bartlomiej Zolnierkiewicz wrote:
> > Well, all I do is call into Bart's new helpers to scan for or
> unregister
> > devices ...
> 
> The switch to these helpers happened _before_ 2.6.26 and it shouldn't
> bring
> such behavior change (ditto for new IDE host addition/removal
> helpers)...
> 
> Please try to git-bisect it when you have some time.

Ok, I will. I worked fine when I last tried your patches. I'll see if I
can track it down too. Been a bit too busy lately as you can imagine.

Do you have something that exercise the same code path you can use ?

Ben.
