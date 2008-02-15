Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9C846DE025
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2008 02:14:47 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1FFGOd5019572
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 10:16:24 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1FFES5e204786
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 10:14:28 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1FFEShH020980
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 10:14:28 -0500
Date: Fri, 15 Feb 2008 09:12:17 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Wolfgang Ocker <weo@reccoware.de>
Subject: Re: [PATCH] PPC440EP Interrupt Triggering and Level Settings
Message-ID: <20080215091217.21e86a1c@zod.rchland.ibm.com>
In-Reply-To: <1202671442.3384.15.camel@galileo.recco.de>
References: <1202671442.3384.15.camel@galileo.recco.de>
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

On Sun, 10 Feb 2008 20:24:02 +0100
Wolfgang Ocker <weo@reccoware.de> wrote:

> From: Wolfgang Ocker <weo@reccoware.de>
> 
> Corrected IRQ triggering and level settings according to latest revision
> of the 440EP User Manual (rev 1.24 nov 16, 2007).
> 
> The incorrect settings might cause a failure of the network if both
> onchip ethernet ports are under heavy load.
> 
> Signed-off-by: Wolfgang Ocker <weo@reccoware.de>

Your patch is word-wrapped.  I've gone ahead and fixed that up, but you
might want to figure that out for future patches.

josh
