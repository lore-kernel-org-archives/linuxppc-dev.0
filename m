Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 60868DDDFF
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Feb 2007 18:28:12 +1100 (EST)
To: "Saiful Khan" <saiful.etc@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: ELDKs Kernel is not printing the printk 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 01 Feb 2007 23:22:37 +0530."
	<38b44d590702010952nd58f2dbl45a296e535e35869@mail.gmail.com>
Date: Fri, 02 Feb 2007 08:28:09 +0100
Sender: wd@denx.de
Message-Id: <20070202072809.E17E3352B86@atlas.denx.de>
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

In message <38b44d590702010952nd58f2dbl45a296e535e35869@mail.gmail.com> you wrote:
> 
> but when i try to boot the kernel image from ram, i got the last message
> from u-boot but i do not get any printk() message from kerne.
> so i am unable to debug the kernel also..

Use a BDM debugger.

> please suggest me if i have to concentrate more on some particular section
> and proceed, and how to proceed...?

And read the debugging  sdection  in  the  DULG,  and  the  FAQ.  For
example, try a post mortem dump of the log buffer.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Committee, n.:  A group of men who individually can do nothing but as
a group decide that nothing can be done.                 - Fred Allen
