Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 4BF6067A79
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Jun 2006 17:40:15 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	k527oaRn025693
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Jun 2006 00:50:36 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k527e7SV018157
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Jun 2006 02:40:08 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD4673066CF618@zch01exm40.ap.freescale.net>
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: RE: [PATCH/2.6.17-rc4 1/10] Powerpc: Add general support for mpc7
	448h pc2 (Taiga) platform
Date: Fri, 2 Jun 2006 15:40:04 +0800 
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>,
	Paul Mackerras <paulus@samba.org>, Alexandre.Bounine@tundra.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> 
> > If I really need to use bat0 or bat1( I see that the 
> general mmu use 
> > bat2 and bat3, where should I set up them?
> > 
> > For tsi108 pci configuration access, I need to map 16Mbyte physical 
> > address.  If I do not use an extra bat, I can not get the correct 
> > virtual address use ioremap.
> 
> What do you mean ? An ioremap will work, it will give you any 
> virtual address, you just have to store that in a global 
> instead of hard coding it. Hard coded virtual addresses are 
> bad. Especially for things like PCI config space that really 
> isn't performance sensitive.
> 
> Ben.
> 
>
 
