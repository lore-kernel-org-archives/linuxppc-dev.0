Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DAB5367C28
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Oct 2006 04:21:36 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9DILUAM005832
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Oct 2006 14:21:30 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k9DILU56264440
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Oct 2006 14:21:30 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k9DILTNI026762
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Oct 2006 14:21:29 -0400
Subject: Re: [PATCH] powerpc: Add mktree utility to arch/powerpc/boot
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <452FBB67.4060509@am.sony.com>
References: <1160752023.3351.3.camel@zod.rchland.ibm.com>
	<452FBB67.4060509@am.sony.com>
Content-Type: text/plain
Date: Fri, 13 Oct 2006 13:25:17 -0500
Message-Id: <1160763918.3941.2.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-10-13 at 09:14 -0700, Geoff Levand wrote:
> Josh Boyer wrote:
> > + * Makes a tree bootable image for IBM Evaluation boards.
> > + * Basically, just take a zImage, skip the ELF header, and stuff
> > + * a 32 byte header on the front.
> 
> I guess you mean on some standard bootloader that comes with
> IBM Evaluation boards?  Should this comment reflect that this
> operation is required by that bootloader, not the hardware?

Yes, this is needed for the standard bootloader on some boards.
However, neither the bootloader or the HW are doing what the comment
says.  That is what mktree.c itself does, so I think it's correctly
describing what's going on.

BTW, this is simply a copy of the mktree.c that's been in
arch/ppc/boot/simple for years.  I'm simply adding it to arch/powerpc in
preparation for some more 4xx merge work to follow.

josh
