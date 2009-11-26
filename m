Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1EA7DB7B65
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Nov 2009 19:47:03 +1100 (EST)
Subject: Re: [PATCH] zlib: Optimize inffast when copying direct from output
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
In-Reply-To: <OF23DC26B5.C444DA5A-ONC125767A.002E6FF8-C125767A.002EB4D0@transmode.se>
References: <Received>
	<1257843644-8496-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1259032363.16367.108.camel@pasglop>
	<OF23DC26B5.C444DA5A-ONC125767A.002E6FF8-C125767A.002EB4D0@transmode.se>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 26 Nov 2009 19:46:58 +1100
Message-ID: <1259225218.16367.333.camel@pasglop>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-11-26 at 09:30 +0100, Joakim Tjernlund wrote:
> > I'm not sure its going to work to use get_unaligned() like that on all
> > archs .. it might be definitely something to discuss on some more
> > appropriate mailing list.
> 
> Oh, why not? Is that because I am using it wrongly or because xx_unaligned
> is impl. incorrectly on some archs? 

I'm just not sure it works in boot wrappers in case archs ... I suppose
it does but I haven't actually checked :-)

Cheers,
Ben.
