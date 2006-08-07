Return-Path: <v.selvamuthukumar@gdatech.co.in>
Received: from gdatech.co.in (mail.gdatech.co.in [202.144.30.226])
	by ozlabs.org (Postfix) with ESMTP id 04E6C67B58
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Aug 2006 20:23:34 +1000 (EST)
Received: from [192.168.0.2] (localhost.localdomain [127.0.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id 5A8318780B3
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Aug 2006 03:02:08 -0700 (PDT)
Received: from gdatech.co.in ([192.168.0.3])
	by [127.0.0.1] ([127.0.0.1]) (port 7027) (Abaca EPG outproxy filter
	1.3.4.5154-maint13 $Rev: 5154 $) id r687030208D-00-2
	for linuxppc-dev@ozlabs.org; Mon, 07 Aug 2006 03:02:08 -0700
Received: from mail.gdatech.co.in (unknown [192.168.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id 1847E8780B1
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Aug 2006 03:02:08 -0700 (PDT)
Message-ID: <32953.192.168.3.71.1154945271.squirrel@192.168.0.1>
Date: Mon, 7 Aug 2006 15:37:51 +0530 (IST)
Subject: Reg. Serial and Virtual consoles
From: "Selvamuthukumar V" <v.selvamuthukumar@gdatech.co.in>
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,
I'm  working on a MPC8360 board. I've connected a VGA card in a PCI slot.
I modified the kernel commandline console parameters, and now I'm getting
all the kernel messages in both serial port and VGA. I modified the
/etc/inittab file and getting login prompt in VGA(virtual terminal). Is
keyboard is necessary to login via virtual terminal? Is there anyway to
select serial port as the input to the virtual terminal? I want to login
to the virtual terminal and want a shell in VGA. Please guide me in this
regard.

     -Selva
