Return-Path: <urwithsudheer@gmail.com>
Received: from gdatech.co.in (mail.gdatech.co.in [202.144.30.226])
	by ozlabs.org (Postfix) with ESMTP id 8CEEB67B32
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  7 Aug 2006 19:35:56 +1000 (EST)
Received: from [192.168.0.2] (localhost.localdomain [127.0.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id 1FBB38780A3
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  7 Aug 2006 02:35:54 -0700 (PDT)
Received: from gdatech.co.in ([192.168.0.3])
	by [127.0.0.1] ([127.0.0.1]) (port 7027) (Abaca EPG outproxy filter
	1.3.4.5154-maint13 $Rev: 5154 $) id r687023554D-00-2
	for linuxppc-embedded@ozlabs.org; Mon, 07 Aug 2006 02:35:54 -0700
Received: from mail.gdatech.co.in (unknown [192.168.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id EE51B87809F
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  7 Aug 2006 02:35:53 -0700 (PDT)
Message-ID: <44D7097C.7040907@gmail.com>
Date: Mon, 07 Aug 2006 15:05:56 +0530
From: urwithsudheer <urwithsudheer@gmail.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: regarding pci  vga card output with powerpc
Content-Type: multipart/alternative;
	boundary="------------060006050206080006030205"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060006050206080006030205
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello All,
I am working with a pci based vga card. I have connected the vga card 
next to the  pci slot of my target processor on the baseboard.
I have connected a monitor to the vga card.
When i boot linux from minicom, i could see all the kernel log messages 
on both the minicom and vga card monitor. But on the vga monitor, i 
could not see any messages after asking for login as below:
.
.

Mounting filesystems
Running depmod
Setting up networking on loopback device:
Setting up networking on eth0:
eth0: PHY is Marvell 88E11x1 (1410cc2)
Adding static route for default gateway to 192.168.3.1:
Setting nameserver to 192.168.0.1 in /etc/resolv.conf:
Starting inetd:

login:


Though i am entering my login and passwd at the minicom, nothing comes 
on to the vga monitor. But i am able to write to vga monitor using the 
following commands from minicom:

# echo "Hello" > /dev/tty1
# echo "Hi " > /dev/tty1
My requirement is to get on the vga monitor whatever i am typing on the 
minicom after logging into the linux like .
ls or pwd commands.

Anyone pl help me.

Thanks & Regards
Sudheer





--------------060006050206080006030205
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Hello All,<br>
I am working with a pci based vga card. I have connected the vga card
next to the&nbsp; pci slot of my target processor on the baseboard. <br>
I have connected a monitor to the vga card.<br>
When i boot linux from minicom, i could see all the kernel log messages
on both the minicom and vga card monitor. But on the vga monitor, i
could not see any messages after asking for login as below:<br>
.<br>
.<br>
<br>
Mounting filesystems<br>
Running depmod<br>
Setting up networking on loopback device:<br>
Setting up networking on eth0:<br>
eth0: PHY is Marvell 88E11x1 (1410cc2)<br>
Adding static route for default gateway to 192.168.3.1:<br>
Setting nameserver to 192.168.0.1 in /etc/resolv.conf:<br>
Starting inetd:<br>
<br>
login: <br>
<br>
<br>
Though i am entering my login and passwd at the minicom, nothing comes
on to the vga monitor. But i am able to write to vga monitor using the
following commands from minicom:<br>
<br>
<font color="#800000"># echo "Hello" &gt; /dev/tty1</font><br>
<font color="#800000"># echo "Hi " &gt; /dev/tty1<br>
<font color="#000000">My requirement is to get on the vga monitor
whatever i am typing on the minicom after logging into the linux like .<br>
</font></font><font color="#800000"><font color="#000000">ls or pwd
commands.<br>
<br>
Anyone pl help me.<br>
<br>
Thanks &amp; Regards<br>
Sudheer<br>
</font><br>
</font><br>
<br>
<br>
</body>
</html>

--------------060006050206080006030205--
