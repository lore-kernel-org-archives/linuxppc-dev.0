Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7B12DDDDE3
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 14:51:41 +1100 (EST)
Subject: Re: Please pull from 'for-2.6.28' branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <392E3825-8E5D-46B0-84CA-24A701BEDF96@kernel.crashing.org>
References: <Pine.LNX.4.64.0810201304160.17086@blarg.am.freescale.net>
	<1224547898.7654.210.camel@pasglop>
	<392E3825-8E5D-46B0-84CA-24A701BEDF96@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 21 Oct 2008 14:51:34 +1100
Message-Id: <1224561094.7654.229.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-10-20 at 22:45 -0500, Kumar Gala wrote:
> 
> If you had conventions on naming this is the first I've heard of  
> them.  I know Paul asked about the [POWERPC] to powerpc: change on
> list.

Well, they weren't official, but others seem to have picked them up, no
big deal but heh, here now you know about them :-)

> I do so as well.  As stated above, if there are naming conventions  
> that are desired I'm happy to conform but just need to know what they
> are.

Well, my aim is mostly consistency. If you don't like what I want, I'm
happy to discuss it, but I'd like basically to keep consistency in the
naming conventions. In some cases though, my comment also refers to the
subject being a tad too vague to my taste. I know there isn't a strict
definition of what is good enough or not and we definitely don't want a
3 lines novel there, but in the case of the .dts file update, it would
have been useful to highlight that fact for example.

> The limit is based on trust.  I submitted all the other cleanup  
> patches to remove PPC_MERGE.  I think I can handle such a patch going
> via my tree.

I would have still preferred if we had discussed it before hand...

Cheers,
Ben.
