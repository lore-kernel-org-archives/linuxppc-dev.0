Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5BE22DDF4C
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 04:36:48 +1100 (EST)
Message-ID: <49760B56.3000901@freescale.com>
Date: Tue, 20 Jan 2009 11:35:18 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jean-Michel Hautbois <jhautbois@gmail.com>
Subject: Re: [MPC8272ADS]Cannot start my Linux Kernel
References: <496F318D.6010302@denx.de>	
	<8cad0aa0901160406l3db9c025ubdcac40b4b464d23@mail.gmail.com>	
	<20090116172903.GA722@ld0162-tx32.am.freescale.net>	
	<8cad0aa0901160944l48bd0e99wa13f23907838376d@mail.gmail.com>	
	<8cad0aa0901160953te6c7d1cg3a4df7de7da7d182@mail.gmail.com>	
	<4970CBA9.60809@freescale.com>	
	<8cad0aa0901200256n6122d17eh90f56e9cb8cae775@mail.gmail.com>	
	<20090120163155.GA8978@ld0162-tx32.am.freescale.net>	
	<8cad0aa0901200905y642f1a39qc8c52a076edbd123@mail.gmail.com>	
	<497606D1.9090903@freescale.com>
	<8cad0aa0901200932g5e6581abk7b0a142046c8341d@mail.gmail.com>
In-Reply-To: <8cad0aa0901200932g5e6581abk7b0a142046c8341d@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jean-Michel Hautbois wrote:
> OK... And is there anywhere a description of how I can do that :s.

Hmm, if the old u-boot on my board is any indication, it doesn't use a 
single descriptor, so it's not compatible with the early debug.  Just 
turn it off, and with the brg setting removed you should see output when 
the real serial driver starts.

You should find out what's preventing the brg setting from working, though.

-Scott
