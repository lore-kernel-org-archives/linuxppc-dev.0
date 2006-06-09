Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 2B62F67A60
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Jun 2006 17:40:18 +1000 (EST)
To: "Denny" <jxnuxdy@163.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Help -- failed to boot up kernel on PPC40 5 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 09 Jun 2006 10:11:29 +0800."
	<4488D8D1.00003F.15159@bj163app14.163.com>
Date: Fri, 09 Jun 2006 09:40:15 +0200
Sender: wd@denx.de
Message-Id: <20060609074015.DBB7535363E@atlas.denx.de>
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

In message <4488D8D1.00003F.15159@bj163app14.163.com> you wrote:
> 
>       I use the linux 2.6.14 of your website, and compile it with the ELDK4.0 succesfully, but when I download it to my PPC405 board, it stopped after initialized the MMU, and encounter an exception in "_start_here".

Is this a standard AMCC eval board, or a custom board? Which one?

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Those who hate and fight must stop themselves -- otherwise it is  not
stopped.
	-- Spock, "Day of the Dove", stardate unknown
