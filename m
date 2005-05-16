Return-Path: <wd@denx.de>
Received: from mailout05.sul.t-online.com (mailout05.sul.t-online.com
	[194.25.134.82]) by ozlabs.org (Postfix) with ESMTP id 342C2679FC
	for <linuxppc-dev@ozlabs.org>; Tue, 17 May 2005 06:26:25 +1000 (EST)
To: =?ISO-8859-2?Q?Przemys=B3aw_F=B1fara?= <przemyslaw.fafara@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 16 May 2005 22:09:54 +0200."
	<4288FE12.5060907@gmail.com>
Date: Mon, 16 May 2005 22:26:05 +0200
Sender: wd@denx.de
Message-Id: <20050516202610.3E1FDC1512@atlas.denx.de>
Cc: linuxppc <linuxppc-dev@ozlabs.org>
Subject: Re: building gcc for ppc platform 
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <4288FE12.5060907@gmail.com> you wrote:
> 
> I have a problem with building ggc for ppc platform. I would like to 
> build it and use it on my xilinx ml310 board. A'm using a montavista 
> linux preview kit, but it doesn't have a gcc. Could you help me?

Use the ELDK - it's more complete, and free.
See http://www.denx.de/ELDK.html

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
People seldom know what they want until you give them what  they  ask
for.
