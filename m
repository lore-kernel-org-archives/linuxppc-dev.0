Return-Path: <w@1wt.eu>
Received: from 1wt.eu (1wt.eu [62.212.114.60])
	by ozlabs.org (Postfix) with ESMTP id 5B186B6F5C
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Jun 2011 05:47:19 +1000 (EST)
Date: Tue, 14 Jun 2011 21:31:06 +0200
From: Willy Tarreau <w@1wt.eu>
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Subject: Re: [PATCH 00/15]  Backport 8xx TLB to 2.4
Message-ID: <20110614193106.GA15583@1wt.eu>
References: <1308059700-10839-1-git-send-email-Joakim.Tjernlund@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1308059700-10839-1-git-send-email-Joakim.Tjernlund@transmode.se>
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Joakim,

On Tue, Jun 14, 2011 at 03:54:45PM +0200, Joakim Tjernlund wrote:
> This is a backport from 2.6 which I did to overcome 8xx CPU
> bugs. 8xx does not update the DAR register when taking a TLB
> error caused by dcbX and icbi insns which makes it very
> tricky to use these insns. Also the dcbst wrongly sets the
> the store bit when faulting into DTLB error.
> A few more bugs very found during development.
> 
> I know 2.4 is in strict maintenance mode and 8xx is obsolete
> but as it is still in use I wanted 8xx to age with grace.

OK, I'm not opposed to merge these patches and I really welcome your
work and want to thank you for having done it. However, I have
absolutely *zero* skills on ppc, so I want to ensure that someone
(possibly you) will be able to back me up in case of reported
regressions once these patches are merged. Since you say that the
code works on your board, I'm not much worried but at least Dan's
comment about the risk of performance regression has to be considered.
If we all agree that it's a tradeoff between performance and stability
or security, then that's a different matter of course !

Thanks !
Willy
