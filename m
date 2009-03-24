Return-Path: <markn@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9CFE6DDFA9
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2009 09:51:16 +1100 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp05.au.ibm.com (8.13.1/8.13.1) with ESMTP id n2OMnTPJ022000
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2009 09:49:29 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n2OMpWo0471308
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2009 09:51:32 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n2OMpEpJ032089
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2009 09:51:15 +1100
From: Mark Nelson <markn@au1.ibm.com>
To: Utz Bacher <utz.bacher@de.ibm.com>
Subject: Re: [PATCH] powerpc/wdrtas: Update wdrtas_get_interval to
	=?iso-8859-1?q?use=09rtas=5Fdata=5Fbuf?=
Date: Wed, 25 Mar 2009 09:53:02 +1100
References: <OF2EBA91DF.87037392-ONC1257583.004A2432-C1257583.004FC7A9@de.ibm.com>
In-Reply-To: <OF2EBA91DF.87037392-ONC1257583.004A2432-C1257583.004FC7A9@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200903250953.02677.markn@au1.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 25 Mar 2009 01:31:32 am Utz Bacher wrote:
> Adrian Reber <adrian@lisas.de> wrote on 24.03.2009 13:31:31:
> > On Tue, Mar 24, 2009 at 05:30:41PM +1100, Mark Nelson wrote:
> > > The buffer passed to the ibm,get-system-parameter RTAS call must be
> > > in the RMA. To ensure we pass an address in the RMA use rtas_data_buf
> > > for the actual RTAS call and then copy the result to value. We can't
> > > just make it static because this can be compiled in as a module.
> > > 
> > > Also add the WDRTAS_SP_SPI_LEN so we don't litter '4' throughout the
> > > function.
> > > 
> > > Signed-off-by: Mark Nelson <markn@au1.ibm.com>
> > > ---
> > > 
> > > Adrian, does this patch cause any problems for your pxcabs?
> > 
> > No, it even helps. I have no tried the watchdog until now, but without 
> the
> > patch I get: 
> > 
> >    wdrtas: could not get sp_spi watchdog timeout (0). Continuing
> > 
> > and with the patch it reads the correct value. So only with your patch
> > it works like it is supposed to. Thanks!
> > 
> > Tested-by: Adrian Reber <adrian@lisas.de>
> 
> looks good to me.
> 
> Acked-by: Utz Bacher <utz.bacher@de.ibm.com>

Thanks for looking over it!
Mark
