Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id E5C0F67A3A
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Apr 2006 02:04:05 +1000 (EST)
Date: Tue, 18 Apr 2006 11:03:30 -0500
To: Olof Johansson <olof@lixom.net>
Subject: Re: 7447A strange problem with MSR:POW (WAS: can't boot 2.6.17-rc1)
Message-ID: <20060418160330.GB26746@pb15.lixom.net>
References: <1144408805.30891.42.camel@localhost.localdomain>
	<17463.9759.442768.685153@cargo.ozlabs.ibm.com>
	<1144923633.4935.11.camel@localhost.localdomain>
	<21F7D7D8-B9BC-44EB-B07B-F888D89DCF25@freescale.com>
	<17471.62187.774127.783000@cargo.ozlabs.ibm.com>
	<1145048461.4223.38.camel@localhost.localdomain>
	<17476.31998.168122.413195@cargo.ozlabs.ibm.com>
	<1145340034.4705.55.camel@localhost.localdomain>
	<17476.34830.897083.360572@cargo.ozlabs.ibm.com>
	<20060418145600.GE20234@pb15.lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060418145600.GE20234@pb15.lixom.net>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
	debian-powerpc@lists.debian.org, Paul Mackerras <paulus@samba.org>,
	Becky Bruce <Becky.Bruce@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 18, 2006 at 09:56:00AM -0500, Olof Johansson wrote:
> On Tue, Apr 18, 2006 at 04:32:46PM +1000, Paul Mackerras wrote:
> 
> > > understand now why you were talking about putting the code in the exit
> > > path on irc ... I don't like it that way.... Also, if you want to keep
> > > it, maybe use a separate CONFIG_PPC_970STYLE_NAP or something that gets
> > > selected by platforms that can do it ?
> > 
> > The config option makes sense.
> 
> How about a CPU feature bit instead? That way it's possible to build a
> multiplatform kernel without getting the overhead on other platforms.
> 4 nops should be manageable?

DOH! I'm going blind, that's already there. So, Ben, you're unhappy
with nopping it out?


-Olof
