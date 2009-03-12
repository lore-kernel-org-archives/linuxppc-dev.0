Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.182])
	by ozlabs.org (Postfix) with ESMTP id 3648DDE0E0
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 19:05:19 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] PowerPC 440EPx/GRx fix memory size calculation
Date: Thu, 12 Mar 2009 09:05:11 +0100
References: <49B58779.9040905@lebon.org.ua> <200903120702.03286.sr@denx.de>
	<1236843157.7086.83.camel@pasglop>
In-Reply-To: <1236843157.7086.83.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200903120905.11542.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, lebon@lebon.org.ua
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 12 March 2009, Benjamin Herrenschmidt wrote:
> On Thu, 2009-03-12 at 07:02 +0100, Stefan Roese wrote:
> > I'll apply the U-Boot patch today. But as Josh pointed out, we should
> > try to
> > find a way for the bootwrapper to work in all cases.
>
> uboot is passing some kind of bt_t to the wrapper or a full
> device-tree ?

Both is possible. Older U-Boot versions only passed the bd_t struct to the 
kernel. For those U-Boot's the wrapper is needed. More recent U-Boot versions 
support passing a device-tree blob to the kernel. U-Boot patches the correct 
memory size in this blob.

As a matter of fact, I never used the wrapper before. U-Boot supports passing 
the device-tree blob to Linux since quite some time now.

Best regards,
Stefan
