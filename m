Return-Path: <guojin02@tsinghua.org.cn>
Received: from tsinghua.org.cn (mail.tsinghua.org.cn [210.77.143.232])
	by ozlabs.org (Postfix) with SMTP id 6F52CDDE17
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 18 May 2008 08:06:53 +1000 (EST)
Message-ID: <411060595.08932@tsinghua.org.cn>
From: "=?gb2312?B?ufm+og==?=" <guojin02@tsinghua.org.cn>
To: linuxppc-embedded@ozlabs.org, u-boot-users@lists.sourceforge.net
Date: Sun, 18 May 2008 05:43:15 +0800
Subject: Why the flash always say "flash not erased" in u-boot?
Content-Type: text/plain
Reply-To: =?gb2312?B?ufm+og==?= <guojin02@tsinghua.org.cn>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,friends,


I made two boards of MPC8360E with u-boot-1.3.0, the hardware on the board is the
same and the version of u-boot is also the same. One of the board is OK for erase
and cp.b command in u-boot,I can tftp the uImage,ramdisk,dtb,cfg.jffs2 to DDR,
then I used the cp.b command to write those file to flash, before the cp.b
command, I used the erase command to erase the flash first. But the second board
always told me"copy to flash ... flash not erased" when I used the cp.b command. I
used the "protect off all" command, I am sure that the erase command before cp.b
command is no problem. 
Even the cp.b command not work, the setenv command is always no problem, the new
parameter built by setenv can write to flash by saveenv. The USBTAP also can write
the file to flash. Why just only cp.b command not work? How can I make the flash
does not say "flash not erased"? 


Thanks.
