Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 5C976DDE32
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 05:11:36 +1000 (EST)
Message-ID: <466312C2.4090200@ru.mvista.com>
Date: Sun, 03 Jun 2007 23:13:06 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
References: <7fc919fce0761f861be3069a853d3169@bga.com>
	<bd6ef296692e8cfb81118f2dc85189a5@kernel.crashing.org>
	<4662EAA9.70104@ru.mvista.com>
	<e4197fd2753f2b4d548d5dde9e3fd1d3@kernel.crashing.org>
	<466308F4.8050004@ru.mvista.com>
	<8ac5664208e0f59329b62ac2138bbc8c@kernel.crashing.org>
In-Reply-To: <8ac5664208e0f59329b62ac2138bbc8c@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:

>>> You obviously completely misunderstand the semantics
>>> of the "compatible" property.

>>    Oh well, on the chip level, your "compatible" prop would be correct.

> This has nothing to do with a "chip level", it is plain and
> simply the most basic device tree stuff.

    If it was as "plain and simple" as you say, there would be nothing to 
argue about.  What we ended up with is 2 or 3 level hierarchy of nodes which 
doesn't at all seem to be such simple (considering the fact that what's 
covered by a the simple "bank-width" property could be represented by several 
combinations of interleaved flash chips). So, what you wanted us to do was 
either substantially redesign Linux MTD subsys to fit it into that model 
(either that or over-engineer the physmap_of driver to gather that kind of 
information from the multiple "chip" subnodes).  Guess how well would that 
have been accepted even if we had time to do that...

> Segher

WBR, Sergei
