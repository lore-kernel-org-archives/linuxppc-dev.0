Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc2-s18.bay0.hotmail.com (bay0-omc2-s18.bay0.hotmail.com
	[65.54.246.154]) by ozlabs.org (Postfix) with ESMTP id 9F4DBDDDE6
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Nov 2008 23:51:05 +1100 (EST)
Message-ID: <BAY122-W103A807EA57278DF7F6251B2130@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_28102e5b-9076-4b60-9202-5276acf0cc16_"
From: MingLiu <eemingliu@hotmail.com>
To: <joaquin.luna@jdsu.com>, <linuxppc-embedded@ozlabs.org>
Subject: RE: command line partition information
Date: Mon, 17 Nov 2008 12:45:17 +0000
In-Reply-To: <DF6C7BC3780EE44B83430A9F756D43B608581D77@SJEXCH03.ds.jdsu.net>
References: <DF6C7BC3780EE44B83430A9F756D43B608581D77@SJEXCH03.ds.jdsu.net>
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--_28102e5b-9076-4b60-9202-5276acf0cc16_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hello,
I had the same problem when I use 2.6.27-rc9 with Intel p33 NOR flash memory. My command line is "root=/dev/nfs ip=192.168.0.4:192.168.0.3:192.168.0.3:255.255.255.0 rw nfsroot=192.168.0.3:/home/mingliu/ml403_rootfs console=ttyUL0,9600 mem=64M mtdparts=Intel:5M(kernel),2M(others),-(bitstream)". However the command line partition could not be parsed and there is still only one partition when I boot the kernel. 
 
Are there any persons who manage to use the command line partition option for flash memory? Please give us some hints. Thanks a lot. 
 
BR
Ming



Subject: command line partition informationDate: Sun, 16 Nov 2008 15:43:40 -0800From: Joaquin.Luna@jdsu.comTo: linuxppc-embedded@ozlabs.org





Hello Linux powerpc community,
 
I am trying to move from 2.6.20 kernel to the new 2.6.27.4 kernel.  I am not finding my root file system partition with the new kernel.  I am not sure if I need to change my dts file, or if the problem is some where in my kernel config.  In either case, it is evident from the boot log that my partition table is not being used.  Where it says “[    0.917162] List of all partitions:" it just lists the entire size of my flash, and none of the partitions listed in the command line.
I do not list any partitions in my dts file, though I tried and not seen any change in the behavior.  I have enabled the option in the kernel to parse the partition information from the kernel command line, is there something else I need to do to set up the mtdblockX devices?
 
Boot Command:
 
mtdparts=mtdparts=nand0:2m(u-boot),3M(kernel),128K(dtb),30M(jffs2),32M(mycust),90M(myfs),90M(myfs2)
mtd_args=setenv bootargs root=/dev/mtdblock3 rw rootfstype=jffs2 $mtdparts console=ttyS1,115200
 
Boot Log: 
 
[    0.825229] brd: module loaded
[    0.837681] loop: module loaded
[    0.841404] Driver 'sd' needs updating - please use bus_type methods
[    0.850005] NAND device: Manufacturer ID: 0x2c, Chip ID: 0xda (Micron NAND 256MiB 3,3V 8-bit)
[    0.859783] Bad block table found at page 131008, version 0x01
[    0.867779] Bad block table found at page 130944, version 0x01
[    0.875443] RedBoot partition parsing not available
[    0.884431] eLBC NAND device at 0xff800000, bank 0
[    0.890643] i2c /dev entries driver
[    0.899633] Driver for 1-wire Dallas network protocol.
[    0.910115] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[    0.917162] List of all partitions:
[    0.920856] 1f00     262144 mtdblock0 (driver?)
[    0.925466] No filesystem could mount root, tried:  jffs2
[    0.930952] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
[    0.939294] Rebooting in 180 seconds..
 
 
 
Thanks to all who can help,
Joaquin Luna
_________________________________________________________________
MSN资讯快递，帮助你第一时间了解最新资讯！
http://im.live.cn/newsexpress
--_28102e5b-9076-4b60-9202-5276acf0cc16_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: 8bit

<html>
<head>
<style>
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
font-size: 10pt;
font-family:Verdana
}
</style>
</head>
<body class='hmmessage'>
Hello,<BR>
I had the same problem when I use 2.6.27-rc9 with Intel p33 NOR flash memory. My command line is "root=/dev/nfs ip=192.168.0.4:192.168.0.3:192.168.0.3:255.255.255.0 rw nfsroot=192.168.0.3:/home/mingliu/ml403_rootfs console=ttyUL0,9600 mem=64M mtdparts=Intel:5M(kernel),2M(others),-(bitstream)". However the command line partition could not be parsed and there is still only one partition when I boot the kernel. <BR>
&nbsp;<BR>
Are there any persons who manage to use the command line partition option for flash memory? Please give us some hints. Thanks a lot. <BR>
&nbsp;<BR>
BR<BR>
Ming<BR><BR><BR>

<HR id=stopSpelling>
<BR>
Subject: command line partition information<BR>Date: Sun, 16 Nov 2008 15:43:40 -0800<BR>From: Joaquin.Luna@jdsu.com<BR>To: linuxppc-embedded@ozlabs.org<BR><BR><BR>
<STYLE>
</STYLE>

