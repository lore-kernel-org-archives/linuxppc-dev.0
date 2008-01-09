Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4A347DDF81
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 23:07:39 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m09C7a3F014360
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2008 07:07:37 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m09C7ank217208
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2008 07:07:36 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m09C7a8w008641
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2008 07:07:36 -0500
Date: Wed, 9 Jan 2008 06:07:23 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
Subject: Re: [PATCH] enable built-in networking for Sequoia defconfig
Message-ID: <20080109060723.06885abd@zod.rchland.ibm.com>
In-Reply-To: <200801091216.25581.matthias.fuchs@esd-electronics.com>
References: <1199489214.9673.18.camel@basalt>
	<20080108100937.0cfca4cf@zod.rchland.ibm.com>
	<200801091216.25581.matthias.fuchs@esd-electronics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 9 Jan 2008 12:16:25 +0100
Matthias Fuchs <matthias.fuchs@esd-electronics.com> wrote:

> Josh, 
> 
> Where did you apply this patch to? Couldn't find it in your for-2.6.25 branch.

I applied it there, just haven't pushed it out yet.  Will do that today.

> BTW, is it normal to edit the defconfig file by hand?

The defconfig?  Not sure.  What I normally do is a make foo_defconfig,
edit the .config, make oldconfig, and copy the resulting .config back
to foo_defconfig.

josh
