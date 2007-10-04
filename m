Return-Path: <linas@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BF055DDE1D
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Oct 2007 04:36:54 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l94IaoN2024936
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Oct 2007 14:36:50 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l94Ian1e575950
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Oct 2007 14:36:49 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l94IadLQ013528
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Oct 2007 14:36:39 -0400
Date: Thu, 4 Oct 2007 13:36:29 -0500
To: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH 2/2]: PCI Error Recovery: Symbios SCSI First Failure
Message-ID: <20071004183629.GH4338@austin.ibm.com>
References: <20070420204114.GL31947@austin.ibm.com>
	<20070420204720.GM31947@austin.ibm.com>
	<20070926150216.GH3899@parisc-linux.org>
	<20070927220022.GC18686@austin.ibm.com>
	<20070927221031.GY3899@parisc-linux.org>
	<20070927233437.GF18686@austin.ibm.com>
	<20071001201247.GN12049@parisc-linux.org>
	<20071001224132.GH4338@austin.ibm.com>
	<20071002012730.GO12049@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071002012730.GO12049@parisc-linux.org>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 01, 2007 at 07:27:30PM -0600, Matthew Wilcox wrote:
> 
> The thing to remember is that sym2 is in transition from being a dual
> BSD/Linux driver to being a purely Linux driver. 

I was wondering about that; couldn't tell if the split in the code
was historical, or being intentionally maintained.

> > My gut instinct is to say "ack", although prudence dictates that 
> > I should test first. Which might take a few days...
> 
> Fine by me.  

I tested the patch, it worked great. It also seemed to recover 
much more quickly -- so quickly, in fact, that I thought something 
had gone wrong.

I reviewed it one more time, it really does look good. A formal
submission and acked by's at earliest convenience would be good. 

--linas
