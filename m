Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 94E02DDE21
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 15:08:30 +1000 (EST)
In-Reply-To: <12648696.post@talk.nabble.com>
References: <12648489.post@talk.nabble.com>
	<46B96294322F7D458F9648B60E15112C85D7FB@zch01exm26.fsl.freescale.net>
	<12648696.post@talk.nabble.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5850B6F4-61FD-4866-B50E-8F7FEA3FA9AD@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 2.6.23-rc3 boot hang on MPC8641D
Date: Thu, 13 Sep 2007 00:11:23 -0500
To: sivaji <rameshmrm@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 12, 2007, at 11:52 PM, sivaji wrote:

>
>
> Hi,
>           I tired to move the dtb to 0x2000000, but the result was  
> same.
> uboot version is 1.1.6

seems like a pretty old u-boot.  Willing to try a 1.3.0-rc1?

- k
