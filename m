Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 35B8DDE923
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 23:55:28 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m3GDtPQq013246
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 09:55:25 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m3GDtPWx234520
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 09:55:25 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m3GDtOZG008635
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 09:55:25 -0400
Date: Wed, 16 Apr 2008 08:52:01 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: More patches pushed to powerpc.git master and powerpc-next
	branches
Message-ID: <20080416085201.48589898@zod.rchland.ibm.com>
In-Reply-To: <1208350168.6958.281.camel@pasglop>
References: <18437.61934.495516.351438@cargo.ozlabs.ibm.com>
	<20080416224510.85e9dace.sfr@canb.auug.org.au>
	<1208350168.6958.281.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Paul, Mackerras <paulus@samba.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 16 Apr 2008 22:49:28 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> On Wed, 2008-04-16 at 22:45 +1000, Stephen Rothwell wrote:
> > On Wed, 16 Apr 2008 22:32:46 +1000 Paul Mackerras <paulus@samba.org> wrote:
> > >
> > >       [POWERPC] ibm_newemac: PowerPC 440GX EMAC PHY clock workaround
> > >       [POWERPC] ibm_newemac: PowerPC 440EP/440GR EMAC PHY clock workaround
> > 
> > So close :-)
> 
> The workaround for those is actually subtely different :-0

He meant that they're broken.  See the other threads.

josh
