Return-Path: <wd@denx.de>
Received: from mailout01.sul.t-online.com (mailout01.sul.t-online.com
	[194.25.134.80]) by ozlabs.org (Postfix) with ESMTP id 00DD467D82
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  2 Aug 2005 22:16:15 +1000 (EST)
To: "FCG WANG Baohua" <Baohua.WANG@alcatel-sbell.com.cn>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 02 Aug 2005 15:29:24 +0800."
	<A9DE2BAF233E444FA9C5E77A5825A01E865051@ydmail.sbell.com.cn>
Date: Tue, 02 Aug 2005 14:16:02 +0200
Sender: wd@denx.de
Message-Id: <20050802121602.44F113535F9@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: ??: Bad Magic Number when boot linux kernel with ppcboot
	(PPC860 board)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <A9DE2BAF233E444FA9C5E77A5825A01E865051@ydmail.sbell.com.cn> you wrote:
> >
>   The magic number is right when using vmlinux.UBoot instead of vmlinux
> or zImage, Why?

Because vmlinux.UBoot is a correct U-Boot image,  while  vmlinux  and
zImage are not. Read the documentation.

>   Another question puzzle me:
>   The kernel print the "Transferring control to Linux (at address
> 00000000) ... "  then halt ,no any response from serial port.

Read the documentation. This is a FAQ.

>   How to not print the "Transferring control to Linux (at address
> 00000000) ... "  ? Is it right ? 

Yes, this is correct.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Punishment becomes ineffective after a certain point. Men become  in-
sensitive.
	-- Eneg, "Patterns of Force", stardate 2534.7
