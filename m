Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 13A99DDE41
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 12:11:20 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6B2BIuN008769
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 22:11:18 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l6B2BHwW161282
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 22:11:17 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6B2BHNK003228
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 22:11:17 -0400
Date: Tue, 10 Jul 2007 21:22:34 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2] Consolidate mm_context_t definition in mmu.h
Message-ID: <20070711022234.GI3925@crusty.rchland.ibm.com>
References: <1184089950.32199.24.camel@weaponx.rchland.ibm.com>
	<18068.4589.614583.210312@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18068.4589.614583.210312@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, arnd@arndb.de, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 11, 2007 at 09:10:37AM +1000, Paul Mackerras wrote:
> Josh Boyer writes:
> 
> > All of the platforms except PPC64 share a common mm_context_t definition.
> > Defining it in mmu.h avoids duplicating it in the platform specific mmu
> > header files.  We further consolidate it by having the PPC32 definition
> > share the mm_context_id_t type for the id member.
> 
> Unfortunately the string of ifdefs in your consolidated version makes
> my eyes water.  I'm not sure it isn't better the way it is.

Eh, you're the maintainer.  No worries.

Though realistically, I only added a single ifdef set in the structure.  The
rest are all Ben's ;)

josh
