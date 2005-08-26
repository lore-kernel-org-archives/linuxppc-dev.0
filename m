Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao07.cox.net (fed1rmmtao07.cox.net [68.230.241.32])
	by ozlabs.org (Postfix) with ESMTP id 713C868077
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Aug 2005 08:55:10 +1000 (EST)
Date: Fri, 26 Aug 2005 15:55:09 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Rune Torgersen <runet@innovsys.com>
Message-ID: <20050826225509.GF5541@smtp.west.cox.net>
References: <DCEAAC0833DD314AB0B58112AD99B93B859440@ismail.innsys.innovsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B859440@ismail.innsys.innovsys.com>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Kumar Gala <galak@freescale.com>
Subject: Re: [PATCH] ppc32: add CONFIG_HZ
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 26, 2005 at 05:48:53PM -0500, Rune Torgersen wrote:
> On Friday, August 26, 2005 16:32 Tom Rini wrote:
> > So 250 is supposed to be the best choice of power vs latency and such.
> > But hey, there's nothing stopping us from setting all of the embedded
> > configs back down to 100 :)
> 
> I thought the default value for HZ in 2.6 was 1000?

Yes, it was.  With 2.6.13 and on i386 (and other arches that actually
make use of the question) it can be any of 100, 250 or 1000.

-- 
Tom Rini
http://gate.crashing.org/~trini/
