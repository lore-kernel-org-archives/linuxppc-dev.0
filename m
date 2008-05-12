Return-Path: <cbouatmailru@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.154])
	by ozlabs.org (Postfix) with ESMTP id 32CA4DDE98
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 07:49:06 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so1901049fga.39
	for <linuxppc-dev@ozlabs.org>; Mon, 12 May 2008 14:49:05 -0700 (PDT)
Date: Tue, 13 May 2008 01:48:58 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/3] [WATCHDOG] mpc83xx_wdt: add support for MPC86xx CPUs
Message-ID: <20080512214858.GA30803@zarina>
References: <20080512185206.GA25818@polina.dev.rtsoft.ru>
	<64629276-8337-4FFE-B3E1-306678BF179D@kernel.crashing.org>
	<20080512205303.GA14198@zarina> <4828AFBD.1040501@freescale.com>
	<4828B012.9090805@freescale.com> <20080512211856.GA21532@zarina>
	<4828B4BB.2020403@freescale.com> <20080512213529.GA27087@zarina>
	<4828B9D1.9040106@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <4828B9D1.9040106@freescale.com>
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

On Mon, May 12, 2008 at 04:42:41PM -0500, Timur Tabi wrote:
> Anton Vorontsov wrote:
>
>> They're completely different watchdogs...
>
> But the drivers both generally do the same thing, just with different  
> timers?

All the watchdogs do the same thing, generally...

> I think the best option is to just pick a name for the IP block that  
> mpc83xx_wdt.c supports and use that name for the driver as well.

I don't know the IP block name... what is it for the 83xx/86xx
watchdogs?

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
