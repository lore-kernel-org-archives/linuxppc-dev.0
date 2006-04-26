Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A3692679E7
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 09:28:11 +1000 (EST)
In-Reply-To: <20060425213622.B116F352B18@atlas.denx.de>
References: <20060425213622.B116F352B18@atlas.denx.de>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <C67DD005-0706-4CAB-884E-74626CD69817@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: 85xx FDT updates? 
Date: Wed, 26 Apr 2006 19:27:25 -0400
To: Wolfgang Denk <wd@denx.de>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 25, 2006, at 5:36 PM, Wolfgang Denk wrote:

> Others (and not a small number)  use  them  for  testing  application
> code. In your definition these are probably "end users", too.

I'm surprised by how much of this I see as well.  People will
buy various evaluation boards for the purposes of evaluation
(imagine that :-)).  They will try different kernel versions, write
some test applications, before making a choice of what
processor and tools to purchase.  Only after that point will
they likely have some debugger capability that will allow
them to update flash parts.  Based on this behavior, it's not
good to assume that just because someone has an eval
board they have the ability to update the flash on it.  A failed
flash update and the inability to recover is a good way to
ensure the board/processor is not chosen for a product :-)

Thanks.

	-- Dan
