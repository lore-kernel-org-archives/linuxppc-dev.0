Return-Path: <sven@z-innov.com>
Received: from archon.plz.fr (archon.plz.fr [194.50.78.210])
	by ozlabs.org (Postfix) with ESMTP id E5760B706D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Mar 2011 08:41:51 +1100 (EST)
Date: Tue, 15 Mar 2011 22:41:49 +0100
From: Sven Luther <sven.luther@z-innov.com>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
Subject: Re: any chance to use a modern linux kernel on Pegasos1 G3 ?
Message-ID: <20110315214149.GA26249@z-innov.com>
References: <AANLkTimJwBfz=RksRtuj3M2VQoMjj1msUb78s1H=GfJM@mail.gmail.com>
	<AANLkTikKWrEqKH-4f2aMFnVUy-xCLnvxhtjF-pKUuC6e@mail.gmail.com>
	<AANLkTinOo9tJ5=WWF2WJEZn3VwAUOa+SOYE0txNm-moM@mail.gmail.com>
	<AANLkTim6urK-1-0MXrXZPTDWifZsi+7QEH_c8S-vzWSL@mail.gmail.com>
	<20110315171448.100300@gmx.net>
	<20110315174924.GA24001@z-innov.com>
	<20110315200855.240730@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110315200855.240730@gmx.net>
Cc: sven.luther@z-innov.com, ppc.addon@gmail.com, linuxppc-dev@lists.ozlabs.org,
	acrux_it@libero.it
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 15, 2011 at 09:08:55PM +0100, Gerhard Pircher wrote:
> 
> > Well, since this is long dead hardware not produced anymore, i don't see
> > how the OF could have unbroken itself by moving to powerpc.
> > 
> > It has been age since i looked into this, but to the best of my knowledge
> > (and i wrote the above code or at least the earlier versions) it should
> > be still broken.
> Any idea then, how the workaround can be ported to arch/powerpc/ or if
> there is a better one available?

Sorry, it has been years since i looked these parts of the linux kernel, so i don't really
know how the arch/powerpc code handles this differently. Your best guess is to hunt for the
code yourself, and find the place. I don't remember though if debugging at that time is 
easily possible though.

Friendly,

Sven Luther
