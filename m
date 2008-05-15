Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 986FFDDEE9
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 07:10:53 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4FLAn2K002394
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 17:10:49 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4FLAmgd093856
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 17:10:48 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4FLAmeR012000
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 17:10:48 -0400
Date: Thu, 15 May 2008 16:07:34 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH] 4xx: Workaround for CHIP_11 Errata
Message-ID: <20080515160734.4e4ea759@zod.rchland.ibm.com>
In-Reply-To: <20080515163104.18f0a613@lappy.seanm.ca>
References: <20080515094346.3338e1f3@zod.rchland.ibm.com>
	<20080515163104.18f0a613@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 15 May 2008 16:31:04 -0400
Sean MacLennan <smaclennan@pikatech.com> wrote:

> On Thu, 15 May 2008 09:43:46 -0500
> "Josh Boyer" <jwboyer@linux.vnet.ibm.com> wrote:
> 
> > This implements the recommended workaround for this errata for chips
> > that use older versions of firmware that do not already handle it.
> > The last 4KiB of memory are hidden from the kernel to prevent the
> > problem transactions from occurring.
> 
> Do you know which versions of firmware have this problem?

Any U-Boot older than 1.3.3-rc1.  Not sure about PIBS, but I don't
think the version that is on my Bamboo board has a fix for it.

josh
