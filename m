Return-Path: <ugundu.bocegi@gmail.com>
Message-ID: <a399f0740804180036n189507cavd34f64891326bac1@mail.gmail.com>
Date: Fri, 18 Apr 2008 10:36:18 +0300
From: ayhan <ugundu.bocegi@gmail.com>
To: Linuxppc-embedded@ozlabs.org
Subject: ppc_4xx uImage - kernel boot problem
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_1475_30366477.1208504178554"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_1475_30366477.1208504178554
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

*Hello,

I have an AMCC 405gp board on which runs u-boot. I try to boot the Linux
Kernel via network but can not. I download uImage using DHCPD/TFTP. Here is
the  minicom console output:*


Type "run flash_nfs" to mount root filesystem over NFS

Hit any key to stop autoboot:  0
ENET Speed is 100 Mbps - FULL duplex connection (EMAC0)
Using ppc_4xx_eth0 device
TFTP from server 192.168.1.210; our IP address is 192.168.1.220
Filename 'uImage'.
Load address: 0x200000
Loading: #################################################################
         ###############
done
Bytes transferred = 1167936 (11d240 hex)
## Booting image at 00200000 ...
   Image Name:   Linux-2.6.25-rc7-00000-ga1ba6f0
   Created:      2008-04-07  12:32:44 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1167872 Bytes =  1.1 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK


*Here the console is frozen. It's the point where u-boot ends up and the
kernel code starts. I think I have a mistake in addressing. I don't have
sufficient knowledge about uImage format and the kernel compilation process.
I followed the steps through the ELDK documantation from DENX software for
cross-compiling the linux kernel as below:     *

      bash$ make mrproper
      bash$ make ARCH=ppc CROSS_COMPILE=ppc_4xx- walnut_defconfig
      bash$ make ARCH=ppc CROSS_COMPILE=ppc_4xx- uImage

*Could anyone help me solving the boot problem?*

------=_Part_1475_30366477.1208504178554
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<b style="font-family: arial,sans-serif;">Hello, <br><br>I have an AMCC 405gp board on which runs u-boot. I try to boot the Linux Kernel via network but can not. I download uImage using DHCPD/TFTP. Here is the&nbsp; minicom console output:</b><br style="font-family: arial,sans-serif;">
<br><br><span style="font-family: courier new,monospace;">Type &quot;run flash_nfs&quot; to mount root filesystem over NFS</span><br style="font-family: courier new,monospace;">
<br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">Hit any key to stop autoboot:&nbsp; 0</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">ENET Speed is 100 Mbps - FULL duplex connection (EMAC0)</span><br style="font-family: courier new,monospace;">

<span style="font-family: courier new,monospace;">Using ppc_4xx_eth0 device</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">TFTP from server <a href="http://192.168.1.210" target="_blank">192.168.1.210</a>; our IP address is <a href="http://192.168.1.220" target="_blank">192.168.1.220</a></span><br style="font-family: courier new,monospace;">

<span style="font-family: courier new,monospace;">Filename &#39;uImage&#39;.</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">Load address: 0x200000</span><br style="font-family: courier new,monospace;">

<span style="font-family: courier new,monospace;">Loading: #################################################################</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ###############</span><br style="font-family: courier new,monospace;">

<span style="font-family: courier new,monospace;">done</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">Bytes transferred = 1167936 (11d240 hex)</span><br style="font-family: courier new,monospace;">

<span style="font-family: courier new,monospace;">## Booting image at 00200000 ...</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Linux-2.6.25-rc7-00000-ga1ba6f0</span><br style="font-family: courier new,monospace;">

<span style="font-family: courier new,monospace;">&nbsp;&nbsp; Created:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2008-04-07&nbsp; 12:32:44 UTC</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip compressed)</span><br style="font-family: courier new,monospace;">

<span style="font-family: courier new,monospace;">&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 1167872 Bytes =&nbsp; 1.1 MB</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp; Load Address: 00000000</span><br style="font-family: courier new,monospace;">

<span style="font-family: courier new,monospace;">&nbsp;&nbsp; Entry Point:&nbsp; 00000000</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp; Verifying Checksum ... OK</span><br style="font-family: courier new,monospace;">

<span style="font-family: courier new,monospace;">&nbsp;&nbsp; Uncompressing Kernel Image ... OK</span><br style="font-family: courier new,monospace;"><br><br><b style="font-family: arial,helvetica,sans-serif;">Here the console is frozen. It&#39;s the point where u-boot ends up and the kernel code starts. I think I have a mistake in addressing. I don&#39;t have sufficient knowledge about uImage format and the kernel compilation process. I followed the steps through the ELDK documantation from DENX software for cross-compiling the linux kernel as below: &nbsp;&nbsp;&nbsp;  </b><br>
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bash$ make mrproper<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bash$ make ARCH=ppc CROSS_COMPILE=ppc_4xx- walnut_defconfig<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bash$ make ARCH=ppc CROSS_COMPILE=ppc_4xx- uImage<br><br><b>Could anyone help me solving the boot problem?</b><br>
<br><br><br>

------=_Part_1475_30366477.1208504178554--
