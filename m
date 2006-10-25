Return-Path: <matt@genesi-usa.com>
Received: from mail.genesippc.com (mithrandir.softwarenexus.net [66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 63BD067C72
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Oct 2006 02:18:40 +1000 (EST)
Message-ID: <453F8E63.7090907@genesi-usa.com>
Date: Wed, 25 Oct 2006 18:18:43 +0200
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] General CHRP/MPC5K2 Platform and drivers support - to
	comment
References: <453771E5.4090808@bplan-gmbh.de> <453884F5.4000804@bplan-gmbh.de>	
	<122A4E06-B8A6-4256-B96E-3811EA93EA25@kernel.crashing.org>	
	<453B6A84.3050209@bplan-gmbh.de>	
	<1161585371.10524.444.camel@localhost.localdomain>	
	<453CD615.4050401@genesi-usa.com>	
	<17725.18623.768768.438157@cargo.ozlabs.ibm.com>	
	<453E34FB.3030209@genesi-usa.com>	
	<17726.39780.732843.150044@cargo.ozlabs.ibm.com>	
	<453F7832.2020305@genesi-usa.com>
	<528646bc0610250757i3754fc96uccddd8109f3a712@mail.gmail.com>
In-Reply-To: <528646bc0610250757i3754fc96uccddd8109f3a712@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arbitrary naming is fine.

Thinking up a bunch of excuses like "we refuse to bow to our corporate
marketing overlords" and "but it's definitely called PowerPC ISA, and
anyway, that new one which has a new name, I didn't read anyway, but it
undefines every processor we support" is just.. well I dunno. Making
excuses I guess.

I'm fine with the name I was just curious (see first line of the original
email) about how these things ARE named. It lead to a query I am still
wondering about the answer to; Genesi/bplan could have a new G5 platform
and whatever support code is required submitted to the tree soon. Since
it will have a fairly-PAPR-compliant firmware, this makes it logical to
put it in the CHRP platform for us. But CHRP doesn't include LPAR, this is
a pSeries platform feature. Segher suggested we use the Maple tree (!!)
as this runs SLOF.

What platform do you think a 970MP box with a CHRP-compliant (well, let
us say, Pegasos-compatible) firmware go, if we eventually want to support
LPAR, especially without code duplication and MBs of "pull this out of
pSeries and drop it into CHRP, even though CHRP technically doesn't
support any of this" stuff? Especially since Ben is being quite strict
about what goes into CHRP nowadays.

Is it time for a PAPR platform? Or is that against the Linux
anti-marketing-name lobby we have in here?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Grant Likely wrote:
> On 10/25/06, Matt Sealey <matt@genesi-usa.com> wrote:
>> It supports the original processors, G3, G4 etc. as well. Maybe not
>> the 601? I'm not sure. All the PowerPC ISA Books are in there and
>> information only seems to have been ADDED (or moved to another
>> book or been given a new book).
> 
> Why are we still talking about this?  None of it matters.
> 
> Who cares if the new ISA spec incorporates all of the old ones?  The
> old specs cannot be unpublished.  powerpc is a sufficient name for
> kernel source purposes and it will continue to have meaning in the
> minds of developers.  Marketing glossies can (and do) use the name de
> jour, but we don't have to.
> 
> As a side note; The move from ppc/ppc64->powerpc was a *technical*
> decision, not a marketing one.  It was done so there would be only one
> code base.  The choice of arch/powerpc was almost arbitrary.
> 
> Cheers,
> g.
> 
