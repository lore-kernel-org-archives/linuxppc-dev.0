Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0FF7667B35
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Apr 2005 09:21:48 +1000 (EST)
Date: Wed, 6 Apr 2005 16:21:45 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Wolfgang Denk <wd@denx.de>
Message-ID: <20050406232145.GA28977@gate.ebshome.net>
References: <20050406223751.E4297C108D@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050406223751.E4297C108D@atlas.denx.de>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Kernel SCM saga..
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 07, 2005 at 12:37:46AM +0200, Wolfgang Denk wrote:
> are there any plans yet how to continue PPC  kernel  development  now
> that Linus (and probably others, too) stopped using BitKeeper?

Well, most of the recent 2.6 PPC kernel development was based on 
sending _patches_ to akpm, I don't see how Linus' decision to stop 
using BK will significantly affect this.

Also, BK trees don't go anywhere right now, so I guess we can still 
use BK to get/maintain the latest official sources for patch 
generation. I'm pretty sure Linus and other maintainers will come up 
with replacement. Probably it won't be as convenient as BK at first, 
but I hope this will be fixed eventually - there are couple of open 
source revision control systems out there which look promising.

So, I wouldn't overly dramatize current situation.

--
Eugene
