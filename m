Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B90456827B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Sep 2005 05:03:36 +1000 (EST)
In-Reply-To: <20050915092555.A27452@cox.net>
References: <ea43f4f9050825183121655ba2@mail.gmail.com>
	<431260BA.7000107@jonmasters.org>
	<20050830083859.B5925@cox.net> <200509151803.15301.sr@denx.de>
	<20050915092555.A27452@cox.net>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <732f7227a8bcc2f3115e52633a60f120@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 15 Sep 2005 15:03:23 -0400
To: Matt Porter <mporter@kernel.crashing.org>
Cc: Stefan Roese <sr@denx.de>, linuxppc-embedded@ozlabs.org
Subject: Re: PPC4xx cleanup
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Sep 15, 2005, at 12:25 PM, Matt Porter wrote:

> Sounds great to me. This will have to wait to go in mainline until
> after 2.6.14 is out though.

If you are considering this, I think you should be looking at the
recent U-Boot discussion and patches for the "flat OF tree" and
follow that path.

Thanks.

	-- Dan
