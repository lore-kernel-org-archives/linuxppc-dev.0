Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6117DDDE1D
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 12:28:12 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l6H2MS6B005885
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 22:22:28 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6H2S97X205410
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 20:28:09 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6H2S8gI027393
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 20:28:08 -0600
Date: Mon, 16 Jul 2007 21:39:58 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC][PATCH 6/8] Walnut DTS
Message-ID: <20070717023957.GL3925@crusty.rchland.ibm.com>
References: <1184161957.32199.52.camel@weaponx.rchland.ibm.com>
	<1184162389.32199.65.camel@weaponx.rchland.ibm.com>
	<4EAC985A-2F04-465D-AB69-C67807310D7B@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA3030669AF@az33exm25.fsl.freescale.net>
	<28A3F6B9-512B-4D86-8E0D-A7680CCE2354@kernel.crashing.org>
	<1184622446.25235.89.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1184622446.25235.89.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Yoder Stuart-B08248 <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 17, 2007 at 07:47:26AM +1000, Benjamin Herrenschmidt wrote:
> > That "typical practice" is inspired by the need to explicitly
> > put #address-cells and #size-cells into the device tree if you
> > want Linux to properly parse the device tree, even if the default
> > values would work perfectly (if Linux would work correctly,
> > that is).
> 
> Linux does handle default values in some areas. The problem with default
> values is that they are badly defined and the spec contains gray areas
> and contradictions as to what the default values should be in some
> circumstances. As a general matter, I dislike default values because
> they somewhat require background knowledge of what default values should
> be in different contexts to "read" a device-tree. To be simple, I
> believe default values are a bad idea.

Right.  See, there are people like me that don't know what the default values
are/should be.  Having them explicitly listed, even if it's redundant, serves
as a good learning aid.

Now, realistically I do know what the default is in this case.  But I only
learned that recently.  With hopefully more people starting to port things
over to arch/powerpc it might be a good idea to document them at least.
Otherwise, I fear we'd wind up repeating ourselves over and over.

Could we get a 'thou shalt not rely on defaults' added to
booting-without-of.txt?  Or maybe something less draconian ;).

josh
