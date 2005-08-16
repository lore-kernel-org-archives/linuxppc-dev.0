Return-Path: <wd@denx.de>
Received: from mailout01.sul.t-online.com (mailout01.sul.t-online.com
	[194.25.134.80]) by ozlabs.org (Postfix) with ESMTP id EF5D467F67
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Aug 2005 05:48:37 +1000 (EST)
To: Clemens Koller <clemens.koller@anagramm.de>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 16 Aug 2005 20:23:01 +0200."
	<43022F05.3050409@anagramm.de>
Date: Tue, 16 Aug 2005 21:48:25 +0200
Sender: wd@denx.de
Message-Id: <20050816194825.A62AC353AB5@atlas.denx.de>
Cc: linuxppc-dev@ozlabs.org, surendra.yadav@softdel.com
Subject: Re: Framebuffer driver using SM501 hardware. 
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <43022F05.3050409@anagramm.de> you wrote:
>
> I was working with the SM501 framebuffer for a while on
> linux-2.6.

...and we did in the context of our 2.4 kernel.

> There is a color-mapping issue left (RGB is swapped on powerpc)
> and it needs lots of code cleanup or a complete rewrite.

I think we fixed some of these problems, and I have a couple of other
patches sitting in my queue. Anybody interested can (1) have  a  look
at our tree and (2) mail me.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"A little knowledge is a dangerous thing."                - Doug Gwyn
