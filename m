Return-Path: <onramp123@yahoo.com>
Received: from n14.bullet.mail.mud.yahoo.com (n14.bullet.mail.mud.yahoo.com
	[68.142.206.41]) by ozlabs.org (Postfix) with SMTP id 5BA8ADE070
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Jan 2009 11:37:49 +1100 (EST)
From: "Steve DeLaney" <onramp123@yahoo.com>
To: "'Leon Woestenberg'" <leon.woestenberg@gmail.com>,
	"'Linux PPC'" <linuxppc-dev@ozlabs.org>
Subject: RE: 2.6.28 does not boot on MPC8315E-RDB, or...?
Date: Sat, 3 Jan 2009 16:33:42 -0800
Message-ID: <008601c96e04$18b74bc0$6b03a8c0@sdelaney2>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <c384c5ea0901031458j74d74ba3y359831fff9716d07@mail.gmail.com>
Reply-To: onramp123@yahoo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


we are booting 2.6.26 on MPC8349-MITXE
do you need a device tree?  this can be tftp loaded, or flashed in the board
and
cp.b from flash to ram before booting. 

-----Original Message-----
From: linuxppc-dev-bounces+onramp123=yahoo.com@ozlabs.org
[mailto:linuxppc-dev-bounces+onramp123=yahoo.com@ozlabs.org] On Behalf Of
Leon Woestenberg
Sent: Saturday, January 03, 2009 2:58 PM
To: Linux PPC
Subject: 2.6.28 does not boot on MPC8315E-RDB, or...?

Hello,

I cannot get my 2.6.28 kernel to boot. The board resets after u-boot starts
the kernel.

I would like to verify if someone got it booting already?

Regards,

Leon.


TFTP from server 192.168.1.24; our IP address is 192.168.1.15 Filename
'uImage-mpc8315e-rdb.bin'.
Load address: 0x400000
Loading: T #################################################################
         #################################################################
         #########
done
Bytes transferred = 2033899 (1f08eb hex)
Speed: 1000, full duplex
Using eTSEC0 device
TFTP from server 192.168.1.24; our IP address is 192.168.1.15 Filename
'uImage-mpc8315e-rdb.dtb'.
Load address: 0x700000
Loading: #
done
Bytes transferred = 12288 (3000 hex)
## Booting image at 00400000 ...
   Image Name:   Angstrom/2.6.28/mpc8315e-rdb
   Created:      2009-01-03  22:44:25 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    2033835 Bytes =  1.9 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
   Booting using the fdt at 0x700000


U-Boot 1.3.0-rc2 (Oct  7 2008 - 11:57:25) MPC83XX



--
Leon
_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
