Return-Path: <wd@denx.de>
Received: from mailout07.sul.t-online.com (unknown [194.25.134.83])
	by ozlabs.org (Postfix) with ESMTP id C0F8D2BF1F
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Jan 2005 02:34:48 +1100 (EST)
To: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 05 Jan 2005 08:57:57 EST."
	<313680C9A886D511A06000204840E1CF0A64744E@whq-msgusr-02.pit.comms.marconi.com>
Date: Wed, 05 Jan 2005 16:32:58 +0100
Sender: wd@denx.de
Message-Id: <20050105153303.83065C108D@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: watchdog vs inflate in zlib 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <313680C9A886D511A06000204840E1CF0A64744E@whq-msgusr-02.pit.comms.marconi.com> you wrote:
> 
> The compressed kernel image for Linux 2.6 is considerably larger than for
> Linux 2.4 (which works fine) - perhaps I need to put more watch dog resets
> into zlib code ... ? - Any advise on where to put those resets, etc. ?

Have a look at the U-Boot code ...

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"There are things that are so serious that you can  only  joke  about
them"                                                    - Heisenberg
