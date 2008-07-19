Return-Path: <gvb.linuxppc.dev@gmail.com>
Received: from QMTA10.emeryville.ca.mail.comcast.net
	(qmta10.emeryville.ca.mail.comcast.net [76.96.30.17])
	by ozlabs.org (Postfix) with ESMTP id 415DBDDED7
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Jul 2008 08:21:02 +1000 (EST)
Message-ID: <488268CB.3030906@gmail.com>
Date: Sat, 19 Jul 2008 18:20:59 -0400
From: Jerry Van Baren <gvb.linuxppc.dev@gmail.com>
MIME-Version: 1.0
To: VenkataKrishna <venkatakrishnap@vrindatech.com>
Subject: Re: linux BSP
References: <20080719093455.4740BDDDE9@ozlabs.org>
In-Reply-To: <20080719093455.4740BDDDE9@ozlabs.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

VenkataKrishna wrote:
> Dear Friends,
> 
> I want to ………
> 
> 1. How to develop linux BSP to MPC8260.

The term "BSP" (Board Support Package) is not used much in linux-land. 
By BSP you are probably referring to a boot program (bootrom) and a 
linux configuration (kernel/drivers).

For a bootrom, I recommend u-boot.  There are several 8260 boards in the 
standard u-boot repository that you can start from and customize for 
your board.

If you go this route, you will want to subscribe to the u-boot-users list
https://lists.sourceforge.net/lists/listinfo/u-boot-users

For more information, sorted from general to specific:
http://www.denx.de/
http://www.denx.de/en/Software/WebHome
http://www.denx.de/wiki/UBoot/WebHome
http://www.denx.de/wiki/UBoot/Documentation
http://www.denx.de/wiki/DULG/Manual

Browse the source:
http://git.denx.de/

> 2. where can I start to develop linux BSP.

Right from the comfort of your own linux computer!  (Developing under 
Windows/cygwin/colinux is possible, but everything is between five times 
more difficult and infinitely more difficult.  NOT recommended!)

> 3. what are tools available in market to develop linux BSP.

I would recommend downloading and installing ELDK from Denx.  It is a 
reliable and painless cross compiler (THANKS, Wolfgang & Co.!)
ftp://ftp.denx.de/pub/eldk/4.2/ppc-linux-x86/
in particular:
ftp://ftp.denx.de/pub/eldk/4.2/ppc-linux-x86/iso/ppc-2008-04-01_freescale.iso

> Thanks Regards
> Venkatakrishna Pari

You are welcome.
gvb
