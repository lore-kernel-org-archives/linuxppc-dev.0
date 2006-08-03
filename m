Return-Path: <sshebbar@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.176])
	by ozlabs.org (Postfix) with ESMTP id 60C07679E7
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Aug 2006 01:31:34 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id d42so2121114pyd
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 03 Aug 2006 08:31:33 -0700 (PDT)
From: Srinivasa Hebbar <sshebbar@gmail.com>
To: linuxppc-embedded@ozlabs.org,
 sshebbar@gmail.com
Subject: USB problem on MPC8349 (MPH0-ULPI)
References: <DD0740E2135CA545B541AC5F60170AB4F56867@az33exm21.fsl.freescale.net>
In-Reply-To: <DD0740E2135CA545B541AC5F60170AB4F56867@az33exm21.fsl.freescale.net>
MIME-Version: 1.0
Date: Thu, 3 Aug 2006 21:01:23 +0530
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200608032101.23547.sshebbar@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hello,

On MPC8349 sys board, I am getting following error when
I connect the USB mass storage device. 

I am using MPH0 in ULPI mode.

The driver doesn't detect any USB device.

Any help to solve this problem is appreciated.

The configuration and details of the board is given at
the end of this mail.


an  1 00:01:18 eq2210 user.debug kernel: fsl-usb2-mph fsl-usb2-mph1: irq status 0004 PCD
Jan  1 00:01:18 eq2210 user.debug kernel: hub 1-0:1.0: state 5 ports 2 chg 0000 evt 0002
Jan  1 00:01:18 eq2210 user.debug kernel: fsl-usb2-mph fsl-usb2-mph1: GetStatus port 1 status 80001803 POWER sig=j  CSC CONNECT
Jan  1 00:01:18 eq2210 user.debug kernel: hub 1-0:1.0: port 1, status 0501, change 0001, 480 Mb/s
Jan  1 00:01:18 eq2210 user.debug kernel: fsl-usb2-mph fsl-usb2-mph1: GetStatus port 1 status 80001801 POWER sig=j  CONNECT
Jan  1 00:01:18 eq2210 user.debug kernel: fsl-usb2-mph fsl-usb2-mph1: GetStatus port 1 status 80001801 POWER sig=j  CONNECT
Jan  1 00:01:18 eq2210 user.debug kernel: fsl-usb2-mph fsl-usb2-mph1: GetStatus port 1 status 80001801 POWER sig=j  CONNECT
Jan  1 00:01:18 eq2210 user.debug kernel: fsl-usb2-mph fsl-usb2-mph1: GetStatus port 1 status 80001801 POWER sig=j  CONNECT
Jan  1 00:01:18 eq2210 user.debug kernel: fsl-usb2-mph fsl-usb2-mph1: GetStatus port 1 status 80001801 POWER sig=j  CONNECT
Jan  1 00:01:18 eq2210 user.debug kernel: hub 1-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x501
Jan  1 00:01:18 eq2210 user.debug kernel: fsl-usb2-mph fsl-usb2-mph1: port 1 reset
Jan  1 00:01:18 eq2210 user.debug kernel: fsl-usb2-mph fsl-usb2-mph1: port 1 high speed
Jan  1 00:01:18 eq2210 user.debug kernel: fsl-usb2-mph fsl-usb2-mph1: GetStatus port 1 status 88001205 POWER sig=se0  PE CONNECT
Jan  1 00:01:18 eq2210 user.debug kernel: fsl-usb2-mph fsl-usb2-mph1: irq status 0004 PCD
Jan  1 00:01:18 eq2210 user.info kernel: usb 1-1: new high speed USB device using fsl-usb2-mph and address 2
Jan  1 00:01:18 eq2210 user.debug kernel: fsl-usb2-mph fsl-usb2-mph1: irq status 0001 INT
Jan  1 00:01:18 eq2210 user.warn kernel: USB_REQ_GET_DESCRIPTOR: retval=18
Jan  1 00:01:18 eq2210 user.debug kernel: fsl-usb2-mph fsl-usb2-mph1: irq status 0001 INT
Jan  1 00:01:18 eq2210 user.warn kernel: USB_REQ_GET_DESCRIPTOR: retval=18
Jan  1 00:01:18 eq2210 user.debug kernel: fsl-usb2-mph fsl-usb2-mph1: irq status 0001 INT
Jan  1 00:01:18 eq2210 user.debug kernel: fsl-usb2-mph fsl-usb2-mph1: irq status 0020 IAA
Jan  1 00:01:18 eq2210 user.warn kernel: USB_REQ_GET_DESCRIPTOR: retval=18
Jan  1 00:01:18 eq2210 user.warn kernel: bMaxPacketSize0=64
Jan  1 00:01:18 eq2210 user.debug kernel: fsl-usb2-mph fsl-usb2-mph1: port 1 reset
Jan  1 00:01:19 eq2210 user.debug kernel: fsl-usb2-mph fsl-usb2-mph1: port 1 high speed
Jan  1 00:01:19 eq2210 user.debug kernel: fsl-usb2-mph fsl-usb2-mph1: GetStatus port 1 status 88001205 POWER sig=se0  PE CONNECT
Jan  1 00:01:19 eq2210 user.debug kernel: fsl-usb2-mph fsl-usb2-mph1: irq status 0004 PCD
Jan  1 00:01:19 eq2210 user.debug kernel: fsl-usb2-mph fsl-usb2-mph1: irq status 0001 INT
Jan  1 00:01:19 eq2210 user.debug kernel: fsl-usb2-mph fsl-usb2-mph1: irq status 0020 IAA
Jan  1 00:01:20 eq2210 user.debug kernel: fsl-usb2-mph fsl-usb2-mph1: irq status 0013 FATAL ERR INT
Jan  1 00:01:20 eq2210 user.debug kernel: fsl-usb2-mph fsl-usb2-mph1: fatal command 010028 (park)=0 ithresh=1 Async period=256 HALT
Jan  1 00:01:20 eq2210 user.debug kernel: fsl-usb2-mph fsl-usb2-mph1: fatal status 9088 Async Halt FLR
Jan  1 00:01:20 eq2210 user.debug kernel: fsl-usb2-mph fsl-usb2-mph1: fatal error
Jan  1 00:01:20 eq2210 user.debug kernel: fsl-usb2-mph fsl-usb2-mph1: reset command 01002a (park)=0 ithresh=1 Async period=256 Reset HALT
Jan  1 00:01:20 eq2210 user.warn kernel: usb_reset: portsc=0x8C001000
Jan  1 00:01:20 eq2210 user.warn kernel: usb_reset: cfgflag=0x00000001
Jan  1 00:01:20 eq2210 user.err kernel: fsl-usb2-mph fsl-usb2-mph1: HC died; cleaning up
Jan  1 00:01:20 eq2210 user.err kernel: usb 1-1: device descriptor read/all, error -108
Jan  1 00:01:20 eq2210 user.err kernel: hub 1-0:1.0: cannot disable port 1 (err = -19)
Jan  1 00:01:20 eq2210 user.err kernel: hub 1-0:1.0: cannot reset port 1 (err = -19)
Jan  1 00:01:20 eq2210 user.err kernel: hub 1-0:1.0: cannot disable port 1 (err = -19)
Jan  1 00:01:20 eq2210 user.err kernel: hub 1-0:1.0: cannot disable port 1 (err = -19)



