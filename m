Return-Path: <laurent.pinchart@tbox.biz>
Received: from outfbmx010.isp.belgacom.be (outfbmx010.isp.belgacom.be
	[195.238.4.199]) by ozlabs.org (Postfix) with ESMTP id 3C6E467BC1
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Sep 2006 21:22:05 +1000 (EST)
Received: from outmx021.isp.belgacom.be (outmx021.isp.belgacom.be
	[195.238.4.202])
	by outfbmx010.isp.belgacom.be (Postfix) with ESMTP id 6EAA239951
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Sep 2006 13:22:02 +0200 (CEST)
Received: from outmx021.isp.belgacom.be (localhost [127.0.0.1])
	by outmx021.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k87BLgYG006580
	for <linuxppc-embedded@ozlabs.org>; Thu, 7 Sep 2006 13:21:46 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: linuxppc-embedded@ozlabs.org
Subject: Re: MPC8360E USB Host Controller Driver
Date: Thu, 7 Sep 2006 13:24:30 +0200
References: <4879B0C6C249214CBE7AB04453F84E4D14C78C@zch01exm20.fsl.freescale.net>
In-Reply-To: <4879B0C6C249214CBE7AB04453F84E4D14C78C@zch01exm20.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200609071324.30930.laurent.pinchart@tbox.biz>
Cc: n.balaji@gdatech.co.in
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> >    I am working in MPC8360E processor board. I want the
> > PowerQUICC II's Pro  USB Host controller Driver. In the
> > manual, they told that this controller does not belong to
> > UHCI or OHCI standard.
>
> Yes, you can call it FHCI if you like. :)
>
> >   I have doubt that whether Freescale has its own USB standard.
>
> The interface is stated clearly in the UM.
>
> >   Please give the link or patch for that driver.
>
> There is an 8360 host driver in Freescale LTIB BSP.  Please find it on
> www.freescale.com, if it has been released.

Could you give a direct link ? I've been browsing around the Freescale website 
for an hour, downloaded hundreds of megabytes of archives but haven't been 
able to find the MPC8360E USB Linux driver.

Laurent Pinchart

PS: Am I the only one to get lost almost every time when I look for 
information on www.freescale.com ?
