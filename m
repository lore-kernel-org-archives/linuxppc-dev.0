Return-Path: <Alexander.Povolotsky@marconi.com>
Received: from mailgate.pit.comms.marconi.com (mailgate.pit.comms.marconi.com
	[169.144.68.6]) by ozlabs.org (Postfix) with ESMTP id BEE3267A2C
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Jan 2005 22:13:51 +1100 (EST)
Received: from mailman.pit.comms.marconi.com (mailman.pit.comms.marconi.com
	[169.144.2.12])
	by mailgate.pit.comms.marconi.com (8.12.10+Sun/8.12.10) with ESMTP id
	j0GBDmDR023052
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Jan 2005 06:13:48 -0500 (EST)
Received: from uspitsmsgrtr01.pit.comms.marconi.com
	(uspitsmsgrtr01.pit.comms.marconi.com [169.144.2.221])
	by mailman.pit.comms.marconi.com (8.9.3/8.9.3) with ESMTP id GAA16041
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Jan 2005 06:13:49 -0500 (EST)
Message-ID: <313680C9A886D511A06000204840E1CF0A6474E8@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'linuxppc-dev@ozlabs.org'" <linuxppc-dev@ozlabs.org>
Date: Sun, 16 Jan 2005 06:13:17 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Subject: RE: Linux 2.6-10.rc3  8xx kernel booting - how to set baud rate f
	or the serial driver ?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I forgot to mention that my command line in .config is:
CONFIG_CMDLINE="console=ttyCPM0 panic=3 root=/dev/ram"

Could I specify the baud rate (just for kernel booting, not for
bootstrapping) in the command line ?
>  -----Original Message-----
> From: 	Povolotsky, Alexander  
> Sent:	Sunday, January 16, 2005 5:59 AM
> To:	'linuxppc-dev@ozlabs.org'
> Subject:	Linux 2.6-10.rc3  8xx kernel booting - how to set baud rate
> for the serial driver ?
> 
> Hi,
> 
> My bootloader uses 115200 baud rate for the serial output during boot
> strapping.
> 
> Then, during Linux 2.6-10.rc3  8xx kernel booting - how to set certain
> baud rate for the serial driver ?
> 
> When init_consoleI( ) is called - at what baud rate the 8xx serial driver
> is getting set ?
> 
> Currently I am have:
> CONFIG_SERIAL_CPM_CONSOLE
> in my .config 
> 
> Is there a way to set (force) the baud rate in the .config (or by other
> means) to be in effect for the kernel booting ?
> 
> Thanks,
> Best Regards
