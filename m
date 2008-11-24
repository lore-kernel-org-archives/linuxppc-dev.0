Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 853E0DDDEF
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Nov 2008 22:31:48 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id mAOBVNp6023584
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Nov 2008 06:31:23 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mAOBVida066132
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Nov 2008 06:31:44 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mAOBVimu022152
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Nov 2008 06:31:44 -0500
Date: Mon, 24 Nov 2008 06:31:32 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] powerpc: update ppc44x_defconfig
Message-ID: <20081124063132.60b4e38c@zod.rchland.ibm.com>
In-Reply-To: <20081124153305.4750234d.sfr@canb.auug.org.au>
References: <20081124153305.4750234d.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 24 Nov 2008 15:33:05 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> This removes CONFIG_PCI_LEGACY (which is not needed) and consequently
> several compiler warnings.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

I'll pull this into my -next branch today.  I have another KVM related
defconfig change that needs to go in as well.

josh
