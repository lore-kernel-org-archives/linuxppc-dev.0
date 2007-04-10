Return-Path: <michaelzwrk@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.180])
	by ozlabs.org (Postfix) with ESMTP id 43849DDEFA
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Apr 2007 23:35:38 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id p76so1330838pyb
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Apr 2007 06:35:36 -0700 (PDT)
Message-ID: <1ea6be8e0704100635ydbf1538i782e796c99891e5d@mail.gmail.com>
Date: Tue, 10 Apr 2007 15:35:35 +0200
From: Michael <michaelzwrk@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: IDE driver in polling mode
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi.
I have a board with MPC8541(PPC PQ3) platform running 2.6.14 Linux.

I'd like to know whether it is possible to use IDE driver (ide-disk)
in polling mode, instead of using IRQ.

In case you wonder - the reason why I need this weired thing is that I
have a compact flash connected directly to the host local bus using
memory mode. It is more-or-less IDE-compatible, except that it doesn't
issue interrupts.

Thanks,
             Michael.
