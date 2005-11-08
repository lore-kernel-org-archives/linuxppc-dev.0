Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7BFF7686C9
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Nov 2005 10:14:20 +1100 (EST)
In-Reply-To: <20051108224658.98933352B33@atlas.denx.de>
References: <20051108224658.98933352B33@atlas.denx.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <221fe35aeb5c9a16cd2a019300e16efc@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Tue, 8 Nov 2005 18:20:30 -0500
To: Wolfgang Denk <wd@denx.de>
Cc: Tom Rini <trini@kernel.crashing.org>,
	David Jander <david.jander@protonic.nl>, linuxppc-embedded@ozlabs.org
Subject: Re: fix swapping on 8xx? 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Nov 8, 2005, at 5:46 PM, Wolfgang Denk wrote:

> Hm... as far as I can remember ....

Yes, your patch looks correct.  I'll just map these changes
on top of the PTEs to verify there aren't some status
bits that we may still incorrectly update.  When I originally
selected the bit positions for the PTEs I didn't properly
consider the usage of the PTE during swap (nor did
I always have the options I wanted :-))

Among everything else I promised, I'll try to get all of these
updates quickly sorted out.

Thanks for all of these pointers to old patches, saves
me time looking them up :-)


	-- Dan
