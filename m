Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 616F06868F
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Nov 2005 09:09:37 +1100 (EST)
To: Sette Agostino <Agostino.Sette@siemens.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 07 Nov 2005 15:34:44 +0100."
	<69DF49BE936F4441980EC1D59F0ADC2F0108C12C@aqlby02a.siemens.it>
Date: Mon, 07 Nov 2005 23:09:34 +0100
Sender: wd@denx.de
Message-Id: <20051107220934.9120C353E30@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: PPCBoot 2.0.0 Errors 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <69DF49BE936F4441980EC1D59F0ADC2F0108C12C@aqlby02a.siemens.it> you wrote:
> 
> I have the following problem at the PPCBoot startup:
> 
> PPCBoot 2.0.0 (Oct 20 2005 - 12:28:22)

PPCBoot is a dead project. It was discontinued more than 3 years ago.
It is definitely a bad idea to  use  it  for  current  projects.  Use
U-Boot instead.

Also, this is completely off topic on this mailing list.

> CPU:   unknown MPC859 (0x08010004) at 133 MHz: 16 kB I-Cache 8 kB D-Cache

Use U-Boot instead.

> Board: Siemens CCM

And don't use a board configuration that does not match your hardware.

> ## Booting image at 40180000 ...
>    Image Name:   Linux-2.4.20-rthal5

Argh... Ancient stuff again. Forget it.

> Anybody experienced the same problem? Any suggestions about how to solve it?

Use current software. Read the documentation. Post on the appropriate
mailing lists.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
My challenge to the goto-less programmer  is  to  recode  tcp_input()
without any gotos ... without any loss of efficiency (there has to be
a catch).                                             - W. R. Stevens
