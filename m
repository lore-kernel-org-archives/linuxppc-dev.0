Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3FAA768A3D
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Feb 2006 05:48:16 +1100 (EST)
Date: Fri, 3 Feb 2006 12:40:16 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Fahd Abidi <fabidi@ultsol.com>
Subject: Re: Gdb with MPC85xx
In-Reply-To: <81C69D96BDD30640952C7A404004AA2501954E@ultsol01.tewks.ultsol.local>
Message-ID: <Pine.LNX.4.44.0602031237240.6362-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

On Fri, 3 Feb 2006, Fahd Abidi wrote:

> Hello,
> 
> I am wondering if someone here is using GDB to debug code on an 85xx
> platform with the BDI. I have been running into several issues with GDB
> 5.x and 6.x where the E500 core does not seem to either step properly to
> the next line of code in the kernel or uboot or gets lost altogether.
> Each version of GDB seems to have its own set of bugs. If someone has
> been using a version of GDB that works pretty well then let me know what
> version it is and I can try and download it and build it and see if it
> behaves better.

Are you able to get the registers in GDB properly?  The e500 introduces a 
different GDB register protocol than standard PPC.  This either requires 
the latest GDB and possibly BDI firmware.  I forget how BDI handles the 
different protocol layouts.  I'm pretty sure they added support for "full 
e500 GDB" recently.

You also, have to build u-boot and your kernel to handle the quicky debug 
support on 85xx.

- kumar