<STYLE>
.ExternalClass p.EC_MsoNormal, .ExternalClass li.EC_MsoNormal, .ExternalClass div.EC_MsoNormal
{margin-bottom:.0001pt;font-size:12.0pt;font-family:'Times New Roman';}
.ExternalClass a:link, .ExternalClass span.EC_MsoHyperlink
{color:blue;text-decoration:underline;}
.ExternalClass a:visited, .ExternalClass span.EC_MsoHyperlinkFollowed
{color:purple;text-decoration:underline;}
.ExternalClass span.EC_EmailStyle17
{font-family:Arial;color:windowtext;}
@page Section1
{size:8.5in 11.0in;}
.ExternalClass div.EC_Section1
{page:Section1;}
</STYLE>

<DIV class=EC_Section1>
<P class=EC_MsoNormal><FONT face=Arial size=2><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">Hello Linux powerpc community,</SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face=Arial size=2><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp;</SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face=Arial size=2><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">I am trying to move from 2.6.20 kernel to the new 2.6.27.4 kernel.&nbsp; I am not finding my root file system partition with the new kernel.&nbsp; I am not sure if I need to change my dts file, or if the problem is some where in my kernel config.&nbsp; In either case, it is evident from the boot log that my partition table is not being used.&nbsp; Where it says “[&nbsp;&nbsp;&nbsp; 0.917162] List of all partitions:" it just lists the entire size of my flash, and none of the partitions listed in the command line.</SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face=Arial size=2><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">I do not list any partitions in my dts file, though I tried and not seen any change in the behavior.&nbsp; I have enabled the option in the kernel to parse the partition information from the kernel command line, is there something else I need to do to set up the mtdblockX devices?</SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face=Arial size=2><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp;</SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face=Arial size=2><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">Boot Command:</SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face=Arial size=2><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp;</SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face=Arial size=2><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">mtdparts=mtdparts=nand0:2m(u-boot),3M(kernel),128K(dtb),30M(jffs2),32M(mycust),90M(myfs),90M(myfs2)</SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face=Arial size=2><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">mtd_args=setenv bootargs root=/dev/mtdblock3 rw rootfstype=jffs2 $mtdparts console=ttyS1,115200</SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face=Arial size=2><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp;</SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face=Arial size=2><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">Boot Log: </SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face=Arial size=2><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp;</SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face=Arial size=2><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">[&nbsp;&nbsp;&nbsp; 0.825229] brd: module loaded</SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face=Arial size=2><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">[&nbsp;&nbsp;&nbsp; 0.837681] loop: module loaded</SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face=Arial size=2><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">[&nbsp;&nbsp;&nbsp; 0.841404] Driver 'sd' needs updating - please use bus_type methods</SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face=Arial size=2><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">[&nbsp;&nbsp;&nbsp; 0.850005] NAND device: Manufacturer ID: 0x2c, Chip ID: 0xda (Micron NAND 256MiB 3,3V 8-bit)</SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face=Arial size=2><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">[&nbsp;&nbsp;&nbsp; 0.859783] Bad block table found at page 131008, version 0x01</SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face=Arial size=2><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">[&nbsp;&nbsp;&nbsp; 0.867779] Bad block table found at page 130944, version 0x01</SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face=Arial size=2><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">[&nbsp;&nbsp;&nbsp; 0.875443] RedBoot partition parsing not available</SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face=Arial size=2><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">[&nbsp;&nbsp;&nbsp; 0.884431] eLBC NAND device at 0xff800000, bank 0</SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face=Arial size=2><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">[&nbsp;&nbsp;&nbsp; 0.890643] i2c /dev entries driver</SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face=Arial size=2><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">[&nbsp;&nbsp;&nbsp; 0.899633] Driver for 1-wire Dallas network protocol.</SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face=Arial size=2><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">[&nbsp;&nbsp;&nbsp; 0.910115] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)</SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face=Arial size=2><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">[&nbsp;&nbsp;&nbsp; 0.917162] List of all partitions:</SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face=Arial size=2><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">[&nbsp;&nbsp;&nbsp; 0.920856] 1f00&nbsp;&nbsp;&nbsp;&nbsp; 262144 mtdblock0 (driver?)</SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face=Arial size=2><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">[&nbsp;&nbsp;&nbsp; 0.925466] No filesystem could mount root, tried:&nbsp; jffs2</SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face=Arial size=2><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">[&nbsp;&nbsp;&nbsp; 0.930952] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)</SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face=Arial size=2><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">[&nbsp;&nbsp;&nbsp; 0.939294] Rebooting in 180 seconds..</SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face=Arial size=2><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp;</SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face=Arial size=2><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp;</SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face=Arial size=2><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">&nbsp;</SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face=Arial size=2><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">Thanks to all who can help,</SPAN></FONT></P>
<P class=EC_MsoNormal><FONT face=Arial size=2><SPAN style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">Joaquin Luna</SPAN></FONT></P></DIV><br /><hr />使用新一代 Windows Live Messenger 轻松交流和共享！ <a href='http://im.live.cn/' target='_new'>立刻下载！</a></body>
</html>
--_28102e5b-9076-4b60-9202-5276acf0cc16_--
