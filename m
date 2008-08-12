Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id B3969DDEF1
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Aug 2008 04:11:41 +1000 (EST)
To: Pieter <phenning@vastech.co.za>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Mounting PRAMFS support
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <48A15FC3.3060008@vastech.co.za>
References: <48A15FC3.3060008@vastech.co.za>
Date: Tue, 12 Aug 2008 20:11:38 +0200
Sender: wd@denx.de
Message-Id: <20080812181138.BEF53248BF@gemini.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Pieter,

In message <48A15FC3.3060008@vastech.co.za> you wrote:
> 
> Im using a ppc85xx processor with Denx ELDK (4.1) The board  has 512MB
> DDR2 and the board config reserves 64M for pram. during bootup the
> mem=$mem argument is passed to the linux kernel command line and linux
> boots successfully.

So what are the exact boot messages of your kernel?

> I am unable to mount the PRAMFS - all documentation leads me to use
> 
> mount -t pramfs -o physaddr=0x1c000000,init=0x4000000 none /mnt
-------------------------------------------------------------^^^^
> witch fails with the message:
> mounting none on /mtd failed: no such devise 
-------------------^^^^

/mnt != /mtd

There is something worng, probably your description. It would be
better if you showed the precise commands and outpout from your
target system.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"Open the pod bay doors, HAL."                    - Dave Bowman, 2001
