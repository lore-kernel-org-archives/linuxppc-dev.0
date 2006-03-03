Return-Path: <adrian@humboldt.co.uk>
Received: from mail.humboldt.co.uk (mail.humboldt.co.uk [80.68.93.146])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A03C9679F7
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Mar 2006 20:57:41 +1100 (EST)
Subject: Re: Linux on PPC
From: Adrian Cox <adrian@humboldt.co.uk>
To: David Hawkins <dwh@ovro.caltech.edu>
In-Reply-To: <4407CFD3.4060206@ovro.caltech.edu>
References: <190edfbd0603021801g5505cab9h8e285fdc7bf476d1@mail.gmail.com>
	<4407CFD3.4060206@ovro.caltech.edu>
Content-Type: text/plain
Date: Fri, 03 Mar 2006 09:33:24 +0000
Message-Id: <1141378405.8912.31.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 2006-03-02 at 21:10 -0800, David Hawkins wrote:
> Step 2. Find a PPC 750 port in the Linux source.
> 
>       For example, in the 2.6 series kernel, the place to start
>       looking is under arch/ppc/platforms. grep -Ie 750 shows
>       up some of the PPC 750 based systems.
> 
>       chestnut.c 750FX/GX evaluation board
>       katana.c   Looks like one too
>       prpmc750.c Looks like a Motorola board
> 
>       Look at the comments in the code, look at the memory map
>       of the reference board versus your custom board. There is
>       a very good chance that the custom board is based on a
>       reference design - thats the whole point of them.

I'd add the caution that within the 6xx, 7xx, and 7xxx family of
processors, the north-bridge makes a much greater difference than the
processor core. Within that family of processors Linux will auto-detect
the processor specific features at boot time. It will be easier to port
from a board using a 7450 with the same north-bridge, than from a board
using a 750 with a different north-bridge.

-- 
Adrian Cox <adrian@humboldt.co.uk>
