Return-Path: <wmaxfield@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.228])
	by ozlabs.org (Postfix) with ESMTP id 4617E67E0F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Dec 2006 03:05:37 +1100 (EST)
Received: by wr-out-0506.google.com with SMTP id 71so248762wri
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Dec 2006 08:05:33 -0800 (PST)
Message-ID: <45a1b53e0612140805p589b5bdfpd4fb3347cdb60ded@mail.gmail.com>
Date: Thu, 14 Dec 2006 10:05:31 -0600
From: "Wade Maxfield" <wmaxfield@gmail.com>
To: ppc <linuxppc-embedded@ozlabs.org>
Subject: system ace programming xf60
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_171298_21818237.1166112331172"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_171298_21818237.1166112331172
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

  We are trying to generate a system ace file that will program an xf60
using Xilinx scripts,
(and even their impact GUI), using 8.1i, service pack 3 EDK.

  Unfortunately, if we choose the ml410 board from Xilinx's genace.tclscript
in their EDK/data/xmd directory, it errors with an invalid instruction
register length.
The irlength is listed as 14 in the xilinx script files.  I looked and
googled and could
not find the irlength listed for that xf60 part in any literature.

  Also, if we try to include the zImage.elf file, the script errors out.

  Conversely, if we choose an ml403 board (and switch the project to the
xf12 chip),
we can combine the zImage.elf file and generate a system.ace file that loads
on an
ml403 board.

  We can take the download.bit file that refuses to load when combined into
the system.ace,
and load it over the jtag port.  It programs the xf60 just fine.

  If we create an empty system.ace file,  the system ace chip on our board
signals everything is ok,
but of course, the xilinx chip is not programmed.  If we pull the compact
flash out of the board,
the system ace chip signals that is can't find the compact flash by flashing
the error light.

  Has anyone on this list had any experience with this that could lead us in
a right direction?  We've
tried about 10 different combinations so far with no luck.

thanks,
wade

------=_Part_171298_21818237.1166112331172
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>&nbsp; We are trying to generate a system ace file that will program an xf60 using Xilinx scripts, <br>(and even their impact GUI), using 8.1i, service pack 3 EDK.<br><br>&nbsp; Unfortunately, if we choose the ml410 board from Xilinx's 
genace.tcl script <br>in their EDK/data/xmd directory, it errors with an invalid instruction register length.<br>The irlength is listed as 14 in the xilinx script files.&nbsp; I looked and googled and could<br>not find the irlength listed for that xf60 part in any literature.
<br><br>&nbsp; Also, if we try to include the zImage.elf file, the script errors out.<br><br>&nbsp; Conversely, if we choose an ml403 board (and switch the project to the xf12 chip), <br>we can combine the zImage.elf file and generate a 
system.ace file that loads on an<br>ml403 board.<br><br>&nbsp; We can take the download.bit file that refuses to load when combined into the system.ace, <br>and load it over the jtag port.&nbsp; It programs the xf60 just fine.<br><br>
&nbsp; If we create an empty system.ace file,&nbsp; the system ace chip on our board signals everything is ok,<br>but of course, the xilinx chip is not programmed.&nbsp; If we pull the compact flash out of the board,<br>the system ace chip signals that is can't find the compact flash by flashing the error light.
<br><br>&nbsp; Has anyone on this list had any experience with this that could lead us in a right direction?&nbsp; We've<br>tried about 10 different combinations so far with no luck.<br><br>thanks,<br>wade<br>

------=_Part_171298_21818237.1166112331172--
