Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net
	[151.189.21.44])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 153BB679E7
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2006 03:49:31 +1000 (EST)
In-Reply-To: <20060816105925.GB21865@iram.es>
References: <17630.27174.711916.643790@cargo.ozlabs.ibm.com>
	<000301c6bf97$e9151e00$99dfdfdf@bakuhatsu.net>
	<17633.18057.778991.483461@cargo.ozlabs.ibm.com>
	<20060816105925.GB21865@iram.es>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <26A85218-4455-4132-8130-92F0502A8A5A@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: PowerPC paxtest results w/ gcc-4.1
Date: Wed, 16 Aug 2006 19:49:17 +0200
To: Gabriel Paubert <paubert@iram.es>
Cc: 'Albert Cahalan' <acahalan@gmail.com>, linuxppc-dev@ozlabs.org,
	debian-powerpc@lists.debian.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I never understood why PTE entries waste 4 bits (WIMG)
> for effectively very few valid combinations.

The only invalid combinations are WI=11 -- if you know of
a way to fit 12 combinations in fewer than 4 bits, let us
know :-)

Not all of those 12 are very useful, of course.


Segher
