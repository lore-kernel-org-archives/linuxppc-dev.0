Return-Path: <dgaur@cdotd.ernet.in>
Received: from sandesh.cdotd.ernet.in (sandesh.cdotd.ernet.in [196.1.105.47])
	by ozlabs.org (Postfix) with ESMTP id 9906DDDDFC
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 21:13:24 +1000 (EST)
Received: from sandesh.cdotd.ernet.in (localhost [127.0.0.1])
	by localhost.cdotd.ernet.in (Postfix) with ESMTP id 3E1A5CFB31
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 16:16:39 +0530 (IST)
Received: from mail1.cdotd.ernet.in (mail1.cdotd.ernet.in [196.1.105.196])by
	sandesh.cdotd.ernet.in (Postfix) with ESMTP id 1B33FCFB18for
	<linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 16:16:39 +0530 (IST)
Received: from cdotd.ernet.in (localhost.localdomain [127.0.0.1])by
	mail1.cdotd.ernet.in (8.12.5/8.12.5) with ESMTP id l8PB3xB7018592for
	<linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 16:34:00 +0530
From: "Deepak Gaur" <dgaur@cdotd.ernet.in>
To: linuxppc-dev@ozlabs.org
Subject: MPC8560 CPM2 SCC(UART) Driver CPM_UART_CONSOLE
Date: Tue, 25 Sep 2007 17:33:59 +0630
Message-Id: <20070925104704.M46195@cdotd.ernet.in>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

I am writing a kernel module which is required to parse the characters received from a
device attached to MPC8560 SCC2 (UART slave mode) on serial interface. This SCC is
required to be configured for single-buffer, character based operation. Moreover on
another SCC (SCC1 UART master mode) the board debug interface(console) is connected.

While trying to figure out CPM UART device driver interface available in file
drivers/serial/cpm_uart/cpm_uart_core.c for my kernel module I found that some of the
functions are available when CPM_UART_CONSOLE is enabled. 

My doubt is regarding status of this flag for my hardware setup. Should this flag be
enabled or not. If it is required to be enabled for supporting SCC1 then how SCC2 will
be handled?

As I am a novice in this area , I shall be grateful if you please guide me in
understanding this driver code.

with regards,

Deepak Gaur
