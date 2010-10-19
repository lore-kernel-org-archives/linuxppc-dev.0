Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 52919B70DE
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 20 Oct 2010 07:59:19 +1100 (EST)
Subject: Re: PROBLEM: memory corrupting bug, bisected to 6dda9d55
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: pacman@kosh.dhis.org
In-Reply-To: <20101019181021.22456.qmail@kosh.dhis.org>
References: <20101019181021.22456.qmail@kosh.dhis.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 20 Oct 2010 07:58:43 +1100
Message-ID: <1287521923.2198.2.camel@pasglop>
Mime-Version: 1.0
Cc: Mel Gorman <mel@csn.ul.ie>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-10-19 at 13:10 -0500, pacman@kosh.dhis.org wrote:
> 
> So what type of driver, firmware, or hardware bug puts a 16-bit 1000Hz
> timer
> in memory, and does it in little-endian instead of the CPU's native
> byte
> order? And why does it stop doing it some time during the early init
> scripts,
> shortly after the root filesystem fsck?
> 
> I have not yet attempted to repeat the experiment. If it is
> repeatable, I'll
> probe more deeply into those init scripts later. I'm looking hard at
> /etc/rcS.d/S11hwclock.sh 

Stinks of USB...

Ben.
