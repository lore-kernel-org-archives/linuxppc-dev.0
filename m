Return-Path: <linas@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A23EEDDEF0
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 08:00:03 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l92KpbvD026121
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Oct 2007 16:51:37 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l92M00Xi488434
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Oct 2007 16:00:00 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l92LxxAZ005880
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Oct 2007 15:59:59 -0600
Date: Tue, 2 Oct 2007 16:59:59 -0500
To: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH 2/2]: PCI Error Recovery: Symbios SCSI First Failure
Message-ID: <20071002215959.GM4338@austin.ibm.com>
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
> Fine by me.  Do you have the ability to produce failures on a whim on
> your platforms?  

Yes, although it is very platform specific -- there are actually
transistors in the pci bridge chip, which actually short out lines,
and so, from the point of view of the rest of the chip, it did
actually see a "real" error. Its supposed to be a very realistic 
test.

> I've been vaguely musing a PCI device failure patch for
> x86, just so people can test driver failure paths.

That would be good ... I've recently agreed to accept a fedex
to test someone elses card for them, which is outside my usual
activities.

There's also supposed to be some PCI-X riser card out there, 
(never seen one) which has the ability to inject actual pci 
errors. Its the Agilent PCI BestX card; I got the impression 
they might not sell it anymore; dunno.

One guy in the lab used to brush a grounding strap across
the pins; this usually got a rise out of the audience.

--linas
