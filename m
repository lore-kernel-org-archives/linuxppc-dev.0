Return-Path: <wfarnsworth@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 32A1FDDE49
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 01:59:45 +1000 (EST)
Subject: RE: [PATCH 5/5] PCI fixes for the MPC8641 Rev 2.0 silicon and
	Rev1.02 hardware
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: Jin Zhengxiong-R64188 <Jason.Jin@freescale.com>
In-Reply-To: <CC27DED0F8F39E48A7E75FD768688B7A2FD493@zch01exm27.fsl.freescale.net>
References: <CC27DED0F8F39E48A7E75FD768688B7A2FD493@zch01exm27.fsl.freescale.net>
Content-Type: text/plain
Date: Mon, 21 May 2007 08:59:42 -0700
Message-Id: <1179763182.8132.285.camel@rhino>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-05-18 at 14:52 +0800, Jin Zhengxiong-R64188 wrote:
> 
> As you changed the class of the bridge, dev->transparent will be set
> again in the later  code, if you remove the 0x01 here, the
> dev->transparent will be set to 0 later. So if you changed the class
> like this, you do not need to set  dev->transparent = 1 in your patch.
> 
> Jason 

It is my understanding that neither dev->transparent, nor that bit in
the PCI class should be set.

--Wade
