Return-Path: <joe@perches.com>
Received: from mail.perches.com (mail.perches.com [173.55.12.10])
	by ozlabs.org (Postfix) with ESMTP id 259F2B6EE9
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  4 Mar 2011 14:29:22 +1100 (EST)
Subject: Re: [PATCH] powerpc: disable MSI using new interface if possible
From: Joe Perches <joe@perches.com>
To: michael@ellerman.id.au
In-Reply-To: <1299208016.3630.81.camel@concordia>
References: <1299200729.3630.52.camel@concordia>
	<1299202862-10682-1-git-send-email-nacc@us.ibm.com>
	<1299208016.3630.81.camel@concordia>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 03 Mar 2011 19:29:19 -0800
Message-ID: <1299209359.4338.220.camel@Joe-Laptop>
Mime-Version: 1.0
Cc: Nishanth Aravamudan <nacc@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
	Florian Mickler <florian@mickler.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-03-04 at 14:06 +1100, Michael Ellerman wrote:
> On Thu, 2011-03-03 at 17:41 -0800, Nishanth Aravamudan wrote:
> > On 04.03.2011 [12:05:29 +1100], Michael Ellerman wrote:
> > > Cc: Me  :)
> > Sorry! I was in a hurry to get this out the door, my fault. Note, you
> > don't show up per scripts/get_maintainer.pl :)
> No worries, though I will remember never to use get_maintainer.pl, it is
> obviously utterly broken:

Blah, blah, stupid tool doesn't work exactly as I want,
and it doesn't credit me for my over 2 year old patches,
therefore it's not only stupid, it's broken...

$ ./scripts/get_maintainer.pl -f arch/powerpc/platforms/pseries/msi.c
Benjamin Herrenschmidt <benh@kernel.crashing.org> (supporter:LINUX FOR POWERPC...)
Paul Mackerras <paulus@samba.org> (supporter:LINUX FOR POWERPC...)
Grant Likely <grant.likely@secretlab.ca> (maintainer:OPEN FIRMWARE AND...)
linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC...)
linux-kernel@vger.kernel.org (open list)
devicetree-discuss@lists.ozlabs.org (open list:OPEN FIRMWARE AND...)

If you don't like how it currently works, suggest
improvements.

> $ git log --pretty=format:"%an %ae" arch/powerpc/platforms/pseries/msi.c
> Andre Detsch adetsch@br.ibm.com
> Michael Ellerman michael@ellerman.id.au
> Michael Ellerman michael@ellerman.id.au
> Michael Ellerman michael@ellerman.id.au
> Michael Ellerman michael@ellerman.id.au
> Michael Ellerman michael@ellerman.id.au
> Michael Ellerman michael@ellerman.id.au
> Michael Ellerman michael@ellerman.id.au
> Michael Ellerman michael@ellerman.id.au
> Michael Ellerman michael@ellerman.id.au
> Michael Ellerman michael@ellerman.id.au
> Michael Ellerman michael@ellerman.id.au
> 
> And the patch from Andre was also signed off by me.

How nice for you.  Last patch from you was
2 years ago.

$ git log --format="%an %ae %ad" arch/powerpc/platforms/pseries/msi.c
Andre Detsch adetsch@br.ibm.com Wed Nov 4 13:03:19 2009 -0200
Michael Ellerman michael@ellerman.id.au Thu Mar 5 14:44:26 2009 +0000
Michael Ellerman michael@ellerman.id.au Tue Feb 17 00:21:56 2009 +0000
Michael Ellerman michael@ellerman.id.au Tue Feb 17 00:18:49 2009 +0000
Michael Ellerman michael@ellerman.id.au Thu Jan 22 20:54:33 2009 +0000
Michael Ellerman michael@ellerman.id.au Thu Jan 22 20:54:32 2009 +0000
Michael Ellerman michael@ellerman.id.au Thu Jan 22 20:54:31 2009 +0000
Michael Ellerman michael@ellerman.id.au Thu Jan 22 20:54:31 2009 +0000
Michael Ellerman michael@ellerman.id.au Tue Oct 23 14:23:44 2007 +1000
Michael Ellerman michael@ellerman.id.au Thu Sep 20 16:36:50 2007 +1000
Michael Ellerman michael@ellerman.id.au Thu Sep 20 16:36:48 2007 +1000
Michael Ellerman michael@ellerman.id.au Tue May 8 12:58:35 2007 +1000

CC'ing inactive non named maintainers via git
history also draws complaints btw.
