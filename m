Return-Path: <DaveLiu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 1ECC667A3D
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Jun 2006 17:38:17 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k527so4r028844
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Jun 2006 00:54:50 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k527cExr013825
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Jun 2006 02:38:16 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD4673026FD937@zch01exm40.ap.freescale.net>
From: Liu Dave-r63238 <DaveLiu@freescale.com>
To: "'Benjamin Herrenschmidt'" <benh@kernel.crashing.org>, Zang Roy-r61911
	<tie-fei.zang@freescale.com>
Subject: RE: [PATCH/2.6.17-rc4 1/10] Powerpc: Add general support for mpc7
	448h pc2 (Taiga) platform
Date: Fri, 2 Jun 2006 15:38:11 +0800 
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


> > If I really need to use bat0 or bat1( I see that the 
> general mmu use 
> > bat2 and bat3,
> > where should I set up them?
> > 
> > For tsi108 pci configuration access, I need to map 16Mbyte
> > physical address.  If I do not use an extra bat, I can not 
> get the correct 
> > virtual address use ioremap.
> 
> What do you mean ? An ioremap will work, it will give you any 
> virtual address, you just have to store that in a global 
> instead of hard coding it. Hard coded virtual addresses are 
> bad. Especially for things like PCI config space that really 
> isn't performance sensitive.
> 

I agree ben about PCI config space, It should use ioremap
 to get virtual address. No performace indeed. 

I think we need find the root cause that the ioremap failed.

Dave
