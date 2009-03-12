Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 01706DE259
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 18:32:51 +1100 (EST)
Subject: Re: [PATCH] PowerPC 440EPx/GRx fix memory size calculation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <200903120702.03286.sr@denx.de>
References: <49B58779.9040905@lebon.org.ua>
	<20090311103716.GE26415@zod.rchland.ibm.com>
	<49B80BA3.1090301@ru.mvista.com>  <200903120702.03286.sr@denx.de>
Content-Type: text/plain
Date: Thu, 12 Mar 2009 18:32:37 +1100
Message-Id: <1236843157.7086.83.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, lebon@lebon.org.ua
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-03-12 at 07:02 +0100, Stefan Roese wrote:
> 
> I'll apply the U-Boot patch today. But as Josh pointed out, we should
> try to 
> find a way for the bootwrapper to work in all cases.

uboot is passing some kind of bt_t to the wrapper or a full
device-tree ?

Ben.
