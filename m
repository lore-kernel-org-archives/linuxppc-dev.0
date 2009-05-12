Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5ED6DDDEE5
	for <linuxppc-dev@ozlabs.org>; Wed, 13 May 2009 02:48:01 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n4CGlebG013844
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 09:47:51 -0700 (MST)
Received: from b07421-ec1.am.freescale.net (b07421-ec1.am.freescale.net
	[10.82.121.43])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n4CGldKM009949
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 11:47:39 -0500 (CDT)
Date: Tue, 12 May 2009 11:47:38 -0500
From: Scott Wood <scottwood@freescale.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [RFC] Hardware Breakpoint interfaces implementation for PPC64
Message-ID: <20090512164738.GA1173@b07421-ec1.am.freescale.net>
References: <20090511200355.GA17988@in.ibm.com>
	<20090512115149.GA1885@yoda.jdub.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090512115149.GA1885@yoda.jdub.homelinux.org>
Cc: linuxppc-dev@ozlabs.org, Benjamin Herrenschmidt <benh@au1.ibm.com>,
	"K.Prasad" <prasad@linux.vnet.ibm.com>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 12, 2009 at 07:51:49AM -0400, Josh Boyer wrote:
> On Tue, May 12, 2009 at 01:33:55AM +0530, K.Prasad wrote:
> >- The patch is currently implemented only for PPC64 architecture. Other
> >  architectures (especially Book-E implementations are expected to
> >  happen in due course).
> 
> Does this mean you will work on transitioning Book-E implementations, or that
> you expect the Book-E maintainers to?  I'm just curious.  The code as written
> relies heavily on the DABR/MSR setup that ppc64 has and Book-E unfortunately
> doesn't follow that at all.

And since there will eventually be 64-bit book E chips, we need to use
something more specific than CONFIG_PPC64 in the #ifdef (easier now than
figuring out which ones are breakpoint-related later).

-Scott
