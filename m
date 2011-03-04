Return-Path: <florian@mickler.org>
Received: from mx01.d-labs.de (ist.d-labs.de [213.239.218.44])
	by ozlabs.org (Postfix) with ESMTP id 7853D1007D6
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  4 Mar 2011 22:22:38 +1100 (EST)
Date: Fri, 4 Mar 2011 12:13:26 +0100
From: Florian Mickler <florian@mickler.org>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] powerpc: disable MSI using new interface if possible
Message-ID: <20110304121326.03688af1@schatten.dmk.lab>
In-Reply-To: <1299209359.4338.220.camel@Joe-Laptop>
References: <1299200729.3630.52.camel@concordia>
	<1299202862-10682-1-git-send-email-nacc@us.ibm.com>
	<1299208016.3630.81.camel@concordia>
	<1299209359.4338.220.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Nishanth Aravamudan <nacc@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 03 Mar 2011 19:29:19 -0800
Joe Perches <joe@perches.com> wrote:

> > $ git log --pretty=format:"%an %ae" arch/powerpc/platforms/pseries/msi.c
> > Andre Detsch adetsch@br.ibm.com
> > Michael Ellerman michael@ellerman.id.au
> > Michael Ellerman michael@ellerman.id.au
> > Michael Ellerman michael@ellerman.id.au
> > Michael Ellerman michael@ellerman.id.au
> > Michael Ellerman michael@ellerman.id.au
> > Michael Ellerman michael@ellerman.id.au
> > Michael Ellerman michael@ellerman.id.au
> > Michael Ellerman michael@ellerman.id.au
> > Michael Ellerman michael@ellerman.id.au
> > Michael Ellerman michael@ellerman.id.au
> > Michael Ellerman michael@ellerman.id.au
> > 
> > And the patch from Andre was also signed off by me.
> 
> How nice for you.  Last patch from you was
> 2 years ago.
> 

The problem is, that it get's pretty slow if you don't do a time
cut-off... i don't know the complexity but i guess it's linear in
(number of files) * (number of commits) * (avg size of diffs) ... 
(if you compute the diffstat) 

What I'll probably try as soon as I have another few hours to spare
for get_maintainer.pl, is to implement a fall back to older history if
the data basis is not stable enough. 


> 
> CC'ing inactive non named maintainers via git
> history also draws complaints btw.
> 
Yes.  I guess, my current version could use an staggered approach where
it does more digging if the results are too volatile... but first
try to be fast ...

Regards,
Flo
