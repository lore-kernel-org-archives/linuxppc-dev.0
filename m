Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6A6C1682C5
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Sep 2005 03:35:01 +1000 (EST)
In-Reply-To: <Pine.LNX.4.61.0509161138130.20199@nylon.am.freescale.net>
References: <Pine.LNX.4.61.0509161138130.20199@nylon.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <580ff9f6f516e94ae546c695bad0071c@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Fri, 16 Sep 2005 13:34:21 -0400
To: Kumar Gala <galak@freescale.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: bseip config doesn't build
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Sep 16, 2005, at 12:41 PM, Kumar Gala wrote:

> Anyone have any ideas why the bseip_defconfig doesnt build.  I get the
> following error:

I'll look into it.

>   CC      arch/ppc/8xx_io/enet.o

I thought we are should be using the drivers/net/* version of this?

Thanks.

	-- Dan
