Return-Path: <tnt@246tNt.com>
Received: from outmx019.isp.belgacom.be (outmx019.isp.belgacom.be
	[195.238.2.200]) by ozlabs.org (Postfix) with ESMTP id A6F8A67A6E
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  7 Feb 2005 05:06:32 +1100 (EST)
Received: from outmx019.isp.belgacom.be (localhost [127.0.0.1])
	by outmx019.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j16I6Toe006316
	for <linuxppc-embedded@ozlabs.org>; Sun, 6 Feb 2005 19:06:29 +0100
	(envelope-from <tnt@246tNt.com>)
Received: from ayanami.246tNt.com (223.190-201-80.adsl.skynet.be
	[80.201.190.223])
	by outmx019.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j16I6NAM006284
	for <linuxppc-embedded@ozlabs.org>; Sun, 6 Feb 2005 19:06:23 +0100
	(envelope-from <tnt@246tNt.com>)
Received: from [10.0.0.245] (246tNt-laptop.lan.ayanami.246tNt.com [10.0.0.245])
	by ayanami.246tNt.com (Postfix) with ESMTP id CFFA717F0FD
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  6 Feb 2005 19:04:40 +0100 (CET)
Message-ID: <42065C9F.30109@246tNt.com>
Date: Sun, 06 Feb 2005 19:06:23 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
References: <000001c50adc$c814dae0$6401a8c0@supernova>
In-Reply-To: <000001c50adc$c814dae0$6401a8c0@supernova>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: Re: Problems with Serial Port on IceCube
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

Does your kernel cmdline includes the "console=ttyS0" ?
It's mandatory here while with DENX's kernel it may not be.

The initscript are not even launched at that point ...


Sylvain


Linas Petras wrote:

>Hi All
>
>I'm running Sylvain Munaut's version of 2.6.10-rc2 with DENX's 3.1 ELDK as
>the cross
>compile tools with nfs mounted root filesystem and I seem to have a probelm
>when I'm 
>connected to the "icecube" development boards serial port.
>
>I get the u-boot 1.1.3 bootrom messages from the serial port on the
>"icecube" and can 
>boot the kernel using the serial port but I don't get any messages after the
>early 
>boot message "arch: exit". It appeared to me that the board was booting so I
>tried to 
>telnet via the network to the board and this worked fine. So the kernel is
>running, I 
>just don't get the "normal" bootup messages from the kernel.
>
>If I use the standard DENX 2.4.25 kernel I get all the message going to the
>serial 
>port OK.
>
>Any ideas of whats going on ????? Is their a problem with the console
>support in 
>Sylvain's port or something in the "standard" init scripts that come with
>DENX's ELDK 
>3.1 when used with a 2.6.xx kernel or have I missed something obvious?
>
>Linas Petras
>------------
>I know not with which weapons World War III will be faught, but World War IV
>will be faught with sticks and stones. - Albert Einstein.
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>  
>
