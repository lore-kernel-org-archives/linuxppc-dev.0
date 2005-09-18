Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <216D7B09-CC72-482D-9C06-3416D5E02DBE@freescale.com>
References: <1127006735.23095.4.camel@gaston>
	<216D7B09-CC72-482D-9C06-3416D5E02DBE@freescale.com>
Content-Type: text/plain
Date: Mon, 19 Sep 2005 08:13:16 +1000
Message-Id: <1127081596.4502.8.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Re: PATCH powerpc: 00/04 Remove __pmac, etc, sections, merge
	sections.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I think the discussion earlier in this week lead us to believe this  
> was the way to go.  We can provide a simple patch to allow selecting  
> CHRP/PMAC/PREP specifically in addition to MUTLIPLATFORM.

It should be done like ppc64, that is MULTIPLATFORM can be built with an
aribtrary "set" of platforms. In fact, I think the merged arch should
trash if possible all "exclusive" CONFIG_MYBOARD stuff, but only ever do
what ppc64 does, that is any combination of platforms for the same CPU
family can be built at the same time.

Ben.
