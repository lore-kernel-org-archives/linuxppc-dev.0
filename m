Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mailout-de.gmx.net [213.165.64.22])
	by ozlabs.org (Postfix) with SMTP id EAA52B70A5
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 10 Oct 2010 23:32:45 +1100 (EST)
Content-Type: text/plain; charset="utf-8"
Date: Sun, 10 Oct 2010 14:26:02 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <1286696147.2463.499.camel@pasglop>
Message-ID: <20101010122602.74300@gmx.net>
MIME-Version: 1.0
References: <20101010013755.1697.qmail@kosh.dhis.org>
	<1286696147.2463.499.camel@pasglop>
Subject: Re: Pegasos i8042 broken again
To: pacman@kosh.dhis.org
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sat, 2010-10-09 at 20:37 -0500, pacman@kosh.dhis.org wrote:
> Pegasos has no keyboard again. I blame commit
> 540c6c392f01887dcc96bef0a41e63e6c1334f01, which tries to find i8042 IRQs
> inthe device-tree but doesn't fall back to the old hardcoded 1 and 12 in
> all failure cases.
> 
> Specifically, the case where the device-tree contains nothing matching
> pnpPNP,303 or pnpPNP,f03 doesn't seem to be handled well. It sort of
> falls through to the old code, but leaves the IRQs set to 0.
> 
> The last time something like this happened, I submitted a patch:
> http://lists.ozlabs.org/pipermail/linuxppc-dev/2007-July/039988.html
> which got committed, but afterward I was scolded for working around a
> bug instead of fixing it in nvramrc.
> 
> This time I just won't send my workaround patch, at least until it's
> decided that the kernel should be made to understand the device-tree as
> is.
> If it's decided instead that the firmware should be patched... well I
> just don't feel comfortable inventing my own patch for nvramrc, since
> it's written in a language I don't know and presumably could brick the
> machine if I get it wrong. Also I'm not even sure what the kernel is
> expecting to find there.

Is this a Pegasos 1 or Pegasos 2? I'm just curious, because some Pegasos 1
users told me that newer Linux kernels don't even boot on their machines.

regards,

Gerhard
-- 
Neu: GMX De-Mail - Einfach wie E-Mail, sicher wie ein Brief!  
Jetzt De-Mail-Adresse reservieren: http://portal.gmx.net/de/go/demail
