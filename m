Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id BC823DDF44
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 23:46:22 +1000 (EST)
Date: Tue, 13 May 2008 17:46:19 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 3/3] [POWERPC] 86xx: mpc8610_hpcd: add watchdog node
Message-ID: <20080513134618.GA7184@polina.dev.rtsoft.ru>
References: <20080512185217.GC25818@polina.dev.rtsoft.ru>
	<6d173c6a97eab1d96ea91b158b8e1f69@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <6d173c6a97eab1d96ea91b158b8e1f69@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Wim Van Sebroeck <wim@iguana.be>,
	Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 13, 2008 at 12:23:40AM +0200, Segher Boessenkool wrote:
>> +			compatible = "mpc83xx_wdt", "fsl,mpc8610-wdt";
>
> You should put the most specific entry first.

Yeah, I've overlooked this. Thanks.

Actually, I should remove mpc83xx_wdt, since mpc8610-wdt isn't
compatible...

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
