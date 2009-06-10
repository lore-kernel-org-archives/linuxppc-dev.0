Return-Path: <bzolnier@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 67678B70AB
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 10 Jun 2009 21:47:36 +1000 (EST)
Received: from mail-fx0-f222.google.com (mail-fx0-f222.google.com
	[209.85.220.222]) by ozlabs.org (Postfix) with ESMTP id 2ABCEDDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2009 21:47:34 +1000 (EST)
Received: by fxm22 with SMTP id 22so676383fxm.9
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2009 04:47:32 -0700 (PDT)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Delay on intialization ide subsystem(most likely)
Date: Wed, 10 Jun 2009 13:44:29 +0200
References: <20090425170203.74603b9c@power-debian>
	<200906082220.41763.bzolnier@gmail.com>
	<1244503587.8971.9.camel@pasglop>
In-Reply-To: <1244503587.8971.9.camel@pasglop>
MIME-Version: 1.0
Message-Id: <200906101344.30057.bzolnier@gmail.com>
Content-Type: Text/Plain;
  charset="iso-8859-15"
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

On Tuesday 09 June 2009 01:26:27 Benjamin Herrenschmidt wrote:
> On Mon, 2009-06-08 at 22:20 +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> > > [   70.584122]  hdb:<3>ide-pmac lost interrupt, dma status: 8480
> > 
> > DMA status indicates that DMA transfer is still active according to
> > the controller.  This one is really a platform/hardware specific issue.
> 
> I've partially missed that thread. Is the a bugzilla entry or

There is no bugzilla entry currently so please check mailing list
archives for previous discussion.

> something ? Is this a regression ?

At least not a recent one (it happens since at least 2.6.24).
