Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7DCCADDE46
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 04:00:03 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7UI00sQ012532
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Aug 2007 14:00:00 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7UHxxsk362444
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Aug 2007 11:59:59 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7UHxx4f030290
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Aug 2007 11:59:59 -0600
Date: Thu, 30 Aug 2007 12:59:52 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Document and implement an improved flash device binding for
	powerpc (v4)
Message-ID: <20070830125952.14c700ea@zod.rchland.ibm.com>
In-Reply-To: <20070830172932.GA3317@ld0162-tx32.am.freescale.net>
References: <20070830012118.GF22844@localhost.localdomain>
	<20070830172932.GA3317@ld0162-tx32.am.freescale.net>
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

On Thu, 30 Aug 2007 12:29:33 -0500
Scott Wood <scottwood@freescale.com> wrote:

> On Thu, Aug 30, 2007 at 11:21:18AM +1000, David Gibson wrote:
> > +    For JEDEC compatible devices, the following additional properties
> > +    are defined:
> > +
> > +     - vendor-id : Contains the flash chip's vendor id (1 byte).
> > +     - device-id : Contains the flash chip's device id (1 byte).
> 
> Are these required, or recommended?

For JEDEC, I believe those are required.

josh
