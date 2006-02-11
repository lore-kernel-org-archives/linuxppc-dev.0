Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id BE1A7679EA
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Feb 2006 23:59:04 +1100 (EST)
To: atul.sabharwal@exgate.tek.com
From: Wolfgang Denk <wd@denx.de>
Subject: Re: kernel startup 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 10 Feb 2006 17:47:12 PST."
	<4A062D477D842B4C8FC48EA5AF2D41F201BA209B@us-bv-m23.global.tektronix.net>
Date: Sat, 11 Feb 2006 13:59:01 +0100
Sender: wd@denx.de
Message-Id: <20060211125901.BD9C935262C@atlas.denx.de>
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

In message <4A062D477D842B4C8FC48EA5AF2D41F201BA209B@us-bv-m23.global.tektronix.net> you wrote:
> >>Please do yourself a favour and read some docs and FAQ's first.  With
> >>a  low mapping ogf the IMMR like 0x00f00000 you will never be able to
> >>run Linux.
> 
> I know that the processor does not allow setting up a base address for the
> exception vectors. In this situation, it would never be able to handle

This has nothing to do with that. Please *read* the FAQ!

> Just don't know if this is feasible so scrambling for any other docs. I
> have the instruction reference and development manual.

You can reinvent the wheel, or  read  the  documented  experience  of
others who went the same way long time ago.


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The perversity of nature is nowhere better demonstrated by  the  fact
that,  when  exposed to the same atmosphere, bread becomes hard while
crackers become soft.
