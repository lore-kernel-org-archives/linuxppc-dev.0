Return-Path: <clifford@clifford.at>
Received: from phoenix.clifford.at (phoenix.clifford.at [88.198.7.52])
	by ozlabs.org (Postfix) with ESMTP id DE5E5DDE45
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Jun 2007 03:45:13 +1000 (EST)
Date: Mon, 25 Jun 2007 19:48:36 +0200
From: Clifford Wolf <clifford@clifford.at>
To: Olof Johansson <olof@lixom.net>
Subject: Re: Mem-2-Mem DMA - Generalized API
Message-ID: <20070625174836.GG20463@clifford.at>
References: <20070624193932.GA11797@clifford.at>
	<200706242221.57507.arnd@arndb.de>
	<467FA0EA.3000607@genesi-usa.com> <467FBABD.9040103@anagramm.de>
	<467FD1DF.4000602@genesi-usa.com> <20070625170003.GA6484@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070625170003.GA6484@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

On Mon, Jun 25, 2007 at 12:00:03PM -0500, Olof Johansson wrote:
> That's the case with the dma engine framework today. Expand it, extend
> it, fix it and improve it. Don't duplicate, re-invent and re-implement.

I'm not sure if I can agree with that.

The core idea befind the dma engine framework seams to be to statically
assign dma channels to device drivers. I think that the channels should
be dynamically assigned.

Imo writing an alternative implementation is much easier than hacking that
into the existing framework. Especially since the existing framework has
only one backend driver and only one user.

yours,
 - clifford

-- 
/* You are not expected to understand this */
