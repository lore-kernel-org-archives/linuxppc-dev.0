Return-Path: <sven@batzer.biz>
Received: from shadow.prohost.de (mx3s.prohost.de [216.71.45.135])
	by ozlabs.org (Postfix) with ESMTP id 20431B6F04
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 28 Jul 2010 19:31:54 +1000 (EST)
Received: from batzer-biz.prossl.de (localhost [127.0.0.1])
	by shadow.prohost.de (8.13.8/8.13.8) with ESMTP id o6S9QA6J028243
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jul 2010 11:26:10 +0200
Message-ID: <59976.84.175.96.30.1280309170.squirrel@batzer-biz.prossl.de>
Date: Wed, 28 Jul 2010 11:26:10 +0200 (CEST)
Subject: Problems using UART on MPC5200
From: "Sven Batzer" <sven@batzer.biz>
To: linuxppc-dev@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

I am using a PowerPC MPC5200 from Freescale (with STK5200-Board), ELDK 4.2
from DENX and the Kernel 2.6.34-rc5.

My Kernel is running fine. The console output is coming over the device
ttyPSC0.

In future I want to login over telnet. So I deactivated the Kerneloption
to output the console over the UART device.

Now I want to read and write to the RS232 interface from a program.
But when I try to open the device ttyPSC* I get the following error:
"unable to read portsettings : Inappropriate ioctl for device"

What does this mean ? How can I send and receive Data from/to the UART ?

Thanks for your help.

Sven
