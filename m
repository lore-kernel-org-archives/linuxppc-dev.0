Return-Path: <joe@perches.com>
Received: from mail.perches.com (mail.perches.com [173.55.12.10])
	by ozlabs.org (Postfix) with ESMTP id BB6FAB6F9C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Mar 2011 14:45:26 +1100 (EST)
Subject: Re: [PATCH] powerpc: disable MSI using new interface if possible
From: Joe Perches <joe@perches.com>
To: michael@ellerman.id.au
In-Reply-To: <1299728121.6272.46.camel@concordia>
References: <1299200729.3630.52.camel@concordia>
	<1299202862-10682-1-git-send-email-nacc@us.ibm.com>
	<1299208016.3630.81.camel@concordia>
	<1299209359.4338.220.camel@Joe-Laptop>
	<1299712336.6272.22.camel@concordia>
	<1299716903.20104.134.camel@Joe-Laptop>
	<1299728121.6272.46.camel@concordia>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 09 Mar 2011 19:45:23 -0800
Message-ID: <1299728723.20104.148.camel@Joe-Laptop>
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

On Thu, 2011-03-10 at 14:35 +1100, Michael Ellerman wrote:
> On Wed, 2011-03-09 at 16:28 -0800, Joe Perches wrote:
> > On Thu, 2011-03-10 at 10:12 +1100, Michael Ellerman wrote:
> > > True my last patch may have been two years ago, but I _wrote the entire
> > > file_, and essentially no one else has ever touched it.
> > > > If you don't like how it currently works, suggest
> > > > improvements.
> > > I think I was suggesting that I should be in that list :)
> > $ ./scripts/get_maintainer.pl -f --git-blame arch/powerpc/platforms/pseries/msi.c
> > Benjamin Herrenschmidt <benh@kernel.crashing.org> (supporter:LINUX FOR POWERPC...,commits:8/11=73%)
> > Paul Mackerras <paulus@samba.org> (supporter:LINUX FOR POWERPC...,commits:4/11=36%)
> > Grant Likely <grant.likely@secretlab.ca> (maintainer:OPEN FIRMWARE AND...)
> > Michael Ellerman <michael@ellerman.id.au> (authored lines:481/481=100%,commits:11/11=100%)
> > Linas Vepstas <linas@austin.ibm.com> (commits:1/11=9%)
> > linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC...)
> > linux-kernel@vger.kernel.org (open list)
> > devicetree-discuss@lists.ozlabs.org (open list:OPEN FIRMWARE AND...)
> That's awesome. But it's not the default, so hardly anyone will ever use
> it :)

It's not the default for a few reasons:

o It can take a _long_ time to run
o Linus Torvalds is still the "author of record"
  for all the files in the initial commit
o For files with activity, it doesn't add very
  much useful as old commit authors do also tend
  to show up in the new commits.
o It can show maintainers that are no longer
  active.
