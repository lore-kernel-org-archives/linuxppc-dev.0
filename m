Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3B380679EF
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 May 2005 04:24:56 +1000 (EST)
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B85938C@ismail.innsys.innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B85938C@ismail.innsys.innovsys.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <83b68c8352ef007b191e2a2a3898f9e6@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Tue, 10 May 2005 14:24:52 -0400
To: "Rune Torgersen" <runet@innovsys.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH  03/04] Freescale Ethernet combined driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 10, 2005, at 10:53 AM, Rune Torgersen wrote:

> For 8xx/82xx (and other PQ cpus) there is a lot of drivers liberally
> using
> __pa and __va to get physical and virtual adresses for structures and
> buffer descriptor tables for the CPM.

I changed nearly all of these in 2.4 when the DMA assist functions
came into being.  Unfortunately, many of the patches submitted to
these drivers over time were from out of date sources that seemed
to revert back to old behavior instead of making the updates adapt
the new.  From looking at the CPM support functions in 2.6 recently,
I can't believe it even works.  In some cases there are conflicting
implementations sharing information that is just by luck works.

> What would the preferred way of handling both of these be?

Read DMA-API.txt


Thanks.


	-- Dan
