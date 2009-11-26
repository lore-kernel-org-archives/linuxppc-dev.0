Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 70E961007D3
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Nov 2009 20:06:05 +1100 (EST)
In-Reply-To: <1259225218.16367.333.camel@pasglop>
References: <Received>	
	<1257843644-8496-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1259032363.16367.108.camel@pasglop>	
	<OF23DC26B5.C444DA5A-ONC125767A.002E6FF8-C125767A.002EB4D0@transmode.se>
	<1259225218.16367.333.camel@pasglop>
Subject: Re: [PATCH] zlib: Optimize inffast when copying direct from output
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OFA086DC04.0AA63CCF-ONC125767A.00315861-C125767A.0031A337@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 26 Nov 2009 10:02:10 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 26/11/2009 09:46:58:
>
> On Thu, 2009-11-26 at 09:30 +0100, Joakim Tjernlund wrote:
> > > I'm not sure its going to work to use get_unaligned() like that on all
> > > archs .. it might be definitely something to discuss on some more
> > > appropriate mailing list.
> >
> > Oh, why not? Is that because I am using it wrongly or because xx_unaligned
> > is impl. incorrectly on some archs?
>
> I'm just not sure it works in boot wrappers in case archs ... I suppose
> it does but I haven't actually checked :-)

I am not aware of other boot wrappers than PowerPC and I believe ppc
should handle it as unaligned accesses aren't a problem there.

      Jocke
