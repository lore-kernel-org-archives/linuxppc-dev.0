Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 456AF67A04
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Apr 2006 08:57:45 +1000 (EST)
Subject: Re: 7447A strange problem with MSR:POW (WAS: can't boot 2.6.17-rc1)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Becky Bruce <Becky.Bruce@freescale.com>
In-Reply-To: <BBE6C9EA-53B5-4EAA-A766-DAF241E7040D@freescale.com>
References: <Pine.LNX.4.44.0604071010290.18017-100000@zirkon.biophys.uni-duesseldorf.de>
	<1144408805.30891.42.camel@localhost.localdomain>
	<17463.9759.442768.685153@cargo.ozlabs.ibm.com>
	<1144923633.4935.11.camel@localhost.localdomain>
	<21F7D7D8-B9BC-44EB-B07B-F888D89DCF25@freescale.com>
	<17471.62187.774127.783000@cargo.ozlabs.ibm.com>
	<20060414195436.GC24769@pb15.lixom.net>
	<BBE6C9EA-53B5-4EAA-A766-DAF241E7040D@freescale.com>
Content-Type: text/plain
Date: Sat, 15 Apr 2006 08:57:31 +1000
Message-Id: <1145055451.4223.40.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
	debian-powerpc@lists.debian.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-04-14 at 15:00 -0500, Becky Bruce wrote:
> He's being sneaky - there's a copy of HID0 in the CR at this point  
> from the caller, and bit 9 is the position for NAP.

It's a trick I learned from Darwin :) They do that regulary when code is
very cpu-feature dependant, like cache code for example, they put the
cpu features bitmask in CR and do branches based on individual bits of
it here or there.

Ben.
