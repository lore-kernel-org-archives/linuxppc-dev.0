Return-Path: <marvin24@gmx.de>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id DEEC02BF12
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Jan 2005 07:58:29 +1100 (EST)
From: Marc Dietrich <marvin24@gmx.de>
To: Sven Luther <sven.luther@wanadoo.fr>
Date: Wed, 5 Jan 2005 21:57:25 +0100
References: <200412261435.13562.marc.dietrich@ap.physik.uni-giessen.de>
	<200501051733.06350.marvin24@gmx.de>
	<20050105165551.GA29287@pegasos>
In-Reply-To: <20050105165551.GA29287@pegasos>
MIME-Version: 1.0
Message-Id: <200501052157.25302.marvin24@gmx.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [FYI] linux 2.6 still not working with PReP (ppc32)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi all,

I didn't recognise that the kernel from Sebastian - which was working fine 
here - was build from the debian sources (no hint in the kernel version). 
So I build everything again from debian source and fixed the irq's in 
prep_pci.c.

I can confirm now, that this debian+irq_fix kernel 2.6.8 runs fine and 
produces no scsi timeouts!

Something happend in kernels >= 2.6.9 which makes the scsi unusable. Also it 
seems, that even in 2.6.8 kernels and with ide hard disks (Sebastians setup) 
the scsi controller timeouts, but continues to operate - correct?

That's all for now (and this year), because I have to leave this nice machine 
alone and go home. Thanks to all who helped me - maybe see you next year 
again...

Greetings

Marc

Am Mittwoch, 5. Januar 2005 17:55 schrieben Sie:
>
> (...)
>
> Also, apt-get install kernel-patch-debian-2.6.8 should give you the latest
> debian patch. No idea how it applies to the non-free pruned stuff though.
>
> > Do you have any idea, why a stock 2.6.8 kernel (with prep_pci.c patch)
> > doesn't boot a prep image?
>
> Either a missing patch or a wrong .config.
>
> I am personally much more interested in having the debian kernel working
> correctly though.
>
> Friendly,
>
> Sven Luther
