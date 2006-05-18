Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 58B64679F3
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 17:16:22 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k4I7aCXo003740
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 00:36:12 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k4I7GI1S017290
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 02:16:19 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD4673062C066F@zch01exm40.ap.freescale.net>
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: RE: [PATCH/2.6.17-rc4 2/10] Powerpc: Add Tundra Semiconductor tsi
	108  macro define
Date: Thu, 18 May 2006 15:16:16 +0800
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
> > +/* Error codes */
> > +
> > +#define MPIC_OK		0
> > +#define MPIC_ERROR	1
> 
> What the heck are these for ?
> 
> Ben.
I will remove them.
Roy
> 
> 
