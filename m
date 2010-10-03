Return-Path: <dave@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9040AB6F07
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  4 Oct 2010 05:11:08 +1100 (EST)
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e5.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o93Hopdn004303
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 3 Oct 2010 13:50:51 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o93IB4LU2257076
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 3 Oct 2010 14:11:04 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o93IB39F002097
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 3 Oct 2010 14:11:04 -0400
Subject: Re: [PATCH 7/9] v3 Define memory_block_size_bytes for powerpc/pseries
From: Dave Hansen <dave@linux.vnet.ibm.com>
To: Robin Holt <holt@sgi.com>
In-Reply-To: <20101003180731.GT14064@sgi.com>
References: <4CA62700.7010809@austin.ibm.com> <4CA62A0A.4050406@austin.ibm.com>
	<20101003175500.GE7896@balbir.in.ibm.com>
	<20101003180731.GT14064@sgi.com>
Content-Type: text/plain; charset="ANSI_X3.4-1968"
Date: Sun, 03 Oct 2010 11:11:01 -0700
Message-ID: <1286129461.9970.1.camel@nimitz>
Mime-Version: 1.0
Cc: Greg KH <greg@kroah.com>, steiner@sgi.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2010-10-03 at 13:07 -0500, Robin Holt wrote:
> On Sun, Oct 03, 2010 at 11:25:00PM +0530, Balbir Singh wrote:
> > * Nathan Fontenot <nfont@austin.ibm.com> [2010-10-01 13:35:54]:
> > 
> > > Define a version of memory_block_size_bytes() for powerpc/pseries such that
> > > a memory block spans an entire lmb.
> > 
> > I hope I am not missing anything obvious, but why not just call it
> > lmb_size, why do we need memblock_size?
> > 
> > Is lmb_size == memblock_size after your changes true for all
> > platforms?
> 
> What is an lmb?  I don't recall anything like lmb being referred to in
> the rest of the kernel.

Heh.  It's the OpenFirmware name for a Logical Memory Block.  Basically
what we use to determine the SECTION_SIZE on powerpc.  Probably not the
best terminology to use elsewhere in the kernel.

-- Dave
