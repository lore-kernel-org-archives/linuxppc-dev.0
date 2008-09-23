Return-Path: <wg@grandegger.com>
Message-ID: <48D8B214.2050706@grandegger.com>
Date: Tue, 23 Sep 2008 11:08:36 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: irq_disable() not working
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

I'm trying to understand how irq_disable() is supposed to work on
PowerPC systems. Most PowerPC PIC do *not* implement the enable and
disable, but just the unmask and mask methods, e.g:

  http://lxr.linux.no/linux+v2.6.26.5/arch/powerpc/sysdev/mpic.c#L867

The irq_disable() function will then call the default function
default_disable():

  http://lxr.linux.no/linux+v2.6.26.5/kernel/irq/chip.c#L234

which does not *nothing*. I do not see how the interrupt gets disabled
on the hardware level. Obviously I have missed something. TIA for
clarification.

Wolfgang.
