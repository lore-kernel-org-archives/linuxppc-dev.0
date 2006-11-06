Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id EAD0667D39
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Nov 2006 22:24:50 +1100 (EST)
Received: from mail01.m-online.net (svr21.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id B7CA398201
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Nov 2006 12:24:49 +0100 (CET)
Received: from [10.0.30.2] (p5497E080.dip.t-dialin.net [84.151.224.128])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id 87C1991632
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Nov 2006 12:24:49 +0100 (CET)
Message-ID: <454F1B9D.5090705@grandegger.com>
Date: Mon, 06 Nov 2006 12:25:17 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: Has anyone 2.6 kernel with Xenomai and MPC5200 Lite running?
References: <20061104163119.GC69112@server.idefix.loc>	<528646bc0611041832j327c8391i9d3401782529073d@mail.gmail.com>	<20061105102328.GH79990@server.idefix.loc>	<454DBE2C.6040506@246tNt.com>	<20061105202435.GB30026@server.idefix.loc>	<454E4E7D.7090507@grandegger.com>
	<20061105212429.GA35760@server.idefix.loc>
In-Reply-To: <20061105212429.GA35760@server.idefix.loc>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Matthias,

Matthias Fechner wrote:
> Hello Wolfgang,
> 
> * Wolfgang Grandegger <wg@grandegger.com> [05-11-06 21:50]:
>> I also tried to get Sylvain's patches working on 2.6.18 and gave up 
>> rather frustrated. They do not work "as is" :-(. I can offer you a 
>> solution for Xenomai on 2.6.17, if this is an option for you. That's 
>> what I got working for development.
> 
> that would be fantastic.
> I only need kernel 2.6 running on MPC5200 with xenomai.
> I can give you access to one of my servers if you want to copy there
> the kernel.

Some time ago I got the MPC5200 patches from the Pengutronix's OSELAS 
project working for DENX Linux 2.6.17. In the meantime they have update 
to 2.6.18. Take OSELAS.BSP-Phytec-phyCORE-MPC5200B-tiny-4.tar.gz from
http://www.pengutronix.de/oselas/bsp/phytec/download/phyCORE-MPC5200B-tiny/, 
unpack it and apply the relevant patches from the kernel-patches-target 
directory to linux-2.6-denx#v2.6.18. I think the following patches 
should be sufficient (in that order):

   fec_mpc52xx_bestcomm.diff
   fec_mpc52xx.diff
   drivers_serial_mpc52xx_uart_fix.diff
   mpc5200_physmap.diff

You can find the most recent Xenomai patch 2.6.18-ppc-1.05.00 at 
ftp://ftp.denx.de/xenomai. I'm going to test them later today with Xenomai.

Good luck.

Wolfgang.
