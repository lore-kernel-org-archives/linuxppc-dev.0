Return-Path: <sauros@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.202])
	by ozlabs.org (Postfix) with ESMTP id 8E95A67A67
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Mar 2005 04:19:36 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id 71so1607127wra
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Mar 2005 09:19:34 -0800 (PST)
Message-ID: <c359a7c0050311091271071a09@mail.gmail.com>
Date: Fri, 11 Mar 2005 14:12:54 -0300
From: Sauro Salomoni <sauros@gmail.com>
To: Linux-Embedded <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: MPC5200 clock manipulation
Reply-To: Sauro Salomoni <sauros@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Good afternoon.

I am using 2.4.25 denx Linux kernel in a MPC5200 custom board and I am
looking for solutions to reduce power consumption. One possible
solution is to reduce the frequencies using the CDM Registers.

But then I have a problem: the MPC5200 User Manual states that the
Power On Configuration Register is a read only register, then I can
only configure it using straps and reseting the board. And the CDM
Configurations Register, which controls IPB and PCI clocks, is already
configured for low frequencies by default.

Does anyone have a sugestion on how to reduce the frequencies (Fsystem
and XLB) without the need of a reset? Maybe there is a way of
configuring the clocks that I couldn't figure out.

Thanks in advance


-- 
Sauro Salomoni

Engeneer
Ztec
Fone: +55 61 322-2544   FAX:+55 61 224-7171
www.ztec.com.br
