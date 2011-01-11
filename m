Return-Path: <w@1wt.eu>
Received: from 1wt.eu (1wt.eu [62.212.114.60])
	by ozlabs.org (Postfix) with ESMTP id D2C1DB6EE9
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Jan 2011 17:22:30 +1100 (EST)
Date: Tue, 11 Jan 2011 07:09:26 +0100
From: Willy Tarreau <w@1wt.eu>
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Subject: Re: [PATCH 00/13] powerpc: Backport 8xx TLB to 2.4
Message-ID: <20110111060926.GE16301@1wt.eu>
References: <1294695479-344-1-git-send-email-Joakim.Tjernlund@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1294695479-344-1-git-send-email-Joakim.Tjernlund@transmode.se>
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

On Mon, Jan 10, 2011 at 10:37:46PM +0100, Joakim Tjernlund wrote:
> This is a backport from 2.6 which I did to overcome 8xx CPU
> bugs. 8xx does not update the DAR register when taking a TLB
> error caused by dcbX and icbi insns which makes it very
> tricky to use these insns. Also the dcbst wrongly sets the
> the store bit when faulting into DTLB error.
> A few more bugs very found during development.
> 
> I know 2.4 is in strict maintenance mode and 8xx is obsolete
> but as it is still in use I wanted 8xx to age with grace.

Thank you very much for taking care of this, that's very much appreciated.
I'll look at this ASAP. Just a quick question in order to be certain, did
you have the opportunity to test all of these changes on real hardware ?

Thanks,
Willy