>
> Operating System: Linux 2.6.11 (Freescale BSP downloaded from
> metrowerks/freescale website).
>
> Details are below:
> #
> # Freescale 83xx options
> #
> CONFIG_MPC834x_SYS=y
> CONFIG_MPC834x=y
> CONFIG_FSL_USB20=y
> # CONFIG_USB_OTG is not set
>
> #
> # USB20 Host Configuration
> #
> CONFIG_MPH_USB_SUPPORT=y
> # CONFIG_DR_USB_SUPPORT is not set
> CONFIG_MPH0_USB_ENABLE=y
> CONFIG_MPH0_ULPI=y
> # CONFIG_MPH0_SERIAL is not set
> # CONFIG_MPH1_USB_ENABLE is not set
> # CONFIG_DR_ULPI is not set
> # CONFIG_DR_SERIAL is not set
> # CONFIG_DR_UTMI is not set
> CONFIG_PPC_STD_MMU=y
>
> / # cat /proc/cpuinfo
> processor       : 0
> cpu             : e300
> revision        : 1.1 (pvr 8083 0011)
> bogomips        : 351.23
> chip            : MPC8349
> Vendor          : Freescale Inc.
> Machine         : mpc8349 sys
> core clock      : 528 MHz
> bus  clock      : 264 MHz
> PVR             : 0x80830011
> SVR             : 0x80510011
> PLL setting     : 0x8
> Memory          : 512 MB


Thanks,
Hebbar
