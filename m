Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 180F4DDF3C
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 04:56:12 +1000 (EST)
Message-ID: <469FB3C4.8070909@freescale.com>
Date: Thu, 19 Jul 2007 13:56:04 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 49/61] 8xx: Update device trees.
References: <20070718013604.GU15238@ld0162-tx32.am.freescale.net>
	<F8A0BE8F-8DBE-42DC-B3CD-02EB339A739E@kernel.crashing.org>
	<20070719205745.57f9d5a0@localhost.localdomain>
	<B71D432E-5C61-4873-9B35-9C7825AABCBD@kernel.crashing.org>
In-Reply-To: <B71D432E-5C61-4873-9B35-9C7825AABCBD@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
> Since you are using generic names, the only use for the "name"
> of a node is for a human reader to understand your tree.  Maybe
> everyone using this specific SoC knows what a BCSR is; or maybe
> there is a more friendly name you could use.

It's the standard term used in Freescale board documentation.  I could 
change it to board-control, though.

-Scott
