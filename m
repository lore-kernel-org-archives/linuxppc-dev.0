Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B31B4DDDFF
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 09:07:50 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2CM7j58006655
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Mar 2007 18:07:45 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l2CM7ja9225354
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Mar 2007 18:07:45 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l2CM7iO9025978
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Mar 2007 18:07:45 -0400
Subject: Re: [PATCH 1/2] [powerpc] export symbols for use by lparcfg
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20070312213258.GA13648@lst.de>
References: <20070312192114.16630.90671.stgit@joxer.rchland.ibm.com>
	<20070312213258.GA13648@lst.de>
Content-Type: text/plain
Date: Mon, 12 Mar 2007 17:07:40 -0500
Message-Id: <1173737260.7716.25.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, sfr@canb.auug.org.au
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-12-03 at 22:32 +0100, Christoph Hellwig wrote:
> On Mon, Mar 12, 2007 at 01:21:14PM -0600, Will Schmidt wrote:
> > 
> > Updates the Kconfig to allow lparcfg to be built as a module, and
> > add the necessary EXPORT_SYMBOLS needed for a successful build.
> > 
> > Signed-off-by: Will Schmidt <will_schmidt@vnet.ibm.com>
> 
> NACK.  This is an awfull lot of deep down internal symbols, and there
> is no reason to make this a module.  If you fear about the space useage
> on non-phype platforms better reintroduce something like the
> __pmac/__chrp markers of the old ppc32 port.

Understood..    This used to be a module, I just wanted it to be a
module again.   I'm not worried about the space usage, honest. :-)

With this and Nathans response I'll happily second your NACK. 


-Will
