Return-Path: <cbouatmailru@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.158])
	by ozlabs.org (Postfix) with ESMTP id 9E315DDEF9
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 08:13:16 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so1905957fga.39
	for <linuxppc-dev@ozlabs.org>; Mon, 12 May 2008 15:13:14 -0700 (PDT)
Date: Tue, 13 May 2008 02:12:43 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/3] [WATCHDOG] mpc83xx_wdt: add support for MPC86xx CPUs
Message-ID: <20080512221243.GA1536@zarina>
References: <64629276-8337-4FFE-B3E1-306678BF179D@kernel.crashing.org>
	<20080512205303.GA14198@zarina> <4828AFBD.1040501@freescale.com>
	<4828B012.9090805@freescale.com> <20080512211856.GA21532@zarina>
	<4828B4BB.2020403@freescale.com> <20080512213529.GA27087@zarina>
	<4828B9D1.9040106@freescale.com> <20080512214858.GA30803@zarina>
	<4828BCC4.3030308@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <4828BCC4.3030308@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Wim Van Sebroeck <wim@iguana.be>
Reply-To: cbouatmailru@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 12, 2008 at 04:55:16PM -0500, Timur Tabi wrote:
> Anton Vorontsov wrote:
>
>> I don't know the IP block name... what is it for the 83xx/86xx
>> watchdogs?
>
> My point was that we developers should just pick a name and run with it.  
>  That's where the name "Elo" came from.  None of official Freescale  
> documentation calls the DMA controller on 85xx parts "Elo", but the  
> kernel code does.

Ahh, I see. Ok, my purpose: name the driver for mpc83xx-like watchdogs
as mpc83xx_wdt.c? :-)

It's less confusion. For example DMA. I really don't know what the
"Elo" is. Nobody does actually, except the few people who discussed
Linux Freescale DMA drivers...

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
