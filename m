Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 80C81DDD0D
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 09:23:42 +1100 (EST)
Message-ID: <47435E67.9080706@freescale.com>
Date: Tue, 20 Nov 2007 16:23:35 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jon Loeliger <jdl@jdl.com>, linuxppc-dev@ozlabs.org
Subject: Re: dtc: Add testcases for tree checks
References: <20071120052423.GC4356@localhost.localdomain>	<E1IuUiz-00022Y-E1@jdl.com>
	<20071120220309.GB13156@localhost.localdomain>
In-Reply-To: <20071120220309.GB13156@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Tue, Nov 20, 2007 at 09:09:17AM -0600, Jon Loeliger wrote:
>> Actually, this is the official third time now that it would have
>> been significantly nicer had you been using git for patches as
>> it does correctly handle excute permissions properly in patches.
> 
> Well, yes.  But, IMO, every time anyone other that you or I has
> commented on one of these patches as it goes past counts as an
> occasion when it's better that I've been using patches, rather than
> pushing to you direct with git.

Generating patches with "git-format-patch -M" isn't the same as pushing 
directly...

-Scot
