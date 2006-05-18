Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 5AAF267A0E
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 16:57:21 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	k4I77SHC012297
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 00:07:28 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k4I6vGpJ005270
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 01:57:18 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD4673062C05CC@zch01exm40.ap.freescale.net>
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Kumar Gala
	<galak@kernel.crashing.org>
Subject: RE: [PATCH/2.6.17-rc4 1/10] Powerpc: Add general support for mpc7
	448h pc2 (Taiga) platform
Date: Thu, 18 May 2006 14:57:12 +0800
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Alexandre.Bounine@tundra.com,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 
> On Wed, 2006-05-17 at 08:45 -0500, Kumar Gala wrote:
> 
> > > +#ifdef TSI108_ETH
> > > +hw_info hw_info_table[TSI108_ETH_MAX_PORTS + 1] = {
> > > +	{TSI108_CSR_ADDR_PHYS + TSI108_ETH_OFFSET,
> > > +	 TSI108_CSR_ADDR_PHYS + TSI108_ETH_OFFSET,
> > > +	 TSI108_PHY0_ADDR, IRQ_TSI108_GIGE0},
> > > +
> > > +	{TSI108_CSR_ADDR_PHYS + TSI108_ETH_OFFSET + 0x400,
> > > +	 TSI108_CSR_ADDR_PHYS + TSI108_ETH_OFFSET,
> > > +	 TSI108_PHY1_ADDR, IRQ_TSI108_GIGE1},
> > > +
> > > +	{TBL_END, TBL_END, TBL_END, TBL_END}
> > > +};
> > > +#endif
> > 
> > This table looks problematic.  Look at using something like a  
> > platform device.
> 
> Bzzzt ... wrong answer :) That's a textbook example of stuff 
> that should
> be provided via the device-tree.
> 
> 

Well , should I register this data to a platform device or the Ethernet 
driver get the information from device-tree directly?
Roy
