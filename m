Return-Path: <a.p.zijlstra@chello.nl>
Received: from merlin.infradead.org (merlin.infradead.org
	[IPv6:2001:4978:20e::2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 493201007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  7 Jul 2011 22:28:48 +1000 (EST)
Subject: Re: [regression] 3.0-rc boot failure -- bisected to cd4ea6ae3982
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: mahesh@linux.vnet.ibm.com
In-Reply-To: <20110707115531.GA21737@in.ibm.com>
References: <20110707102107.GA16666@in.ibm.com>
	<1310036375.3282.509.camel@twins> <20110707115531.GA21737@in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 07 Jul 2011 14:28:27 +0200
Message-ID: <1310041707.3282.569.camel@twins>
Mime-Version: 1.0
Cc: torvalds@linux-foundation.org, mingo@elte.hu, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-07-07 at 17:25 +0530, Mahesh J Salgaonkar wrote:
> > I guess I'm asking is, do smaller P7 machines boot? And if so, is there
> > any difference except size?
>=20
> Yes, the smaller P7 machine that I have with 20 CPUs and 2GB ram boots
> fine with 3.0.0-rc.=20

That sounds like a single node machine. P7 comes as {4,6,8}*4 (16,24,32
cpus) per socket. And that 2G doesn't sound like much either.
