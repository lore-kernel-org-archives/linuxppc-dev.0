Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 05B35DDE16
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Sep 2007 04:48:27 +1000 (EST)
Date: Tue, 4 Sep 2007 13:48:10 -0500
From: Scott Wood <scottwood@freescale.com>
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: "atomic" 64-bit math on 32-bit ppc's?
Message-ID: <20070904184810.GG18280@ld0162-tx32.am.freescale.net>
References: <46DD3CE2.4060301@genesi-usa.com> <20070904113937.GA3994@iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070904113937.GA3994@iram.es>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 04, 2007 at 01:39:37PM +0200, Gabriel Paubert wrote:
> That's wrong if lock is assigned to r0, you should use
> a "b" constraint to avoid this. Same for atomic_dec below.

GCC should really have removed r0 from the "r" class (it isn't truly a
general-purpose register), and had a different class meaning "r"-plus-r0.

-Scott
