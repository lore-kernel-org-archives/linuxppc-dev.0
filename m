Return-Path: <wd@denx.de>
Received: from mailout04.sul.t-online.com (mailout04.sul.t-online.com
	[194.25.134.18]) by ozlabs.org (Postfix) with ESMTP id 7A4932BEA0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Nov 2004 06:04:37 +1100 (EST)
To: Jeff Stevens <jsteve17@yahoo.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 23 Nov 2004 08:11:39 PST."
	<20041123161139.2563.qmail@web41415.mail.yahoo.com>
Date: Tue, 23 Nov 2004 20:04:14 +0100
Sender: wd@denx.de
Message-Id: <20041123190419.6F0ACC1430@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: U-Boot with DDR ECC Compilation Error 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20041123161139.2563.qmail@web41415.mail.yahoo.com> you wrote:
> I am porting U-Boot for a custom board that is very

You should post U-Boot related questions to the u-boot-users  mailing
list instead. Here on this list you re off topic.

> similar to the MPC8540ADS.  Everything compiles fine,
> until I try to compile in DDR SDRAM ECC support.  I
> tried compiling U-Boot for the MPC8540ADS and I get
> the same error once I define 'CONFIG_DDR_ECC'.  Here
> is the output:

CONFIG_DDR_ECC is set by default for the MPC8540ADS board; this configuration builds fine here. I guess you must be doing something wrong.

Is there any chance that your files got corrupted  by  storing  in  a
Windoze filesystem?

...
> ppc_8xx-gcc -Wa,-gstabs -D__ASSEMBLY__ -g  -Os   -fPIC

Why do you chose the ppc_8xx compiler here? This is not  the  optimal
choice  for  a  85xx processor (allthough this does not really matter
here).

...
> /orss/gtvme/uboot/u-boot-1.1.1/cpu/mpc85xx/start.S

Seems you are using U-Boot 1.1.1; why are you using  an  old  version
for a new port? Please use current code (top of CVS) instead.

> I am using the ppc_8xx- tools from ELDK 3.1. I would

Try using current code,  and  make  sure  that  your  files  are  not
corrupted.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Every living thing wants to survive.
	-- Spock, "The Ultimate Computer", stardate 4731.3
