Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 2A87F67A77
	for <linuxppc-dev@ozlabs.org>; Fri, 26 May 2006 16:49:34 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k4Q75puJ025003
	for <linuxppc-dev@ozlabs.org>; Fri, 26 May 2006 00:05:51 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k4Q6nUqN009990
	for <linuxppc-dev@ozlabs.org>; Fri, 26 May 2006 01:49:32 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD4673064DA761@zch01exm40.ap.freescale.net>
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Fleming Andy-afleming <afleming@freescale.com>
Subject: RE: [PATCH/2.6.17-rc4 1/10] Powerpc: Add general support for mpc7
	448h pc2 (Taiga) platform
Date: Fri, 26 May 2006 14:49:26 +0800
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

> 
> On Thu, 2006-05-18 at 15:49 -0500, Andy Fleming wrote:
> > 
> > 
> > So some of this needs to be moved into u-boot (look at my 
> patches to 
> > u-boot for the 85xx CDS support, and support in the current
> > powerpc.git tree).  A lot of the PCI initialization is now there.   
> > However, the interrupt maps, while properly setup in the 
> current 85xx 
> > u-boot oftree.dts files, is currently meaningless.  I may be wrong, 
> > but I thought support for getting the map from the flat-dev 
> tree was 
> > still pending....
> 
> Well, the kernel does get the map from the tree but can't use 
> it if the device itself doesn't have a device-node. I'll fix 
> that for 2.6.18 hopefully.
> 
> Ben.
> 

What should  we do? 
Can we  keep the map table unitl your code 
is OK?

Roy
 
