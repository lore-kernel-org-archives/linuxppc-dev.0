Return-Path: <mingo@elte.hu>
Received: from fallback.mail.elte.hu (fallback.mail.elte.hu [157.181.151.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1219CDDE02
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Nov 2007 05:10:40 +1100 (EST)
Received: from mx3.mail.elte.hu ([157.181.1.138])
	by fallback.mail.elte.hu with esmtp (Exim) id 1ItS7m-0006zf-9W
	from <mingo@elte.hu>
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Nov 2007 19:10:34 +0100
Date: Sat, 17 Nov 2007 19:09:46 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Torsten Kaiser <just.for.lkml@googlemail.com>
Subject: Re: [BUG] 2.6.24-rc2-mm1 - kernel bug on nfs v4
Message-ID: <20071117180946.GA14055@elte.hu>
References: <473DA608.1020804@linux.vnet.ibm.com>
	<64bb37e0711170953p67d1be49lf4eaa190d662e2b4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <64bb37e0711170953p67d1be49lf4eaa190d662e2b4@mail.gmail.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	LKML <linux-kernel@vger.kernel.org>,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
	linuxppc-dev@ozlabs.org, nfs@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>, Jan Blunck <jblunck@suse.de>,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Torsten Kaiser <just.for.lkml@googlemail.com> wrote:

> Sadly lockdep does not work for me, as it gets turned off early:
> [   39.851594] ---------------------------------
> [   39.855963] inconsistent {softirq-on-W} -> {in-softirq-W} usage.
> [   39.861981] swapper/0 [HC0[0]:SC1[1]:HE0:SE0] takes:
> [   39.866963]  (&n->list_lock){-+..}, at: [<ffffffff802935c1>]

hey, that means it found a bug - which is not sad at all :-)

	Ingo
