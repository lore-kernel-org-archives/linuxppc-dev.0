Return-Path: <wd@denx.de>
Received: from mailout05.sul.t-online.com (mailout05.sul.t-online.com
	[194.25.134.82]) by ozlabs.org (Postfix) with ESMTP id 4E6C62BDF2
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Jan 2005 22:31:48 +1100 (EST)
To: Clemens Koller <clemens.koller@anagramm.de>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 14 Jan 2005 11:50:56 +0100."
	<41E7A410.6060008@anagramm.de>
Date: Fri, 14 Jan 2005 12:31:21 +0100
Sender: wd@denx.de
Message-Id: <20050114113126.434C4C108D@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Kernel 2.6.x to MPC8540/Microsys Board 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <41E7A410.6060008@anagramm.de> you wrote:
> 
> Now I 've tried the official 2.6.10 Kernel and (cross-)compiled it
> within ELDK 3.1 (btw: is there any difference in between ppc_6xx- and 
> ppc_82xx- ?) which works fine, too.

ppc_82xx is a symbolic link ppc_6xx

> Which is the best Kernel source tree to start porting 2.6.x to the pm854 
> platform? I would prefer to stuck with the official sources. Is that a 
> good idea?

Yes.

> Is it a good idea to just 'copy' the pm854 platform specific files (PCI 
>   initialization and some MTD driver options) to the 2.6.10 tree and see
> how it works?

Copy from where? from 2.4? No.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
A fail-safe circuit will destroy others.                 -- Klipstein
