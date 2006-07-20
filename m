Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx007.isp.belgacom.be (outmx007.isp.belgacom.be
	[195.238.5.234])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 020B867BD2
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Jul 2006 00:28:39 +1000 (EST)
Received: from outmx007.isp.belgacom.be (localhost [127.0.0.1])
	by outmx007.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k6KESWQS032442
	for <linuxppc-embedded@ozlabs.org>; Thu, 20 Jul 2006 16:28:32 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: Wolfgang Denk <wd@denx.de>
Subject: Re: MPC8260 SCC UART hardware flow control
Date: Thu, 20 Jul 2006 16:30:47 +0200
References: <20060719183740.22636352681@atlas.denx.de>
In-Reply-To: <20060719183740.22636352681@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200607201630.47701.laurent.pinchart@tbox.biz>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wednesday 19 July 2006 20:37, Wolfgang Denk wrote:
> In message <200607191718.00328.laurent.pinchart@tbox.biz> you wrote:
> > I was wondering if anyone had implemented hardware flow control support
> > in the cpm_uart driver. If not, I would appreciate pointers regarding how
> > to do so.
>
> You can probably take our 2.4 kernel code as a starting point. But be
> aware of the inherent restrictions of the CPM, see
> http://www.denx.de/wiki/view/DULG/UseSCCUARTWithHardwareHandshake

I didn't know the CPM implemented hardware flow control as a DTE only. Thanks 
for the information. As our hardware connects to DCE devices this shouldn't 
be a problem.

> [In the end, you might want to configure  the  handshake  signals  as
> GPIO lines and controll these manually. But then you will have to ask
> yourself why you are using a CPM...]

Laurent Pinchart
