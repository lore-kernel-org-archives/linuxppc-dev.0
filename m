Return-Path: <cbouatmailru@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.156])
	by ozlabs.org (Postfix) with ESMTP id 8AA84DDDEF
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 07:35:38 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so1897861fga.39
	for <linuxppc-dev@ozlabs.org>; Mon, 12 May 2008 14:35:36 -0700 (PDT)
Date: Tue, 13 May 2008 01:35:29 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/3] [WATCHDOG] mpc83xx_wdt: add support for MPC86xx CPUs
Message-ID: <20080512213529.GA27087@zarina>
References: <20080512185206.GA25818@polina.dev.rtsoft.ru>
	<64629276-8337-4FFE-B3E1-306678BF179D@kernel.crashing.org>
	<20080512205303.GA14198@zarina> <4828AFBD.1040501@freescale.com>
	<4828B012.9090805@freescale.com> <20080512211856.GA21532@zarina>
	<4828B4BB.2020403@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <4828B4BB.2020403@freescale.com>
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

On Mon, May 12, 2008 at 04:20:59PM -0500, Timur Tabi wrote:
> Anton Vorontsov wrote:
>> On Mon, May 12, 2008 at 04:01:06PM -0500, Timur Tabi wrote:
>>> Scott Wood wrote:
>>>
>>>> It avoids confusion.  I vote for renaming.
>>> Me too.  How about fsl_wdt.c?
>>
>> fsl_wdt sounds too generic, I think it would conflict with
>> at least booke_wdt.c.. no?
>
> Yeah, that makes sense.  What's the difference between booke_wdt.c and  
> mpc83xx_wdt.c?

They're completely different watchdogs...

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
