Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1D10AB7C09
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Mar 2010 18:40:57 +1100 (EST)
In-Reply-To: <1268774452.2335.132.camel@pasglop>
References: <1267172983-28721-1-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1267172983-28721-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1267172983-28721-3-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1267172983-28721-4-git-send-email-Joakim.Tjernlund@transmode.se>
	<1268774452.2335.132.camel@pasglop>
Subject: Re: [PATCH 3/4] 8xx: Don't touch ACCESSED when no SWAP.
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OF67F8524B.B1AEA858-ONC12576E9.0029E36B-C12576E9.002A1FD5@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Wed, 17 Mar 2010 08:40:06 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 2010/03/16 22:20:52:
>
> On Fri, 2010-02-26 at 09:29 +0100, Joakim Tjernlund wrote:
> > Only the swap function cares about the ACCESSED bit in
> > the pte. Do not waste cycles updateting ACCESSED when swap
> > is not compiled into the kernel.
> > ---
>
> Your changeset comment is a bit misleading since the code isn't actually
> updating ACCESSED... it's testing if ACCESSED is set and goes to the
> higher level fault if not (which might then update ACCESSED).

Right, I did have one or two variants that did update ACCESSED that
I experimented with, I guess that I got a bit confused by that.

The jury is still out on whether this patch is an improvement or not.

    Jocke
