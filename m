Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id B7E9FDDE48
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 13:07:46 +1000 (EST)
Date: Mon, 23 Apr 2007 22:07:48 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] DMA 4GB boundary protection
Message-ID: <20070424030748.GA29492@lixom.net>
References: <1172872183.5310.145.camel@goblue>
	<20070303232915.GB8028@lixom.net>
	<1174511149.5225.135.camel@goblue>
	<20070322175324.GA21120@lixom.net>
	<1175026241.1398.23.camel@goblue>
	<20070328155635.GA14356@lixom.net>
	<1175105842.1398.43.camel@goblue>
	<1175124183.32220.17.camel@localhost.localdomain>
	<1175175842.1398.54.camel@goblue>
	<17964.42216.839568.476369@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17964.42216.839568.476369@cargo.ozlabs.ibm.com>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 23, 2007 at 10:22:00PM +1000, Paul Mackerras wrote:
> Jake,
> 
> It looks like I have applied both the final version of this patch
> (569975591c5530fdc9c7a3c45122e5e46f075a74) and the original version
> (618d3adc351a24c4c48437c767befb88ca2d199d) that modified
> iommu_range_alloc().
> 
> Should I revert the original version?

(Since I didn't see a reply from Jake today):

Yes, please do. It's redundant given the better patch that went in later.


Thanks,

-Olof
