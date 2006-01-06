Return-Path: <zengshuai@sogou.com>
Received: from sogoumx76.mail.sogou.com (unknown [61.135.132.136])
	by ozlabs.org (Postfix) with ESMTP id A4F5A6891D
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  6 Jan 2006 20:03:19 +1100 (EST)
Received: from mx3.mail.sohu.com (unknown [192.168.95.78])
	by sogoumx76.mail.sogou.com (Postfix) with ESMTP id EEE0F0027F37
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  6 Jan 2006 17:03:19 +0800 (CST)
Message-ID: <23894955.1136537390660.JavaMail.postfix@mx3.mail.sohu.com>
Date: Fri, 6 Jan 2006 16:49:50 +0800 (CST)
From: <zengshuai@sogou.com>
To: "ppc" <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Subject: Help need: Porting Linux to PQ2FADS_ZU board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I use ELDK3.1.1(2005-06-07).
There is a u-boot 1.1.3 and a linux 2.4.25 in the eldk.
I has compile u-boot successfully.And it works good.
I has compile kernel successfully too.(make ads8260_config)
But it doesn't work.

Detail:
-------------------------------------------------------------------------
U-Boot 1.1.3 (Dec 27 2005 - 19:35:12)

MPC8260 Reset Status: Check Stop, External Soft, External Hard

MPC8260 Clock Configuration
 - Bus-to-Core Mult 4.5x, VCO Div 2, 60x Bus Freq  22-65 , Core Freq 100-300
 - dfbrg 1, corecnf 0x07, busdf 5, cpmdf 1, plldf 0, pllmf 5
 - vco_out  600000000, scc_clk  150000000, brg_clk   37500000
 - cpu_clk  450000000, cpm_clk  300000000, bus_clk  100000000
 - pci_clk   50000000

CPU:   MPC8260 (HiP7 Rev 13, Mask 0.1 1K49M) at 450 MHz
Board: Motorola PQ2FADS-ZU
DRAM:  32 MB
FLASH:  8 MB
In:    serial
Out:   serial
Err:   serial
Net:   FCC2 ETHERNET
Hit any key to stop autoboot:  0
=> printenv
bootdelay=5
baudrate=115200
ethact=FCC2 ETHERNET
ethaddr=0A:00:00:00:00:0A
gatewayip=172.17.248.1
netmask=255.255.255.0
ipaddr=172.17.248.244
serverip=172.17.248.253
bootcmd=tftp 100000 vmlinux.UBoot; bootm 100000
bootargs=root=/dev/nfs rw nfsroot=172.17.248.253:/opt/eldk3/ppc_6xx ip=172.17.24
8.244:172.17.248.253:172.17.248.253:255.255.255.0:pq2fads::off
stdin=serial
stdout=serial
stderr=serial

Environment size: 398/262140 bytes
=> boot
Using FCC2 ETHERNET device
TFTP from server 172.17.248.253; our IP address is 172.17.248.244
Filename 'vmlinux.UBoot'.
Load address: 0x100000
Loading: #################################################################
         #########################################################
done
Bytes transferred = 623547 (983bb hex)
## Booting image at 00100000 ...
   Image Name:   Linux-2.4.25
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    623483 Bytes = 608.9 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
-----------------------------------------------------------------------------------
At here,it stoped.
Later,I debug the kernel using bdi2000.
I bi start_kernel(),and setp by setp.
But printk(".........) didn't work.

My board is PQ2FADS_ZU.Does the ELDK not support it?


------------------------------
我现在使用Sogou.com的2G邮箱了，你也来试试吧! 
http://mail.sogou.com/recommend/sogoumail_invite_reg1.jsp?from=sogouinvitation&s_EMAIL=zengshuai%40sogou.com&username=linuxppc-embedded&FullName=linuxppc-embedded&Email=linuxppc-embedded%40ozlabs.org&verify=755eff4e640bdcfc57d93cbd8b0a9cb7
