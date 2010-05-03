Return-Path: <dave@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E55BCB7D1C
	for <linuxppc-dev@ozlabs.org>; Tue,  4 May 2010 07:02:41 +1000 (EST)
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e2.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o43Kosjv024106
	for <linuxppc-dev@ozlabs.org>; Mon, 3 May 2010 16:50:54 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o43L2aDY161230
	for <linuxppc-dev@ozlabs.org>; Mon, 3 May 2010 17:02:36 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o43L2ZEt017235
	for <linuxppc-dev@ozlabs.org>; Mon, 3 May 2010 18:02:36 -0300
Subject: Re: [PATCH v21 001/100] eclone (1/11): Factor out code to allocate
	pidmap page
From: Dave Hansen <dave@linux.vnet.ibm.com>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20100501.151022.190375136.davem@davemloft.net>
References: <1272723382-19470-1-git-send-email-orenl@cs.columbia.edu>
	<1272723382-19470-2-git-send-email-orenl@cs.columbia.edu>
	<20100501.151022.190375136.davem@davemloft.net>
Content-Type: text/plain
Date: Mon, 03 May 2010 14:02:31 -0700
Message-Id: <1272920551.12034.4729.camel@nimitz>
Mime-Version: 1.0
Cc: linux-s390@vger.kernel.org, orenl@cs.columbia.edu,
	containers@lists.linux-foundation.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	matthltc@us.ibm.com, linux-api@vger.kernel.org, serue@us.ibm.com,
	akpm@linux-foundation.org, sukadev@linux.vnet.ibm.com, xemul@openvz.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2010-05-01 at 15:10 -0700, David Miller wrote:
> NO WAY, there is no way in the world you should post 100 patches
> at a time to any mailing list, especially those at vger.kernel.org
> that have thousands upon thousands of subscribers.
> 
> Post only small, well contained, sets of patches at a time.  At most
> 10 or so in one go.

Hi Dave,

I really do apologize if these caused undue traffic on vger.  It
certainly wasn't our intention to cause any problems.

We've had a fear all along that we'll just go back into our little
containers@lists.linux-foundation.org, and go astray of what the
community wants done with these patches.  It's also important to
remember that these really do affect the entire kernel.  Unfortunately,
it's not really a single feature or something that fits well on any
other mailing list.  It has implications _everywhere_.  I think Andrew
Morton also asked that these continue coming to LKML, although his
request probably came at a time when the set was a wee bit smaller.

> Do you realize how much mail traffic you generate by posting so many
> patches at one time, and how unlikely it is for anyone to actually
> sift through and review your patches after you've spammed them by
> posting so many at one time?

I honestly don't expect people to be reading the whole thing at once.
But, I do hope that people can take a look at their individual bits that
are touched.

> A second infraction and I will have no choice but to block you at the
> SMTP level at vger.kernel.org so please do not do it again.

I know these patches are certainly not at the level of importance as,
say the pata or -stable updates, but they're certainly not of
unprecedented scale.  I've seen a number of patchbombs of this size
recently.

I hope Andrew pulls this set into -mm so this doesn't even come up
again.  But, if it does, can you make some suggestions on how to be more
kind to vger in the process?

-- Dave
