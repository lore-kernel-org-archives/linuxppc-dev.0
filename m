Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E19D0B7B78
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 17:21:28 +1100 (EST)
Subject: Re: I think I have 8xx working...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
In-Reply-To: <OFA38A7495.FD13F032-ONC1257650.001E7457-C1257650.001F51B8@transmode.se>
References: <20091015004127.GA15570@laura.chatsunix.int.mrv.com>
	<1255568772.2347.60.camel@pasglop>
	<20091015010855.GA32710@compile2.chatsunix.int.mrv.com>
	<1255569170.2347.62.camel@pasglop>
	<OFA38A7495.FD13F032-ONC1257650.001E7457-C1257650.001F51B8@transmode.se>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 15 Oct 2009 17:21:15 +1100
Message-Id: <1255587675.2347.92.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-10-15 at 07:42 +0200, Joakim Tjernlund wrote:
> I didn't say that, did I? More like:
> if I don't do tlbil_va at all I get a lot of extra/duplicate TLB
> errors
> for the same address. Adding the patch makes these go away.
> I guess one could do tlbil_va unconditionally but I didn't
> see any improvements from doing that, but this was all on 2.4

Ok so I misparsed you. I was advocating going unconditional here
and though you said it would increase the miss rate.

Cheers,
Ben
