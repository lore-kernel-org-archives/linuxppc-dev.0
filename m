Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B5BA5DDE3E
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 00:10:00 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m0GD9vjx024437
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 08:09:57 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0GD9uQ5118212
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 08:09:56 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0GD9uqY031605
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 08:09:56 -0500
Date: Wed, 16 Jan 2008 07:08:26 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] [POWERPC] 4xx: Remove "i2c" and "xxmii-interface"
	device_types from dts
Message-ID: <20080116070826.3c9f89a2@zod.rchland.ibm.com>
In-Reply-To: <200801161401.22855.sr@denx.de>
References: <1200474000-5630-1-git-send-email-sr@denx.de>
	<20080116064008.390db210@zod.rchland.ibm.com>
	<200801161401.22855.sr@denx.de>
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

On Wed, 16 Jan 2008 14:01:22 +0100
Stefan Roese <sr@denx.de> wrote:

> Josh,
> 
> On Wednesday 16 January 2008, Josh Boyer wrote:
> > > Remove all "i2c" and "xxmii-interface" (rgmii etc) device_type entries
> > > from the 4xx dts files.
> >
> > Holding on this one until Ben or I can check Axon to see if it's DT can
> > handle no device_type for xxmii-interface.
> 
> Best would be, if you would hold this patch at least until the newemac patch 
> is pulled.

Sure, I was already planning on doing that anyway.  It's early, and
the Axon verification is really for that newemac patch anyway, not
this one :)

josh
