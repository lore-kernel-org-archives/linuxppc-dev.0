Return-Path: <jiehanca@yahoo.com.cn>
Received: from web15105.mail.cnb.yahoo.com (web15105.mail.cnb.yahoo.com
	[202.165.103.74]) by ozlabs.org (Postfix) with SMTP id 166A8DE2CE
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 May 2008 04:29:08 +1000 (EST)
Date: Thu, 22 May 2008 02:22:26 +0800 (CST)
From: jie han <jiehanca@yahoo.com.cn>
Subject: Help to setup  non-zero PPC_MEMSTART on PPC440
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1897498678-1211394146=:91590"
Message-ID: <702557.91590.qm@web15105.mail.cnb.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1897498678-1211394146=:91590
Content-Type: text/plain; charset=us-ascii

Hi 
I have a custom embedded system with a 440GP derived CPU that places the
memory starting at 0x10000000 which requires a non-zero PPC_MEMSTART.
I use denx linux kernel version is 2.6.24-rc8.build ARCH=powerpc. 
I set PPC_MEMSTART = 0x10000000(include/asm-powerpc/page_32.h)
I get boot linux message as follow:
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 128k init
init has generated signal 4 but has no handler for it
kernel panic - no syncing: Attempted to kill init!
Rebooting in 180 seconds..

How do I fix it?Do I miss anything?Thanks for your help ahead.

Sincerely,

Jie



      
--0-1897498678-1211394146=:91590
Content-Type: text/html; charset=us-ascii

<html><head><style type="text/css"><!-- DIV {margin:0px;} --></style></head><body><div style="font-family:times new roman, new york, times, serif;font-size:12pt"><pre class="content">Hi <br>I have a custom embedded system with a 440GP derived CPU that places the<br>memory starting at 0x10000000 which requires a non-zero PPC_MEMSTART.<br>I use denx linux kernel version is 2.6.24-rc8.build ARCH=powerpc. <br>I set PPC_MEMSTART = 0x10000000(include/asm-powerpc/page_32.h)<br>I get boot linux message as follow:<br>RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize<br>RAMDISK: Compressed image found at block 0<br>VFS: Mounted root (ext2 filesystem) readonly.<br>Freeing unused kernel memory: 128k init<br>init has generated signal 4 but has no handler for it<br>kernel panic - no syncing: Attempted to kill init!<br>Rebooting in 180 seconds..<br><br>How do I fix it?Do I miss anything?Thanks for your help
 ahead.<br><br>Sincerely,<br><br>Jie<br></pre></div><br>

      </body></html>
--0-1897498678-1211394146=:91590--
