Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 84440DE272
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 22:49:42 +1000 (EST)
Subject: Re: More patches pushed to powerpc.git master and powerpc-next
	branches
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20080416224510.85e9dace.sfr@canb.auug.org.au>
References: <18437.61934.495516.351438@cargo.ozlabs.ibm.com>
	<20080416224510.85e9dace.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Wed, 16 Apr 2008 22:49:28 +1000
Message-Id: <1208350168.6958.281.camel@pasglop>
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


On Wed, 2008-04-16 at 22:45 +1000, Stephen Rothwell wrote:
> On Wed, 16 Apr 2008 22:32:46 +1000 Paul Mackerras <paulus@samba.org> wrote:
> >
> >       [POWERPC] ibm_newemac: PowerPC 440GX EMAC PHY clock workaround
> >       [POWERPC] ibm_newemac: PowerPC 440EP/440GR EMAC PHY clock workaround
> 
> So close :-)

The workaround for those is actually subtely different :-0

Ben.
