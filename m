Return-Path: <kumar.gala@freescale.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D662E340-91F9-42F4-9B0F-889A49D1E100@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 23 Sep 2005 11:21:36 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
	ppc-dev list <linuxppc-dev@ozlabs.org>
Subject: moving math-emu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul,

I have a big patch that moves arch/ppc/math-emu to arch/powerpc/math- 
emu and fixes up the arch/ppc/Makefile.  How do you want me to send  
this to you since its too big for the list or can you just make this  
change since its:

1. git rename arch/ppc/math-emu arch/powerpc/math-emu
2. fixup arch/ppc/Makefile so:
     core-$(CONFIG_MATH_EMULATION)   += arch/powerpc/math-emu/

Let me know.

- kumar
