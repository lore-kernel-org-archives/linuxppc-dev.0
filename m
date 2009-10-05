Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B423DB7BB6
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Oct 2009 05:52:54 +1100 (EST)
In-Reply-To: <20091005182429.GB3576@loki.buserror.net>
References: <OF94793A12.243E8E02-ONC1257640.0040DE05-C1257640.00419DBD@transmode.se>
	<20090929210331.GA25779@laura.chatsunix.int.mrv.com>
	<OF5D06EC36.28A07DB5-ONC1257641.00299A2D-C1257641.002BE7B1@transmode.se>
	<OFFEC1BDFB.17183440-ONC1257641.002D81B9-C1257641.002DC24F@transmode.se>
	<20090930090002.GA2928@compile2.chatsunix.int.mrv.com>
	<OF46F87EEF.62BE7D78-ONC1257641.003D4172-C1257641.003E1445@transmode.se>
	<OFC29CE070.42D58057-ONC1257641.005F19FD-C1257641.005F8ED3@transmode.se>
	<1254350159.5699.21.camel@pasglop>
	<20091002214949.GA20514@b07421-ec1.am.freescale.net>
	<OF4175DD8E.796930EB-ONC1257644.002A7135-C1257644.002C7929@transmode.se>
	<20091005182429.GB3576@loki.buserror.net>
Subject: Re: [PATCH] powerpc/8xx: fix regression introduced by cache	coherency
	rewrite
To: Scott Wood <scottwood@freescale.com>
Message-ID: <OF84FF1827.22545513-ONC1257646.00673A80-C1257646.006781A3@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Mon, 5 Oct 2009 20:50:33 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Rex Feany <RFeany@mrv.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood <scottwood@freescale.com> wrote on 05/10/2009 20:24:29:
>
> On Sat, Oct 03, 2009 at 10:05:46AM +0200, Joakim Tjernlund wrote:
> > Scott Wood <scottwood@freescale.com> wrote on 02/10/2009 23:49:49:
> > > Adding a tlbil_va to do_page_fault makes the problem go away for me (on
> > > top of your "merge" branch) -- none of the other changes in this thread
> > > do (assuming I didn't miss any).  FWIW, when it gets stuck on a fault,
> > > DSISR is 0xc0000000, and handle_mm_fault returns zero.
> >
> > OK, that is a no translation error for a load (assuming trap is 0x400)
>
> Yes, 0x400.
>
> > Do you know what insn this is?
>
> Various lbz and lwz.

OK, this rules out any dcbX problem. Perhaps you can try any of Bens
ideas? Not sure what they were but hopefully you and Ben do :)

Preferably after you have tested my new patches :)

 Jocke
