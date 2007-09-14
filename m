Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CDD98DDDF7
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 03:25:21 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l8EGHRT1012640
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 12:17:27 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8EHPBaW336892
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 11:25:12 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8EHPBvq023697
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 11:25:11 -0600
Date: Fri, 14 Sep 2007 12:25:10 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Please pull from for-2.6.24
Message-ID: <20070914122510.6dffb747@weaponx.rchland.ibm.com>
In-Reply-To: <AC7B9A70-5050-4191-A20E-B92686B675D4@kernel.crashing.org>
References: <Pine.LNX.4.64.0709131554530.29675@blarg.am.freescale.net>
	<AC7B9A70-5050-4191-A20E-B92686B675D4@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 14 Sep 2007 09:02:04 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On Sep 13, 2007, at 3:55 PM, Kumar Gala wrote:
> 
> > Please pull from 'for-2.6.24' branch of
> >
> > 	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git  
> > for-2.6.24
> >
> > to receive the following updates:
> 
> I've updated the branch with the following changes:
> 
> > Anton Vorontsov (3):
> >       [POWERPC] MPC832x_RDB: Update dts to use SPI1 in QE, register  
> > mmc_spi stub
> 
> Updated commit message.  (let me know if you want me to drop this for  
> now and wait til mmc_spi gets merged)
> 
> > Roy Zang (1):
> >       [POWERPC] Update mpc7448hpc2 device tree to be compatible for  
> > tsi109 chip
> 
> Dropped for now.  I doubt we want this based on Segher's comments.   
> (pretty sure its a ts108 on the hpc2 board).

It is a tsi108 on hpc2.  Holly has tsi109.  From a Linux perspective,
there is no difference.  And the comment Segher made on the list was
"Looks good, thanks!"  So what other comment are you talking about?

josh
