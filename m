Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B00BFDDECD
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jan 2007 06:55:43 +1100 (EST)
Subject: Re: [PATCH 1/5] [POWERPC] cpm2: CPM2 interrupt controller fix
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Vitaly Bordug <vbordug@ru.mvista.com>
In-Reply-To: <20070122164316.79569af9@localhost.localdomain>
References: <20070113004150.1224.58427.stgit@localhost.localdomain>
	<17844.35471.554647.189851@cargo.ozlabs.ibm.com>
	<20070122164316.79569af9@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 23 Jan 2007 06:55:37 +1100
Message-Id: <1169495737.1582.7.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-01-22 at 16:43 +0300, Vitaly Bordug wrote:
> On Mon, 22 Jan 2007 20:57:35 +1100
> Paul Mackerras wrote:
> 
> > Vitaly Bordug writes:
> > 
> > > This contains important fixes for the CPM2 PIC code. Eliminated
> > > CPM_IRQ_OFFSET, pulling the respective interrupt numbers from the
> > > interrupt mapping. Updated devicetree files to reflect that.
> > > Changed direct IC-related IO accesses to the IO accessors. Fixed
> > > all the sense values to keep coherency with ipic. In the current
> > > code, CPM2 stuff will have no IRQs and hence could be hardly usable.
> > 
> > You seem to be adding significant stuff; include/asm-powerpc/mpc8260.h
> > is new, and there is this hunk in your patch 4/5:

> As I said, new io.h in powerpc broke compilation for both 8272 and 8560 that were committted.

I missed that report of breakage, can you give me more details on what
happens ?
