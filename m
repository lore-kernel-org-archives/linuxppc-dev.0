Return-Path: <dan@embeddedalley.com>
Received: from smtp105.biz.mail.re2.yahoo.com (smtp105.biz.mail.re2.yahoo.com
	[206.190.52.174]) by ozlabs.org (Postfix) with SMTP id 62FB567C17
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 01:44:59 +1100 (EST)
In-Reply-To: <20061120102424.GB12002@lst.de>
References: <20061114012504.17455.13833.stgit@localhost.localdomain>
	<20061114012816.17455.12059.stgit@localhost.localdomain>
	<20061117080052.GA16985@lst.de>
	<DB42A6F7-2B5E-4A22-8AA8-0F2C3BDEFC99@embeddedalley.com>
	<20061120102424.GB12002@lst.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <68068EEF-D816-4E54-8C60-C93CA90E6D7D@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH 2/5] [POWERPC] 8xx: generic 8xx code arch/powerpc port
Date: Mon, 20 Nov 2006 19:26:49 -0500
To: Christoph Hellwig <hch@lst.de>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 20, 2006, at 5:24 AM, Christoph Hellwig wrote:

> Sorry, I actually meant drivers/net/fec.c.

That's the wrong one, too :-)

Since I was able to go on an adventure among
the Ethernet drivers today, I noticed all of the
PQs use the drivers/net/fs_enet directory.
The MPC8xx will use some combination
of the SCC or FEC MAC driver functions
in that directory.  They all use the cache
coherent DMA allocators properly.

Thanks.

	-- Dan
