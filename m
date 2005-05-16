Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5701F67B17
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 May 2005 08:52:37 +1000 (EST)
In-Reply-To: <61cc712d050516153941bc3b26@mail.gmail.com>
References: <61cc712d05051614507b688c6e@mail.gmail.com>
	<20050516220330.6D4E3C1512@atlas.denx.de>
	<61cc712d050516153941bc3b26@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0d07fbd5d90d129227b4f579067f2d16@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Mon, 16 May 2005 18:52:41 -0400
To: Kylo Ginsberg <kylo.ginsberg@gmail.com>
Cc: PPC_LINUX <linuxppc-embedded@ozlabs.org>
Subject: Re: MPC885 - USB HCI drivers.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 16, 2005, at 6:39 PM, Kylo Ginsberg wrote:

> Are there known problems with CPM-based USB controllers?

The original CPM USB controller was only supposed to be
a device side controller.  With some software hacks, CPM
microcode downloads, and even some hardware modifications,
you can often get it to work as a host in some static situations.
It doesn't have a built in root hub, you usually concentrate
on making it work with one specific device for a particular
product.  You may find some application notes on the
Freescale web site, but I haven't seem them lately.

Take Wolfgang's advice, it's easier to find a way to
attach a real USB controller than to make this one
work as you probably expect.

Thanks.

	-- Dan
