Return-Path: <Alexander.Povolotsky@marconi.com>
Received: from mailgate.pit.comms.marconi.com (mailgate.pit.comms.marconi.com
	[169.144.68.6]) by ozlabs.org (Postfix) with ESMTP id 832E567A45
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Jan 2005 21:59:36 +1100 (EST)
Received: from mailman.pit.comms.marconi.com (mailman.pit.comms.marconi.com
	[169.144.2.12])
	by mailgate.pit.comms.marconi.com (8.12.10+Sun/8.12.10) with ESMTP id
	j0GAxVDR022938
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Jan 2005 05:59:31 -0500 (EST)
Received: from uspitsmsgrtr01.pit.comms.marconi.com
	(uspitsmsgrtr01.pit.comms.marconi.com [169.144.2.221])
	by mailman.pit.comms.marconi.com (8.9.3/8.9.3) with ESMTP id FAA13890
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Jan 2005 05:59:32 -0500 (EST)
Message-ID: <313680C9A886D511A06000204840E1CF0A6474E7@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'linuxppc-dev@ozlabs.org'" <linuxppc-dev@ozlabs.org>
Date: Sun, 16 Jan 2005 05:58:53 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Subject: Linux 2.6-10.rc3  8xx kernel booting - how to set baud rate for t
	he serial driver ?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

My bootloader uses 115200 baud rate for the serial output during boot
strapping.

Then, during Linux 2.6-10.rc3  8xx kernel booting - how to set certain baud
rate for the serial driver ?

When init_consoleI( ) is called - at what baud rate the 8xx serial driver is
getting set ?

Currently I am have:
CONFIG_SERIAL_CPM_CONSOLE
in my .config 

Is there a way to set (force) the baud rate in the .config (or by other
means) to be in effect for the kernel booting ?

Thanks,
Best Regards
