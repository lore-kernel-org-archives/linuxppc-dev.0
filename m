Return-Path: <joern@wohnheim.fh-wedel.de>
Received: from moskovskaya.fh-wedel.de (mail.fh-wedel.de [213.39.232.198])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 60B1D67A67
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Mar 2005 09:27:08 +1100 (EST)
Date: Wed, 2 Mar 2005 22:53:08 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Gerhard Jaeger <g.jaeger@sysgo.com>
Message-ID: <20050302215308.GA6511@wohnheim.fh-wedel.de>
References: <46110262C7A0BF418DE9C9A5BD73F92807F2F94C@cceexc23.americas.cpqcorp.net>
	<200503011737.22205.g.jaeger@sysgo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <200503011737.22205.g.jaeger@sysgo.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Building a Kernel for the AMCC PPC440EP Bamboo Board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 1 March 2005 17:37:22 +0100, Gerhard Jaeger wrote:
> On Tuesday 01 March 2005 17:14, Zeighami, Roy wrote:
> > 
> > When I select 44x as the CPU type, I don't see "Bamboo" under machine
> > type.  
> 
> This won't work, as Bamboo BSP stuff is currently not added.

Correct.

> > Any suggestions?
> 
> try to use ebony_defconfig

Doesn't work, neither does ocotea.  Both are able to display "TUX!" on
the dot-matrix display, but panic before writing any serial output.

/me has one of these beauties as well and will try to hack up support
for it.  If anyone has patches or suggestions, help is always
appreciated.

Jörn

-- 
Simplicity is prerequisite for reliability.
-- Edsger W. Dijkstra
