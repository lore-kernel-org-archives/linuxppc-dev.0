Return-Path: <fodjo@yahoo.com>
Received: from web52605.mail.yahoo.com (web52605.mail.yahoo.com
	[206.190.48.208]) by ozlabs.org (Postfix) with SMTP id 6BAA667B5F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 Aug 2006 23:45:39 +1000 (EST)
Message-ID: <20060831133857.67615.qmail@web52605.mail.yahoo.com>
Date: Thu, 31 Aug 2006 06:38:57 -0700 (PDT)
From: Fodjo Yves-Eric <fodjo@yahoo.com>
Subject: Men em1 MPC5200 kernel don't start using elinos v4.0
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-865822957-1157031537=:65329"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-865822957-1157031537=:65329
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hello 
In the course of my Thesis I have to Port linux on the board EM01 Rev 01.04.02 of Men  using Elinos V4 PPC.  My host system is Linux Fedora Core 5. I'm using the "menem1" as board. The problem is that the kernel doesn't start at all. After loading the file "hello.img" througth bootp the system give the following output and hang. 

Searching for server (BOOTP) .
My IP 192.168.1.10:ffffff00 Server IP 192.168.1.1 GW IP 192.168.1.1
Loading hello.img...
to 0x02000000        861 kB
Loaded 0x000d74e9 bytes
Detected PPCBOOT header
    verifiying image CRC...ok
    Uncompressing Multi-File Image ... ok
    Moving initrd...ok
    passing parameters: devfs=mount rootfstype=tmpfs root=dev/ram rw ip=auto
    Starting Linux Kernel.


I have tried several combination of kernel parameters without success.
Here is a part of my ELINOS.sh config file.

# --- Configuration Settings ------------------------------------------
ELINOS_BOARD="menem1"
export ELINOS_BOARD
ELINOS_CPU="ppc"
export ELINOS_CPU
ELINOS_ARCH="60x"
export ELINOS_ARCH
ELINOS_LIBC="glibc-2.3.4"
export ELINOS_LIBC
ELINOS_BOARD_LINUX_ARCH=""
export ELINOS_BOARD_LINUX_ARCH
ELINOS_DOSNAME="hello"
export ELINOS_DOSNAME
ELINOS_BOOT_STRAT="uboot_multi"
export ELINOS_BOOT_STRAT
ELINOS_KERNELPATH="menem1/linux-2.6.12"
export ELINOS_KERNELPATH
MKIMAGE_LOAD_ADDRESS="00000000"
export MKIMAGE_LOAD_ADDRESS
MKIMAGE_ENTRY_ADDRESS="00000000"
export MKIMAGE_ENTRY_ADDRESS
.
.
ELINOS_VERSION="4.0"

Thanks.
 		
---------------------------------
Stay in the know. Pulse on the new Yahoo.com.  Check it out. 
 		
---------------------------------
Do you Yahoo!?
 Get on board. You're invited to try the new Yahoo! Mail.
--0-865822957-1157031537=:65329
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hello <br>In the course of my Thesis I have to Port linux on the board EM01 Rev 01.04.02 of Men&nbsp; using Elinos V4 PPC.&nbsp; My host system is Linux Fedora Core 5. I'm using the "menem1" as board. The problem is that the kernel doesn't start at all. After loading the file "hello.img" througth bootp the system give the following output and hang. <br><br>Searching for server (BOOTP) .<br>My IP 192.168.1.10:ffffff00 Server IP 192.168.1.1 GW IP 192.168.1.1<br>Loading hello.img...<br>to 0x02000000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 861 kB<br>Loaded 0x000d74e9 bytes<br>Detected PPCBOOT header<br>&nbsp;&nbsp; &nbsp;verifiying image CRC...ok<br>&nbsp;&nbsp; &nbsp;Uncompressing Multi-File Image ... ok<br>&nbsp;&nbsp; &nbsp;Moving initrd...ok<br>&nbsp;&nbsp; &nbsp;passing parameters: devfs=mount rootfstype=tmpfs root=dev/ram rw ip=auto<br>&nbsp;&nbsp; &nbsp;Starting Linux Kernel.<br><br><br>I have tried several combination of kernel parameters without success.<br>Here is a
 part of my ELINOS.sh config file.<br><br># --- Configuration Settings ------------------------------------------<br>ELINOS_BOARD="menem1"<br>export ELINOS_BOARD<br>ELINOS_CPU="ppc"<br>export ELINOS_CPU<br>ELINOS_ARCH="60x"<br>export ELINOS_ARCH<br>ELINOS_LIBC="glibc-2.3.4"<br>export ELINOS_LIBC<br>ELINOS_BOARD_LINUX_ARCH=""<br>export ELINOS_BOARD_LINUX_ARCH<br>ELINOS_DOSNAME="hello"<br>export ELINOS_DOSNAME<br>ELINOS_BOOT_STRAT="uboot_multi"<br>export ELINOS_BOOT_STRAT<br>ELINOS_KERNELPATH="menem1/linux-2.6.12"<br>export ELINOS_KERNELPATH<br>MKIMAGE_LOAD_ADDRESS="00000000"<br>export MKIMAGE_LOAD_ADDRESS<br>MKIMAGE_ENTRY_ADDRESS="00000000"<br>export MKIMAGE_ENTRY_ADDRESS<br>.<br>.<br>ELINOS_VERSION="4.0"<br><br>Thanks.<p> 
		<hr size=1>Stay in the know. Pulse on the new Yahoo.com. <a href="http://us.rd.yahoo.com/evt=42974/*http://www.yahoo.com/preview"> Check it out.</a> <p>&#32;
		<hr size=1>Do you Yahoo!?<br> 
Get on board. <a href="http://us.rd.yahoo.com/evt=40791/*http://advision.webevents.yahoo.com/mailbeta">You're invited</a> to try the new Yahoo! Mail.
--0-865822957-1157031537=:65329--
