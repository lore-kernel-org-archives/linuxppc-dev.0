Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 429BE6888D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Dec 2005 00:26:59 +1100 (EST)
To: zengshuai@sogou.com
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 12 Dec 2005 20:25:36 +0800."
	<4069241.1134390336250.JavaMail.postfix@mx3.mail.sohu.com>
Date: Mon, 12 Dec 2005 14:26:57 +0100
Sender: wd@denx.de
Message-Id: <20051212132657.4349A353416@atlas.denx.de>
Cc: ppc <linuxppc-embedded@ozlabs.org>
Subject: Re: Can we compile them with eldk and debug them with BDI2000? 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <4069241.1134390336250.JavaMail.postfix@mx3.mail.sohu.com> you wrote:
> There are some example C programs in freescale's web.
> They don't work in linux but bareboard.
> Can we compile them with eldk and debug them with BDI2000? 

Yes. You may have to set up your own linker script, though. It  would
be probably much easier to run such code as standalone application in
U-Boot (and yes, this too can be compiled using the ELDK and debugged
using the BDI).

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
We are all agreed that your  theory  is  crazy.  The  question  which
divides  us  is  whether it is crazy enough to have a chance of being
correct. My own feeling is that it is not crazy enough.  - Niels Bohr
