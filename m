Return-Path: <frannk_m1@yahoo.com>
Received: from web32207.mail.mud.yahoo.com (web32207.mail.mud.yahoo.com
	[68.142.207.138]) by ozlabs.org (Postfix) with SMTP id 703B66838E
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  9 Oct 2005 03:51:03 +1000 (EST)
Message-ID: <20051008175100.71465.qmail@web32207.mail.mud.yahoo.com>
Date: Sat, 8 Oct 2005 10:51:00 -0700 (PDT)
From: Frank <frannk_m1@yahoo.com>
To: xiay@nari-relays.com, linuxppc-embedded@ozlabs.org
In-Reply-To: <200510082230.AA69861636@NARI-RELAYS.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: Re: onboard pci ethernet controller(i82551)without
	eprom(linuxppc2.2.4 MPC5200)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--- ÏÄÓêÏÄÓêiayxiayinariays.com> wrote:

> After i modified e100_initinitn e100_main.c , the pci
pcieethernetcard could been found :
> 
> bash-2.05b# ifcoifconfig
> eth0eth   Link encaencapernet  HWadHWaddrFF:FF:FF:FF:FF
>           BROADCAST MULTMULTICASTU:MTU0  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqutxqueuelen0
>           RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
>           Memory:40000000-40000038
> 
> eth1eth   Link encaencapernet  HWadHWaddr04:9F:00:15:2B
>           inetinetraddr.87.102.215  BcasBcast.87.102.255 
> Mask:255.255.255.0
>           UP BROADCAST RUNNING MULTMULTICASTU:MTU0  Metric:1
>           RX packets:12606 errors:42 dropped:0 overruns:0
> frame:0
>           TX packets:7668 errors:3 dropped:0 overruns:3
> carrier:0
>           collisions:0 txqutxqueuelen0
>           RX bytes:10596597 (10.1 Mb)  TX bytes:1218624 (1.1
> Mb)
>           Interrupt:43
> 
> lo        Link encaencapal LoopLoopback         
inetinetraddr.0.0.1  Mask:255.0.0.0
>           UP LOOPLOOPBACKNING  MTU:MTU36  Metric:1
>           RX packets:4 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:4 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqutxqueuelen> 
> But i still could not confconfig0eth> 
> bash-2.05b# ifcoifconfig0eth8.87.102.140
> SIOCSIOCSIFFLAGSsource temporarily unavailable
> 
> I noticed that there was message as blow during kernel
bootbootup 
> POSIPOSIXformance testing by UNIFUNIFIXPCI:PCIobing PCI
PCIdware
> PCI:PCInnot allocate resource region 0 of device 00:1a.0
> Linux NET4.0 for Linux 2.4
> 
> Intel(R) PRO/100 Network Driver - version 2.3.38-k1
> Copyright (c) 2004 Intel Corporation
> 
> PCI:PCIabling device 00:18.0 (0006 -> 0007)
> e100: eth0ethntel(R) PRO/100 Network Connection
> Hardware receive checchecksumsbled
> 
> IP-CIPfConfigiled to open eth0eth 
> what is wrong?
> 
> Best regards
> 
> XiayXiayuu don't have a valid mac address. Try
temptemporarilydhard codingand see what happens...

> 
> 
> 
> 
> 
> 
> 
> _______________________________________________
> LinuLinuxppcedded mailing list
> LinuLinuxppcedded@ozlaozlabs
> httphttpszlaozlabs/mailman/listlistinfoulinuxppcedded
> 


	
		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
