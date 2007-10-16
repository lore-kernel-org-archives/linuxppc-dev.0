Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4C46ADDE36
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 21:03:54 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9GB3ng1003804
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 07:03:49 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9GB3nbq118616
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 07:03:49 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9GB3dA0006627
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 07:03:39 -0400
Subject: Re: Merge dtc
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
In-Reply-To: <1192514497.19073.29.camel@pasglop>
References: <20071016050217.GA9052@localhost.localdomain>
	<B17BEF48-34FC-44E0-AC23-1DB7522EB198@kernel.crashing.org>
	<18196.20112.728499.256646@cargo.ozlabs.ibm.com>
	<5E3B6FCC-5930-4C76-AB4B-86B35551B9E0@kernel.crashing.org>
	<1192514497.19073.29.camel@pasglop>
Content-Type: text/plain
Date: Tue, 16 Oct 2007 05:53:34 -0500
Message-Id: <1192532014.13993.21.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-10-16 at 16:01 +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2007-10-16 at 00:50 -0500, Kumar Gala wrote:
> > Just out of interest who's complaining?  We don't include mkimage
> > for  
> > u-boot related builds and I haven't seen any gripes related to that.
> 
> It's a pain in the neck since those are built even for things that don't
> need them (such as 4xx where I use the treeboot images).

You might not need them, but others with 4xx boards do.  Boards like
Sequoia, etc don't use OpenBIOS.  And your compile didn't fail.  It just
didn't create the cuImage.

Anyway, I said a couple months ago we should include mkimage in the
kernel and I never got around to doing it.  I'll add it to the list.

josh
