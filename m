Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-res-R.bigfish.com (outbound-res.frontbridge.com
	[63.161.60.49])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id BA6A567C18
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Oct 2006 02:14:37 +1000 (EST)
Message-ID: <452FBB67.4060509@am.sony.com>
Date: Fri, 13 Oct 2006 09:14:31 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: Add mktree utility to arch/powerpc/boot
References: <1160752023.3351.3.camel@zod.rchland.ibm.com>
In-Reply-To: <1160752023.3351.3.camel@zod.rchland.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:
> + * Makes a tree bootable image for IBM Evaluation boards.
> + * Basically, just take a zImage, skip the ELF header, and stuff
> + * a 32 byte header on the front.

I guess you mean on some standard bootloader that comes with
IBM Evaluation boards?  Should this comment reflect that this
operation is required by that bootloader, not the hardware?

-Geoff
