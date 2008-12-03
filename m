Return-Path: <stephane.fillod@thomson.net>
Received: from exprod7og106.obsmtp.com (exprod7og106.obsmtp.com [64.18.2.165])
	by ozlabs.org (Postfix) with SMTP id 782C3DDDF0
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Dec 2008 22:30:05 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: virtex4 RTOS with hw FPU.
Date: Wed, 3 Dec 2008 11:57:47 +0100
Message-ID: <0B45E93C5FF65740AEAE690BF3848B7AD38475@rennsmail04.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@thomson.net>
To: "vadik" <vadikml@gmail.com>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

vadik wrote:
> I have implementation of Virtex4 with hw FPU trough APU .
>
>Is there any Real Time OS that directly supports this implementation
without
>relying on sw floating point emulation.

This is a matter of tool chain and setup of your kernel?

>Xilinx Relesed GCC build of their own that is patched to support the
apu fpu
>implementation , but this helps me on the application level but if the
>kernel doesn't support this implemntation i have a problem .

Indeed, the kernel has to save and restore FPU registers upon task
switch.

You should look for CONFIG_PPC_FPU in the Kconfig of Linux.
I can't help you more, because I'm not used to the ppc in Virtex4.
However, there must be some appropriate forums on Xilinx site.

>linux is not RT enough , does the linuxwoks supports this kind of
>implementation ?

Have you considered Xenomai[1], the F/OSS hard real-time extension to
Linux?
It works great on all range of powerpc's, and it is rock solid.

[1] http://xenomai.org

Regards
--=20
Stephane
