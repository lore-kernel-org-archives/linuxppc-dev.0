Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id DC9B067C30
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2006 21:04:29 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k7OB4Shs003493
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2006 04:04:28 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k7OB4Qd3021755
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2006 06:04:27 -0500 (CDT)
Subject: Re: [PATCH ] powerpc: Add tsi108/9 and non standard mpic support
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1156416857.8433.244.camel@localhost.localdomain>
References: <7EA18FDD2DC2154AA3BD6D2F22A62A0E19E353@zch01exm23.fsl.freescale.net>
	<1156398135.5913.43.camel@localhost.localdomain>
	<1156398861.8433.197.camel@localhost.localdomain>
	<1156413135.6591.14.camel@localhost.localdomain>
	<1156416857.8433.244.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1156417448.7107.1.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 24 Aug 2006 19:04:08 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-08-24 at 18:54, Benjamin Herrenschmidt wrote:
> > > The table should still contain the entries for a normal MPIC. One
> can
> > > build a kernel that will boot both machines with the "weird" one
> and
> > > with the normal one. Thus CONFIG_MPIC_WEIRD shall not exclude
> normal
> > > MPICs, though not having it does exclude weird ones. I thus would
> > > suggest to keep the table as it was in your earlier patches, that
> is
> > > with the normal MPIC mapping at 0.
> > > 
> > > I intend to re-use that to handle another weird MPIC from some
> other
> > > project :)
> > 
> > That is also my target. I hope the imported mpic_info table can
> support
> > more non-standard mpic structure.
> > The following patch adds the standard MPIC entry to the table. 
> > I post it here.
> 
> Looks good. I still need to test it, hopefully tomorrow, then it can
> go
> in though I'm not sure it can get into 2.6.18, we'll see.
> 

I have tested on mpc8641hpcn board with CONFIG_MPIC.
Hope to see it in 2.6.18.
Roy
