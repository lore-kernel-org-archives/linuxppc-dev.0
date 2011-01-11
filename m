Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 941CFB6F1E
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Jan 2011 19:12:50 +1100 (EST)
In-Reply-To: <20110111060926.GE16301@1wt.eu>
References: <1294695479-344-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<20110111060926.GE16301@1wt.eu>
Subject: Re: [PATCH 00/13] powerpc: Backport 8xx TLB to 2.4
To: Willy Tarreau <w@1wt.eu>
Message-ID: <OFEC114402.5A694921-ONC1257815.002CC8F2-C1257815.002D1C7D@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 11 Jan 2011 09:12:44 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
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

Willy Tarreau <w@1wt.eu> wrote on 2011/01/11 07:09:26:
>
> Hi Joakim,
>
> On Mon, Jan 10, 2011 at 10:37:46PM +0100, Joakim Tjernlund wrote:
> > This is a backport from 2.6 which I did to overcome 8xx CPU
> > bugs. 8xx does not update the DAR register when taking a TLB
> > error caused by dcbX and icbi insns which makes it very
> > tricky to use these insns. Also the dcbst wrongly sets the
> > the store bit when faulting into DTLB error.
> > A few more bugs very found during development.
> >
> > I know 2.4 is in strict maintenance mode and 8xx is obsolete
> > but as it is still in use I wanted 8xx to age with grace.
>
> Thank you very much for taking care of this, that's very much appreciated.
> I'll look at this ASAP. Just a quick question in order to be certain, did
> you have the opportunity to test all of these changes on real hardware ?

I tested these on real 8xx HW but I used an older 2.4 linux as we haven't
moved forward on 2.4 for quite some time.
The affected files were almost identical though. Would be great if
Scott could give them a spin on 8xx with current 2.4.

      Jocke
