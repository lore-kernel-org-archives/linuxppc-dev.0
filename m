Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by ozlabs.org (Postfix) with ESMTP id 4341B67E5F
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Oct 2006 00:57:21 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id 30so100171ugc
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 07:57:20 -0700 (PDT)
Message-ID: <528646bc0610250757i3754fc96uccddd8109f3a712@mail.gmail.com>
Date: Wed, 25 Oct 2006 08:57:19 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Matt Sealey" <matt@genesi-usa.com>
Subject: Re: [PATCH] General CHRP/MPC5K2 Platform and drivers support - to
	comment
In-Reply-To: <453F7832.2020305@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <453771E5.4090808@bplan-gmbh.de> <453884F5.4000804@bplan-gmbh.de>
	<122A4E06-B8A6-4256-B96E-3811EA93EA25@kernel.crashing.org>
	<453B6A84.3050209@bplan-gmbh.de>
	<1161585371.10524.444.camel@localhost.localdomain>
	<453CD615.4050401@genesi-usa.com>
	<17725.18623.768768.438157@cargo.ozlabs.ibm.com>
	<453E34FB.3030209@genesi-usa.com>
	<17726.39780.732843.150044@cargo.ozlabs.ibm.com>
	<453F7832.2020305@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/25/06, Matt Sealey <matt@genesi-usa.com> wrote:
> It supports the original processors, G3, G4 etc. as well. Maybe not
> the 601? I'm not sure. All the PowerPC ISA Books are in there and
> information only seems to have been ADDED (or moved to another
> book or been given a new book).

Why are we still talking about this?  None of it matters.

Who cares if the new ISA spec incorporates all of the old ones?  The
old specs cannot be unpublished.  powerpc is a sufficient name for
kernel source purposes and it will continue to have meaning in the
minds of developers.  Marketing glossies can (and do) use the name de
jour, but we don't have to.

As a side note; The move from ppc/ppc64->powerpc was a *technical*
decision, not a marketing one.  It was done so there would be only one
code base.  The choice of arch/powerpc was almost arbitrary.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
