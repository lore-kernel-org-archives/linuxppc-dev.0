Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 78D2667A64
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Mar 2005 18:36:40 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Colin Leroy <colin@colino.net>
In-Reply-To: <20050317075157.19aa4df0@jack.colino.net>
References: <16953.5968.397116.341920@cargo.ozlabs.ibm.com>
	<20050317075157.19aa4df0@jack.colino.net>
Content-Type: text/plain
Date: Thu, 17 Mar 2005 18:35:54 +1100
Message-Id: <1111044955.7192.210.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Linux-USB <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [PATCH] Make sleep/wakeup work with USB on powerbooks
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Would it be the "proper" patch I was looking for in the thread named
> "[PATCH] Re-power USB ports on wakeup" ?
> 
> Or does it fix different issues ? Mine fixed, with a hack I think, the
> fact that USB ports kept being powered down after one wakeup out of
> two. I never got any machine check, however.

Test please, your patch shouldn't be necessary.

Ben.
