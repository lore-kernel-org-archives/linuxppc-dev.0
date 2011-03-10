Return-Path: <nacc@us.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0FDC9B6EFE
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Mar 2011 11:46:22 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p2A0dgbu001883
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2011 17:39:42 -0700
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	p2A0kBD4103194
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2011 17:46:11 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p2A0kBkO012882
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2011 17:46:11 -0700
Date: Wed, 9 Mar 2011 16:46:09 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] powerpc: disable MSI using new interface if possible
Message-ID: <20110310004609.GI13406@us.ibm.com>
References: <1299200729.3630.52.camel@concordia>
	<1299202862-10682-1-git-send-email-nacc@us.ibm.com>
	<1299208016.3630.81.camel@concordia>
	<1299209359.4338.220.camel@Joe-Laptop>
	<1299712336.6272.22.camel@concordia>
	<1299716903.20104.134.camel@Joe-Laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1299716903.20104.134.camel@Joe-Laptop>
Cc: Florian Mickler <florian@mickler.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09.03.2011 [16:28:23 -0800], Joe Perches wrote:
> On Thu, 2011-03-10 at 10:12 +1100, Michael Ellerman wrote:
> > True my last patch may have been two years ago, but I _wrote the entire
> > file_, and essentially no one else has ever touched it.
> > 
> > > $ ./scripts/get_maintainer.pl -f arch/powerpc/platforms/pseries/msi.c
> > > Benjamin Herrenschmidt <benh@kernel.crashing.org> (supporter:LINUX FOR POWERPC...)
> > > Paul Mackerras <paulus@samba.org> (supporter:LINUX FOR POWERPC...)
> > > Grant Likely <grant.likely@secretlab.ca> (maintainer:OPEN FIRMWARE AND...)
> > > linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC...)
> > > linux-kernel@vger.kernel.org (open list)
> > > devicetree-discuss@lists.ozlabs.org (open list:OPEN FIRMWARE AND...)
> > > 
> > > If you don't like how it currently works, suggest
> > > improvements.
> > 
> > I think I was suggesting that I should be in that list :)
> 
> $ ./scripts/get_maintainer.pl -f --git-blame arch/powerpc/platforms/pseries/msi.c

Ah thanks, I didn't realize that flag existed, as I'd not needed to use
it before.

-Nish

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
