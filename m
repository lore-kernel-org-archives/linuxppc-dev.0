Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A1340DDEA3
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 09:36:51 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lB4MalLj003466
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Dec 2007 17:36:47 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lB4Mabrn091476
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Dec 2007 15:36:38 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lB4Maam5013249
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Dec 2007 15:36:37 -0700
Date: Tue, 4 Dec 2007 16:34:09 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Merge dtc
Message-ID: <20071204163409.6d03c7a5@zod.rchland.ibm.com>
In-Reply-To: <18261.53985.700234.923526@cargo.ozlabs.ibm.com>
References: <20071016050217.GA9052@localhost.localdomain>
	<1196733544.13978.201.camel@pmac.infradead.org>
	<18261.53985.700234.923526@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Gibson <david@gibson.dropbear.id.au>,
	David Woodhouse <dwmw2@infradead.org>, David
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 5 Dec 2007 09:21:21 +1100
Paul Mackerras <paulus@samba.org> wrote:

> David Woodhouse writes:
> 
> > I think this is a bad idea -- it's hardly a difficult for those people
> > who _do_ need dts to obtain it separately.
> 
> The trouble is that it's not just people who are making a kernel for a
> specific embedded board that need dtc.  These days anyone who wants to
> try cross-compiling a powerpc kernel and does a make allyesconfig, or
> who picks cell_defconfig or ps3_defconfig to try, needs dtc if their
> kernel build is to go all the way through and give them an exit status
> of 0.  I can see that for people who are trying to do the right thing
> and compile-test their patch across architectures, it's annoying that
> powerpc has an extra external requirement when no other architecture
> does, and it usually just means they don't compile-test on powerpc.
> 
> Of the various options for solving this, including dtc in the kernel
> sources seems best to me.

Using that same reasoning, should we merge a mkimage patch for the
boards that use U-Boot?

(That's a serious question, not a smart-ass response)

josh
