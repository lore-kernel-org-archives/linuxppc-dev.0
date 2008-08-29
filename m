Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id 1A0B7DE057
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2008 22:32:43 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <200808291348.27652.david.jander@protonic.nl>
Subject: Re: Efficient memcpy()/memmove() for G2/G3 cores...
Date: Fri, 29 Aug 2008 14:21:43 +0200
Message-ID: <1220012433.5234.162.camel@gentoo-jocke.transmode.se>
References: <200808251131.02071.david.jander@protonic.nl>
	<1219703291.13162.106.camel@pasglop>
	<1219871079.28869.149.camel@spokane1.rchland.ibm.com>
	<200808291348.27652.david.jander@protonic.nl>
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "David Jander" <david.jander@protonic.nl>
Cc: munroesj@us.ibm.com, linuxppc-dev@ozlabs.org
Reply-To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-08-29 at 13:48 +0200, David Jander wrote:
> On Wednesday 27 August 2008 23:04:39 Steven Munroe wrote:
> > On Tue, 2008-08-26 at 08:28 +1000, Benjamin Herrenschmidt wrote:
> > > On Mon, 2008-08-25 at 15:06 +0200, David Jander wrote:
> > > > Hi Matt,

[SNIP]

> I am not complaining. I was only wondering if it is just me or there =
really is=20
> very little that has been done (for either uClibc, glibc, or whatever =
for=20
> powerpc) to improve performance of (linux-) applications on =
"lower"-power=20
> platforms (G2 core), AFAICS there is a LOT that can be gained by =
simple=20
> tweaks.

[SNIP]

>=20
> The problem is: I have very little experience with powerpc assembly =
and only=20
> very limited time to dedicate to this and I am looking for others who =
have=20

I improved the PowerPC memcpy and friends in uClibc a while ago. It does
basically the same a the kernel memcpy but without any cache
instructions. It is written in C, but in such a way that
optimal assembly is generated.

 Jocke
