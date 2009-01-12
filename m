Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id ED4D9474CB
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jan 2009 10:39:11 +1100 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Tue, 13 Jan 2009 00:39:09 +0100
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Message-ID: <20090112233909.221080@gmx.net>
MIME-Version: 1.0
Subject: Re: [PATCH 5/5] ide: Force VIA IDE legacy interrupts for AmigaOne
	boards
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Mon, 12 Jan 2009 18:55:55 +0100
> Von: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> An: "Gerhard Pircher" <gerhard_pircher@gmx.net>
> CC: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, grant.likely@secretlab.ca
> Betreff: Re: [PATCH 5/5] ide: Force VIA IDE legacy interrupts for AmigaOne boards

> > > checking if IDE_HFLAG_FORCE_LEGACY_IRQS should be set.
> > Wouldn't it be better, if I clean this up now? (I have to resend my
> > AmigaOne platform patches anyway).
> 
> Replacement patch instead of incremental one is also fine with me -- given
> that it can wait for 2.6.30.
Yes, it can wait.
Although I would like to know from the powerpc maintainer, if my platform
patches could still go in 2.6.29, if I resend them in the next days? I guess it's
too late, right?

> > Okay, so the change shouldn't break IDE for Pegasos machines (I don't
> > have a Pegasos for testing).
> 
> Yes but there may be some other platforms (not necessarily powerpc ones)
> that may be affected (i.e. they can depend indirectly on IRQ auto-probing
> during IDE probe) so cleanup patch needs to spend some time in linux-next.
I think the VIA libata driver simply checks the progif register, too. I guess you
don't like the idea of a "#ifdef PPC32" or so around the
ide_pci_is_in_compatibility_mode() check?

Thanks!

Gerhard

-- 
Psssst! Schon vom neuen GMX MultiMessenger gehört? Der kann`s mit allen: http://www.gmx.net/de/go/multimessenger
