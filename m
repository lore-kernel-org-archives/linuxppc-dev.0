Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4A247DDE03
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 07:55:25 +1000 (EST)
Message-ID: <4828BCC4.3030308@freescale.com>
Date: Mon, 12 May 2008 16:55:16 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: cbouatmailru@gmail.com
Subject: Re: [PATCH 1/3] [WATCHDOG] mpc83xx_wdt: add support for MPC86xx	CPUs
References: <20080512185206.GA25818@polina.dev.rtsoft.ru>
	<64629276-8337-4FFE-B3E1-306678BF179D@kernel.crashing.org>
	<20080512205303.GA14198@zarina> <4828AFBD.1040501@freescale.com>
	<4828B012.9090805@freescale.com> <20080512211856.GA21532@zarina>
	<4828B4BB.2020403@freescale.com> <20080512213529.GA27087@zarina>
	<4828B9D1.9040106@freescale.com> <20080512214858.GA30803@zarina>
In-Reply-To: <20080512214858.GA30803@zarina>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Wim Van Sebroeck <wim@iguana.be>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:

> I don't know the IP block name... what is it for the 83xx/86xx
> watchdogs?

My point was that we developers should just pick a name and run with it. 
  That's where the name "Elo" came from.  None of official Freescale 
documentation calls the DMA controller on 85xx parts "Elo", but the 
kernel code does.
