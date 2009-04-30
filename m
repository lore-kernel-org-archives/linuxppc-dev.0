Return-Path: <BATV+230d6b87e17ebd47825b+2076+infradead.org+dwmw2@casper.srs.infradead.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D0DEBDDE0D
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 15:32:14 +1000 (EST)
Subject: Re: [MTD] ofpart: Partitions at same address cannot have the same name
From: David Woodhouse <dwmw2@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1241061577.29501.1.camel@pasglop>
References: <1240387541-16594-1-git-send-email-ricardo.ribalda@uam.es>
	<1241061577.29501.1.camel@pasglop>
Content-Type: text/plain
Date: Thu, 30 Apr 2009 06:32:06 +0100
Message-Id: <1241069526.2567.478.camel@macbook.infradead.org>
Mime-Version: 1.0
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@uam.es>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-04-30 at 04:19 +0100, Benjamin Herrenschmidt wrote:
> 
> I fail to see the point of this "special" partition in the first
> place...
> 
> Things would make more sense if you had a full flash device
> whose child nodes are the partitions.

That's the model I think I want to move to, and which I was toying with
in http://git.infradead.org/users/dwmw2/mtd-sysfs.git (I haven't done it
yet, but it's logically the next step after what I've already done).

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation
