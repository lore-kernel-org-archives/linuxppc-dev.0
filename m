Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A5337B70C8
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  9 Jun 2009 09:26:44 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 02C8EDDD04
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jun 2009 09:26:43 +1000 (EST)
Subject: Re: Delay on intialization ide subsystem(most likely)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
In-Reply-To: <200906082220.41763.bzolnier@gmail.com>
References: <20090425170203.74603b9c@power-debian>
	<200905201756.14769.bzolnier@gmail.com>
	<20090530144643.76cb456e@power-debian>
	<200906082220.41763.bzolnier@gmail.com>
Content-Type: text/plain
Date: Tue, 09 Jun 2009 09:26:27 +1000
Message-Id: <1244503587.8971.9.camel@pasglop>
Mime-Version: 1.0
Cc: linux-ide@vger.kernel.org, Andrey Gusev <a.gusev1980@mail.ru>,
	petkovbb@gmail.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-06-08 at 22:20 +0200, Bartlomiej Zolnierkiewicz wrote:

> > [   70.584122]  hdb:<3>ide-pmac lost interrupt, dma status: 8480
> 
> DMA status indicates that DMA transfer is still active according to
> the controller.  This one is really a platform/hardware specific issue.

I've partially missed that thread. Is the a bugzilla entry or
something ? Is this a regression ?

Cheers,
Ben.
