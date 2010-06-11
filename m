Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 280711007D7
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jun 2010 11:16:47 +1000 (EST)
Subject: Re: [PATCH 0/2] Replace of_device with platform_device
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <AANLkTik2j5iDwcgIl_WyajaSRqLx5WK8Zf-25FBJ92Ch@mail.gmail.com>
References: <20100604205930.2762.17131.stgit@angua>
	<AANLkTim24kEYJplwHYgZK0EGRm_7LtQ3fWm8OmC9rvTK@mail.gmail.com>
	<1276151543.1962.48.camel@pasglop>
	<AANLkTik2j5iDwcgIl_WyajaSRqLx5WK8Zf-25FBJ92Ch@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 11 Jun 2010 11:16:30 +1000
Message-ID: <1276218990.1962.81.camel@pasglop>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Michal Simek <monstr@monstr.eu>,
	microblaze-uclinux@itee.uq.edu.au, linuxppc-dev <linuxppc-dev@ozlabs.org>,
	sparclinux@vger.kernel.org, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-06-10 at 10:46 -0600, Grant Likely wrote:
> 
> It shouldn't need any fixing because I'm not touching the driver side
> of the equation (unlike the last breakage where macio_driver had its
> own copy of the match table which I missed).  In fact, there aren't
> even any logic changes other than dealing with moving some of the
> structure members in the sparc arch code.  If I did miss anything,
> then it should show up in build testing.

Ok, but I though you were actually replacing occurences of "of_device"
with "platform_device", and so was wondering why you aren't changing the
ones in macio. But yes, the #define you did might do the trick as long
as the resources are still named the same etc...

Cheers,
Ben.
