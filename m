Return-Path: <wd@denx.de>
Received: from mailout06.sul.t-online.com (mailout06.sul.t-online.com
	[194.25.134.19]) by ozlabs.org (Postfix) with ESMTP id 5C7FF67E30
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  2 Aug 2005 17:19:01 +1000 (EST)
To: "FCG WANG Baohua" <Baohua.WANG@alcatel-sbell.com.cn>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 02 Aug 2005 12:52:04 +0800."
	<A9DE2BAF233E444FA9C5E77A5825A01E8652FD@ydmail.sbell.com.cn>
Date: Tue, 02 Aug 2005 09:18:51 +0200
Sender: wd@denx.de
Message-Id: <20050802071851.BB9F5353BF9@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: serial console no response after print "Transferring control to
	Linux (at address 00000000)" on PPC860
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <A9DE2BAF233E444FA9C5E77A5825A01E8652FD@ydmail.sbell.com.cn> you wrote:
> 
>   I use ppcboot and ELDK 3.1.1 kernel 2.4.25 to boot a PPC860 board, I
> select the ttyS0, 9600, root=/de/ram during config the kernel.
>    I select the SMC1,SMC2 device too. 
>   But when bootm 180000, it print the "Transferring control to Linux (at
> address 00000000)"  then halt. 
>   How can I do? Tell me the detail when config the kernel, thanks!

After all the questions you posted to the mailing list I want to give
two recommendations:

* Please continue to try things for a while (dasy a day or so) before
  posting. This will avoid a lot of unnecessary postings.

* Please do yourself (and us) a favour and  read  the  documentation,
  especially  the  FAQ  section  of the DULG. If you already read it,
  then read it agaion, carefully.
  
Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
You may call me by my name, Wirth, or by my value, Worth.
- Nicklaus Wirth
