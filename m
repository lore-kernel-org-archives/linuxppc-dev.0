Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3F85B1007D1
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jun 2010 16:32:39 +1000 (EST)
Subject: Re: [PATCH 0/2] Replace of_device with platform_device
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <AANLkTim24kEYJplwHYgZK0EGRm_7LtQ3fWm8OmC9rvTK@mail.gmail.com>
References: <20100604205930.2762.17131.stgit@angua>
	<AANLkTim24kEYJplwHYgZK0EGRm_7LtQ3fWm8OmC9rvTK@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 10 Jun 2010 16:32:23 +1000
Message-ID: <1276151543.1962.48.camel@pasglop>
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

On Fri, 2010-06-04 at 15:13 -0600, Grant Likely wrote:
> This series is based on Linus' current tree.  It eliminate struct
> of_device in preparation for the merge of of_platform_bus_type and
> platform_bus_type.
> 
> Assuming there are no objections, I'll be putting these to linux-next
> to stew sometime next week.

I don't see any update to the macio stuff... have you fixed that
separately or are you up to breaking it -again- ? :-)

You should do build tests with a pmac32 or g5 defconfig every now and
then.

Cheers,
Ben.
