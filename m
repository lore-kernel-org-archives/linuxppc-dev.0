Return-Path: <arieswar24b@yahoo.de>
Received: from web25801.mail.ukl.yahoo.com (web25801.mail.ukl.yahoo.com
	[217.12.10.186]) by ozlabs.org (Postfix) with SMTP id EF1B3DDEF5
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 00:22:17 +1100 (EST)
Date: Tue, 20 Jan 2009 13:15:36 +0000 (GMT)
From: Dave Best <arieswar24b@yahoo.de>
Subject: Bestcomm tasks and interrupts on MPC5200(B)
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-ID: <381238.78267.qm@web25801.mail.ukl.yahoo.com>
Reply-To: arieswar24b@yahoo.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm trying to write a driver which uses the Local Plus Bus on my MPC5200B a=
nd therefore have to use BestComm DMA, which requires me to use a Gen_BD ta=
sk for data transfer with Local Plus.
I tried to follow the fec driver that is currently used and took a peek at =
the mpc52xx-ac97 driver which at least uses the same kind of bus as I.

Initialising the task, resetting and enabling works fine. Even request_irq =
reports no error, but when I start a transfer it hangs and if I am lucky, a=
n interrupt occurs after quite some time. But it's always the BestComm ethe=
rnet rx task which produces an RFIFO interrupt, presumably after the watchd=
og catches on.=20
If this happens my interrupt occurs to.

I tried to debug this situation but I am still clueless.
If I use the MPC5200 Interrupt emulation registers to force an interrupt fo=
r my interface to occur, nothing happens except that it hangs.

Any hints, tips or help appreciated.

Dave=0A=0A=0A      
