Return-Path: <wd@denx.de>
Received: from mailout04.sul.t-online.com (mailout04.sul.t-online.com
	[194.25.134.18]) by ozlabs.org (Postfix) with ESMTP id 3EF4967E40
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  2 Aug 2005 17:13:05 +1000 (EST)
To: "FCG WANG Baohua" <Baohua.WANG@alcatel-sbell.com.cn>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 02 Aug 2005 10:08:35 +0800."
	<A9DE2BAF233E444FA9C5E77A5825A01E8652F9@ydmail.sbell.com.cn>
Date: Tue, 02 Aug 2005 09:12:35 +0200
Sender: wd@denx.de
Message-Id: <20050802071235.28CA0353BF9@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Bad Magic Number when boot linux kernel with ppcboot (PPC860
	board)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <A9DE2BAF233E444FA9C5E77A5825A01E8652F9@ydmail.sbell.com.cn> you wrote:
> 
> kernel, after I loaded it print the following messages:
> 
> => bootm 0x180000
> ## Booting image at 00000000 ...
> Bad Magic Number
> =>

Which address did you load the image to?

> How to slove it, thanks a lot!
> I use:  zImage, 
> vmlinux.UBoot,
>  vmlinux 
>  it all print the same messages, How can I do? 

Please read the documentation. Only uImage = vmlinux.UBoot can work.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"Confound these ancestors.... They've stolen our best ideas!"
- Ben Jonson
