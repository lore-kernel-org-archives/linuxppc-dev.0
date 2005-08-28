Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 692DC680A4
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Aug 2005 10:48:29 +1000 (EST)
In-Reply-To: <20050827050422.GC7234@siegfried.thelikelysolution.ca>
References: <DCEAAC0833DD314AB0B58112AD99B93B859440@ismail.innsys.innovsys.com>
	<20050826225509.GF5541@smtp.west.cox.net>
	<da1e14409c0face6cee5b4d5fa750c00@embeddededge.com>
	<20050827050422.GC7234@siegfried.thelikelysolution.ca>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d18c6049f1976912db9a7022a85c158a@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Sat, 27 Aug 2005 20:48:04 -0400
To: Grant Likely <glikely@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Tom Rini <trini@kernel.crashing.org>,
	Kumar Gala <galak@freescale.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] ppc32: add CONFIG_HZ
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 27, 2005, at 1:04 AM, Grant Likely wrote:

> What's the reason for clock jitter?  Is it because most timeouts are 
> set
> to multiples of 100, or some other reason?

Yes, the application interfaces are all defined as 100 Hz (10 mSec).
If the POSIX timer implementation is done properly, it should be
possible to determine the timer parameters to eliminate this, but
I doubt any applications do this.  They all assume 10 mSec :-)


	-- Dan
