Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 92D3DDE166
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Jun 2007 02:05:59 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Please pull from 'for_paulus' branch
Date: Fri, 29 Jun 2007 18:05:41 +0200
References: <Pine.LNX.4.64.0706290023590.15748@blarg.am.freescale.net>
	<200706291545.53890.arnd@arndb.de>
	<5921DF9C-31D0-4805-B699-4E634DAA2FB4@kernel.crashing.org>
In-Reply-To: <5921DF9C-31D0-4805-B699-4E634DAA2FB4@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706291805.42528.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 29 June 2007, Kumar Gala wrote:
> > Would it work reliably if we switch the arguments to
> > '-mcpu=3Dpowerpc64 -m64' instead of '-m64 -mcpu=3Dpowerpc64'? That
> > might be better than taking it out entirely.
>=20
> Is there a reason you didn't use -mcpu=3Dpower3 and -mcpu=3Drs64 for =A0
> those to CPU options?

Not an important one. From looking at gcc source, it seemed to
me that power3, rs64 and powerpc64 all specify the same instruction
set, so I went for the most generic one.

I guess we could always pass -mcpu=3Dpower3 instead of -mcpu=3Dpowerpc64
if that solves the problem.

	Arnd <><
