Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EF2C8679E6
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 May 2005 01:19:20 +1000 (EST)
In-Reply-To: <429177E8.5070701@intracom.gr>
References: <20050520141244.GD24923@logos.cnet>
	<e503cf4ab6d2d389b29474561048f2f2@embeddededge.com>
	<20050520175152.GB26221@logos.cnet>
	<5d184282e7d324fb009b8dcf6e6f967d@embeddededge.com>
	<20050521222713.GA28813@logos.cnet> <429177E8.5070701@intracom.gr>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c0a2512e4b2f07a4d1cef926026db281@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Mon, 23 May 2005 11:19:26 -0400
To: Pantelis Antoniou <panto@intracom.gr>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [RFT] 8xx cpm_hostalloc patch was: allow coherent DMA API to
	work before main page allocator is set up
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 23, 2005, at 2:27 AM, Pantelis Antoniou wrote:

> You shouldn't have these discussions on the weekend :)

Sorry.  I try not to, but then people think I'm not interested :-)
I was working on my race car data acquisition telemetry
project, anyway.

> I'm the culprit of the code in question.

I'm not trying to blame anyone.  The new driver is better in
many ways, we just have to fix up this one little thing so
it works in all possible VM configurations.

I also have to look at the new consistent mapping functions,
as those also seem to have changed.  Maybe this will
work fine, or can be made to work with minor changes.

Thanks.


	-- Dan
