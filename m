Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9E4CCDE28C
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 02:35:38 +1000 (EST)
Received: from LPSC0173W (lpsc0173w.in2p3.fr [134.158.40.173])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with SMTP id m4FGZXdR028325
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 18:35:33 +0200
Message-ID: <02f401c8b6a9$b1e062e0$ad289e86@LPSC0173W>
From: "Guillaume Dargaud" <dargaud@lpsc.in2p3.fr>
To: <linuxppc-dev@ozlabs.org>
Subject: Using GPIO
Date: Thu, 15 May 2008 18:35:25 +0200
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello all,
I'm trying to use the Xilinx GPIO from a user program.
Since I haven't managed to compile their example (simon.c is given without a 
makefile), I wanted to try using /dev/gpio...

So I added
/dev/gpio0  c  666  0  0  10  185 -  -  -
to device_table.txt when I generated my root filesystem with buildroot, but 
apparently this leads nowhere as it's not visible in /proc/devices.

Is there some example or tutorial on how to use CONFIG_XILINX_GPIO ? Either 
as a device or as API calls...
-- 
Guillaume Dargaud
http://www.gdargaud.net/
