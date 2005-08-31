Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp2.wanadoo.fr (smtp2.wanadoo.fr [193.252.22.29])
	by ozlabs.org (Postfix) with ESMTP id EF20768077
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Aug 2005 19:53:31 +1000 (EST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf0206.wanadoo.fr (SMTP Server) with ESMTP id C63B31C0017A
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Aug 2005 11:53:26 +0200 (CEST)
Received: from pegasos (AStrasbourg-251-1-27-135.w82-126.abo.wanadoo.fr
	[82.126.145.135])
	by mwinf0206.wanadoo.fr (SMTP Server) with ESMTP id A56B81C00175
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Aug 2005 11:53:26 +0200 (CEST)
Date: Wed, 31 Aug 2005 11:47:29 +0200
To: Nicolas DET <det.nicolas@free.fr>
Message-ID: <20050831094729.GA21009@localhost.localdomain>
References: <20050830233205.GB24345@xyzzy.farnsworth.org>
	<20050831055934.871E41C00097@mwinf1107.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050831055934.871E41C00097@mwinf1107.wanadoo.fr>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Marvell MV6436xx ethernet driver patch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 31, 2005 at 07:55:49AM +0100, Nicolas DET wrote:
> Hello Dale,
> > This is a good idea.  I suspect that most of the gain is from
> > turning off snooping and flushing/invalidating the cache explicitly.
> > Implementation-wise, I'd rather we not manipulate the MV643XX_ETH_BAR_?
> > registers directly in the driver.  Today that is done in platform
> > setup code.  This has promise but needs to be reworked.
> 
> Conclusion: yes, touching ETH_BAR isn't really well here, but where could
> we move it ?

What about : arch/ppc/plateform/chrp_pegasos_eth.c ?

Friendly,

Sven Luther
