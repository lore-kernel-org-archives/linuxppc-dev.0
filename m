Return-Path: <bharthik2004@yahoo.com>
Received: from web50010.mail.yahoo.com (web50010.mail.yahoo.com
	[206.190.38.25]) by ozlabs.org (Postfix) with SMTP id BFFDA689D9
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Feb 2006 19:24:21 +1100 (EST)
Message-ID: <20060201082419.53038.qmail@web50010.mail.yahoo.com>
Date: Wed, 1 Feb 2006 00:24:19 -0800 (PST)
From: bharathi kandimalla <bharthik2004@yahoo.com>
Subject: opening the serial port from userspace application
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1881560752-1138782259=:52554"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1881560752-1138782259=:52554
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi
I am able to  use the serialport uart drivers  for the custom board with mpc860T 
 which are available in the kernel 2.6.13  
I am getting bootup messages like this
  ttyCPM0 at MMIO 0xfb000a80 (irq = 20) is a CPM UART
ttyCPM1 at MMIO 0xfb000a90 (irq = 19) is a CPM UART
ttyCPM2 at MMIO 0xfb000a00 (irq = 46) is a CPM UART
ttyCPM3 at MMIO 0xfb000a20 (irq = 45) is a CPM UART  
   And after getting prompt
cd /proc/dev/     
cat drivers
/dev/tty             /dev/tty        5       0 system:/dev/tty
/dev/console         /dev/console    5       1 system:console
/dev/ptmx            /dev/ptmx       5       2 system
ttyCPM               /dev/ttyCPM   204 46-49 serial
pty_slave            /dev/pts      136 0-1048575 pty:slave
pty_master           /dev/ptm      128 0-1048575 pty:master 
  I am  using mknod command 
mknod /dev/ttyCPM0 c 204 46 
    ln -sf  console ttyCPM0 
mknod /dev/ttyCPM1 c 204 47
mknod /dev/ttyCPM2 c 204 48
mknod /dev/ttyCPM3 c 204 49  
  even I am not able to open the device from the user space application
  I want to write some data from the user space into the
application
But I am not able to open the device
  please help me out
regards
Bharathi 
                                                                 
  
 

		
---------------------------------
 
 What are the most popular cars? Find out at Yahoo! Autos 
--0-1881560752-1138782259=:52554
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<DIV id=RTEContent>Hi<BR>I am able to&nbsp; use the serialport uart drivers&nbsp; for the custom board with mpc860T <BR>&nbsp;which are available in the kernel 2.6.13&nbsp; <BR>I am getting bootup messages like this</DIV>  <DIV id=RTEContent>ttyCPM0 at MMIO 0xfb000a80 (irq = 20) is a CPM UART<BR>ttyCPM1 at MMIO 0xfb000a90 (irq = 19) is a CPM UART<BR>ttyCPM2 at MMIO 0xfb000a00 (irq = 46) is a CPM UART<BR>ttyCPM3 at MMIO 0xfb000a20 (irq = 45) is a CPM UART&nbsp; </DIV>  <DIV id=RTEContent>&nbsp;And after getting prompt<BR>cd /proc/dev/&nbsp;&nbsp;&nbsp;&nbsp; <BR>cat drivers<BR>/dev/tty&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /dev/tty&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 system:/dev/tty<BR>/dev/console&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /dev/console&nbsp;&nbsp;&nbsp; 5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1
 system:console<BR>/dev/ptmx&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /dev/ptmx&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2 system<BR>ttyCPM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /dev/ttyCPM&nbsp;&nbsp; 204 46-49 serial<BR>pty_slave&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /dev/pts&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 136 0-1048575 pty:slave<BR>pty_master&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /dev/ptm&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 128 0-1048575 pty:master </DIV>  <DIV>I am&nbsp; using mknod command <BR>mknod /dev/ttyCPM0 c 204 46&nbsp;</DIV>  <DIV>&nbsp; ln -sf&nbsp; console ttyCPM0 <BR>mknod /dev/ttyCPM1 c 204 47<BR>mknod /dev/ttyCPM2 c 204 48<BR>mknod /dev/ttyCPM3 c 204 49&nbsp; <BR>&nbsp; even I am not able to open the device from the user space application</DIV>  <DIV id=RTEContent>I want to write some data from the user space into
 the<BR>application<BR>But I am not able to open the device</DIV>  <DIV id=RTEContent>please help me out<BR>regards<BR>Bharathi <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </DIV>  <DIV id=RTEContent><BR>&nbsp;</DIV><p>
		<hr size=1> <BR> 
What are the most popular cars? Find out at <a href="http://us.rd.yahoo.com/evt=38382/_ylc=X3oDMTEzNWFva2Y2BF9TAzk3MTA3MDc2BHNlYwNtYWlsdGFncwRzbGsDMmF1dG9z/*http://autos.yahoo.com/newcars/popular/thisweek.html 
">Yahoo! Autos</a> 
--0-1881560752-1138782259=:52554--
