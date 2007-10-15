Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 25697DE009
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 05:06:12 +1000 (EST)
Message-ID: <4713BA1C.2050604@pobox.com>
Date: Mon, 15 Oct 2007 15:06:04 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Domen Puncer <domen.puncer@telargo.com>
Subject: Re: [PATCH v3 0/4] FEC - fast ethernet controller for mpc52xx
References: <20071014075511.GC3000@nd47.coderock.org>
In-Reply-To: <20071014075511.GC3000@nd47.coderock.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Domen Puncer wrote:
> Hello!
> 
> If there are no objections, I would like to get this merged
> when bestcomm goes in (any time now?).
> 
> It's split into four parts:
> 1 - device tree
> 2 - small bestcomm change
> 3 - the actual driver
> 4 - phy part of the driver

patches #3 and #4 need to be combined together.

Are the arch people OK with patches #1 and #2?

	Jeff
