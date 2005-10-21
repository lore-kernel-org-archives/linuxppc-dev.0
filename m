Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 13D996857D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Oct 2005 23:38:33 +1000 (EST)
In-Reply-To: <4358DD4C.7020507@cpe.fr>
References: <4358DD4C.7020507@cpe.fr>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B6774C27-2E9C-4660-8D5C-4EBE5FEF698D@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 21 Oct 2005 08:39:03 -0500
To: Nathael PAJANI <nathael.pajani@cpe.fr>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Three-Speed Ethernet support on MPC8560 (TSEC)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Oct 21, 2005, at 7:21 AM, Nathael PAJANI wrote:

> Hi all!
>
> I'm working on a port of linux (2.6.13-2) on an Actis-computer board,
> based on the Freescale MPC8560 Processor.
>
> I solved the problems I had with the init process, and I actually have
> the console (SCC1) and one ethernet controler (FCC3) running.
>
> I will now go on with the Three-Speed Ethernet Controler, and there
> actually seem to be no support for it, but maybe I did not look at the
> right place?

The TSEC has been supported for a long time.  The driver is call  
gianfar (drivers/net/gianfar*).

> I got another question, about the FCC driver: it uses a "big"  
> structure
> "fcc_enet_t" wich seems to be aimed at stats. This is initialised,  
> but I
> did not find where this is used. Is it?

The FCC enet driver has been completely rewritten recently and is in  
the process of being accepted into the kernel.  Hopefully one of the  
guys with more knowledge on the details will be able to help you on  
the specifics.

- kumar
