Return-Path: <wd@denx.de>
Received: from mailout05.sul.t-online.com (mailout05.sul.t-online.com
	[194.25.134.82]) by ozlabs.org (Postfix) with ESMTP id 057912BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Dec 2004 04:49:14 +1100 (EST)
To: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 28 Dec 2004 12:28:37 EST."
	<313680C9A886D511A06000204840E1CF0A647421@whq-msgusr-02.pit.comms.marconi.com>
Date: Tue, 28 Dec 2004 18:48:50 +0100
Sender: wd@denx.de
Message-Id: <20041228174855.83AF4C14EC@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: simple bootloader 2.6.10-rc3 8xx 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <313680C9A886D511A06000204840E1CF0A647421@whq-msgusr-02.pit.comms.marconi.com> you wrote:
> 
> I guess I need some more education - since I am getting my problem right at
> the boot - is 
> I-Cache enabled (by default ?) for 8xx on 2.6 at the booting ? - I do not

They get turned on very early.

> see anything in .config 
> which controls it (or I am missing it there ?) 

No. This is not configurable.

> How (where and at what point during the boot)-) I could disable I-Cache ?

Search for IC_CST in "arch/ppc/kernel/head_8xx.S"

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Every program has at least one bug and can be shortened by  at  least
one instruction - from which, by induction, one can deduce that every
program can be reduced to one instruction which doesn't work.
