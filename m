Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9380CDDEDC
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jun 2007 07:23:51 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l5LLNkmu029303
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Jun 2007 14:23:46 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l5LLNj0i013677
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Jun 2007 16:23:45 -0500 (CDT)
Subject: Re: [PATCH v2 0/9] Add Generic PCI-E support to 8641HPCN
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
In-Reply-To: <1180996188.9632.68.camel@ld0161-tx32>
References: <1180996188.9632.68.camel@ld0161-tx32>
Content-Type: text/plain
Message-Id: <1182461025.21421.48.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Thu, 21 Jun 2007 16:23:45 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-06-04 at 17:29, Jon Loeliger wrote:
> Paul,
> 
> This 8-part patch set combines the two previous patch
> sets, 5 from Zheng Wei, and 3 from me, along with one
> from Wade Farnsworth into one nice-n-happy set, all
> designed to re-enable PCI-Express on the MPC8641HPCN board.
> 
> This is version 2 of the patch set and incorporates
> improvements suggested by list reviewers.


Paul,

I hadn't seen any further comment on this series of
patches for PCI on 8641.  Any chance we could get them
applied to your repo?

Thanks,
jdl
