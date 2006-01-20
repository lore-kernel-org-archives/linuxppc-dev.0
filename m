Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 3667E68A2D
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 21 Jan 2006 06:48:17 +1100 (EST)
To: atul.sabharwal@exgate.tek.com
From: Wolfgang Denk <wd@denx.de>
Subject: Re: u-boot debugging 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 20 Jan 2006 10:06:06 PST."
	<4A062D477D842B4C8FC48EA5AF2D41F201AC2CC8@us-bv-m23.global.tektronix.net>
Date: Fri, 20 Jan 2006 20:48:15 +0100
Sender: wd@denx.de
Message-Id: <20060120194815.654AD353A3F@atlas.denx.de>
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

In message <4A062D477D842B4C8FC48EA5AF2D41F201AC2CC8@us-bv-m23.global.tektronix.net> you wrote:
>
> Besides, the BDI has only a 10Mbps Ethernet interface.  It might be
> enough for simple debug operation but they should
> Have put a 100Mbps link to put it on a shared network.  For an isolated
> network configuration, it should suffice...

You should really get a clue. Or can you please explain what  is  the
maximum  transfer rate you can get over the BDM / JTAG interface, and
how is this limited by the 10Mbps Ethernet interface?


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Of all the things I've lost, I miss my mind the most.
