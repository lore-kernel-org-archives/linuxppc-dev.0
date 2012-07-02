Return-Path: <zch@az84smr01.freescale.net>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe001.messaging.microsoft.com [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5CCEA2C0092
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jul 2012 20:43:37 +1000 (EST)
Received: from mail8-am1 (localhost [127.0.0.1])	by mail8-am1-R.bigfish.com
 (Postfix) with ESMTP id 31BED36036A	for <linuxppc-dev@lists.ozlabs.org>; Mon,
 2 Jul 2012 10:41:32 +0000 (UTC)
Received: from AM1EHSMHS002.bigfish.com (unknown [10.3.201.252])	by
 mail8-am1.bigfish.com (Postfix) with ESMTP id B09F4380048	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jul 2012 10:41:30 +0000 (UTC)
Received: from localhost.localdomain ([10.213.130.145])	by
 az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id q62AhNGJ030800	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Jul 2012 03:43:23 -0700
Date: Mon, 2 Jul 2012 18:44:41 +0800
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v6 1/5] powerpc/85xx: implement hardware timebase sync
Message-ID: <20120702104441.GB22108@localhost.localdomain>
References: <1340706359-9455-1-git-send-email-chenhui.zhao@freescale.com>
 <1340748634.3732.27.camel@pasglop>
 <20120627102138.GB10476@localhost.localdomain>
 <1340797732.3732.46.camel@pasglop>
 <20120628033815.GA11387@localhost.localdomain>
 <1340880651.20977.83.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1340880651.20977.83.camel@pasglop>
Sender: <zch@az84smr01.freescale.net>
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 28, 2012 at 08:50:51PM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2012-06-28 at 11:38 +0800, Zhao Chenhui wrote:
> > 
> > 
> > The bootloader have done a timebase sync. If we do not need KEXEC or
> > HOTPLUG_CPU feature, it is unnecessary to do it again at boot time of
> > kernel. I only compile the timebase sync routines
> > when users enable KEXEC or HOTPLUG_CPU. 
> 
> Still, how much are you really saving ? Is it worth the added mess and
> loss of test coverage ?
> 
> We have too many conditional stuff like that already.
> 
> Cheers,
> Ben.

OK. I will remove this config option.

-Chenhui
