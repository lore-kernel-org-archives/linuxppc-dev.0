Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2BFEDDDDD5
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Nov 2007 16:52:44 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	lAG5qcRn024192
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Nov 2007 22:52:39 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id lAG5qbPw023988
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Nov 2007 23:52:37 -0600 (CST)
Subject: Re: Please pull from for-2.6.24
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20070914122510.6dffb747@weaponx.rchland.ibm.com>
References: <Pine.LNX.4.64.0709131554530.29675@blarg.am.freescale.net>
	<AC7B9A70-5050-4191-A20E-B92686B675D4@kernel.crashing.org>
	<20070914122510.6dffb747@weaponx.rchland.ibm.com>
Content-Type: text/plain
Message-Id: <1195192440.7437.1060.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 16 Nov 2007 13:54:04 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2007-09-15 at 01:25, Josh Boyer wrote:
> On Fri, 14 Sep 2007 09:02:04 -0500
> Kumar Gala <galak@kernel.crashing.org> wrote:
> 
> > 
> > On Sep 13, 2007, at 3:55 PM, Kumar Gala wrote:
> > 
> > > Please pull from 'for-2.6.24' branch of
> > >
> > >     master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git 
> > > for-2.6.24
> > >
> > > to receive the following updates:
> > 
> > I've updated the branch with the following changes:
> > 
> > > Anton Vorontsov (3):
> > >       [POWERPC] MPC832x_RDB: Update dts to use SPI1 in QE,
> register  
> > > mmc_spi stub
> > 
> > Updated commit message.  (let me know if you want me to drop this
> for  
> > now and wait til mmc_spi gets merged)
> > 
> > > Roy Zang (1):
> > >       [POWERPC] Update mpc7448hpc2 device tree to be compatible
> for  
> > > tsi109 chip
> > 
> > Dropped for now.  I doubt we want this based on Segher's comments.  
> > (pretty sure its a ts108 on the hpc2 board).
> 
> It is a tsi108 on hpc2.  Holly has tsi109.  From a Linux perspective,
> there is no difference.  And the comment Segher made on the list was
> "Looks good, thanks!"  So what other comment are you talking about?
Hi, guys
In fact, I was confused by this chain.
Original hpc2 owns tsi108, but the new manufactured board has tsi109.
Roy
