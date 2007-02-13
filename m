Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 85299DDEBF
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 01:36:17 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1DEaEsO028452
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 09:36:14 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1DEa9Cf421164
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 07:36:09 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1DEa88m015522
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 07:36:08 -0700
Subject: Re: [0/16] Preliminary Ebony (440GP) support for arch/powerpc
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20070213060904.GA6214@localhost.localdomain>
References: <20070213060904.GA6214@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 13 Feb 2007 08:37:11 -0600
Message-Id: <1171377431.4003.36.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-02-13 at 17:09 +1100, David Gibson wrote:
> Here is a preliminary set of patches implementing support for the
> 440GP based Ebony evaluation board in arch/powerpc.  A number of the
> earlier patches are in Paul's queue already, so may appear in
> powerpc.git at any point.  Most of the later ones need at least some
> cleanup or reworking before they'll be ready for merging.
> 
> With these patches I can boot to a shell prompt on initrd on my Ebony
> board.  There are still a bunch of problems: clock timings are way out
> (runs about 4* fast), things freeze up when I attempt to use an
> nfsroot, many devices aren't supported.  A lot of things are hardcoded
> in the device tree, so you may well have to tweak it if your Ebony is
> different from mine.

FYI, these patches seem to want Ben's EMAC rewrite patch as well.  They
select Kconfig options that aren't present until that patch is applied.

We're also missing an arch/powerpc/configs/ebony_defconfig.

josh
