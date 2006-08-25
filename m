Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 1184467C20
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Aug 2006 11:37:48 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	k7P1nwpF029023
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2006 18:49:58 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k7P1biq4019259
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2006 20:37:45 -0500 (CDT)
Subject: Re: [PATCH ] powerpc: Add tsi108/9 and non standard mpic support
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1156418003.8433.246.camel@localhost.localdomain>
References: <7EA18FDD2DC2154AA3BD6D2F22A62A0E19E353@zch01exm23.fsl.freescale.net>
	<1156398135.5913.43.camel@localhost.localdomain>
	<1156398861.8433.197.camel@localhost.localdomain>
	<1156413135.6591.14.camel@localhost.localdomain>
	<1156416857.8433.244.camel@localhost.localdomain>
	<1156417448.7107.1.camel@localhost.localdomain>
	<1156418003.8433.246.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1156469845.7107.6.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 25 Aug 2006 09:37:26 +0800
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

On Thu, 2006-08-24 at 19:13, Benjamin Herrenschmidt wrote:
> > I have tested on mpc8641hpcn board with CONFIG_MPIC.
> 
> I need to test it with normal MPIC machines and CONFIG_MPIC_WEIRD
> enabled
> 

For my design, it should have the same behavior just as CONFIG_MPIC, if
you pass MPIC_ID_MPIC flag.
We can see your result.

Roy
