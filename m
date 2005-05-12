Return-Path: <wd@denx.de>
Received: from mailout05.sul.t-online.com (mailout05.sul.t-online.com
	[194.25.134.82]) by ozlabs.org (Postfix) with ESMTP id 2DFEB67B44
	for <linuxppc-dev@ozlabs.org>; Thu, 12 May 2005 18:30:07 +1000 (EST)
To: Marc Leeman <marc.leeman@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 12 May 2005 09:47:51 +0200."
	<20050512074751.GH21217@scorpius.homelinux.org>
Date: Thu, 12 May 2005 10:29:42 +0200
Sender: wd@denx.de
Message-Id: <20050512082947.A9290C1512@atlas.denx.de>
Cc: majid khan khan <majidkhan14@rediffmail.com>, linuxppc-dev@ozlabs.org
Subject: Re: how is flow in linux right from bootstrap program 
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <20050512074751.GH21217@scorpius.homelinux.org> you wrote:
> 
> The only thing that you need to know IIRC is that the boot address is at
> 0xfff00000. I believe that's fixed. If your bootloader is placed there,

No, it is not. Assuming we're talking about PowerPC systems only:  it
may  be  at 0x0100 on some systems, or 0xFFF00100 on others, orit may
be configurable (for example with a jumper) to  be  either  of  these
addresses, or it may be 0xFFFFFFFC on other processors.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Harrisberger's Fourth Law of the Lab:
	Experience is directly proportional to the
	amount of equipment ruined.
