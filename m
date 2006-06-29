Return-Path: <jasonal00@googlemail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id A922067AA0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Jun 2006 01:20:31 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id j3so178608ugf
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Jun 2006 08:20:29 -0700 (PDT)
Message-ID: <b4ebaa9d0606290820y4dce2ce2x8d28007b1d591eef@mail.gmail.com>
Date: Thu, 29 Jun 2006 17:20:29 +0200
From: "Qichen Huang" <jasonal00@googlemail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Problem with Xilinx Uart Lite
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_56883_25050329.1151594429640"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_56883_25050329.1151594429640
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

I'm trying to port linuxppc_2_4_devel to Xilinx ML403. I want to use
UartLite instead of Uart 16550. What changes should I do?

I have disabled "Standard/generic (8250/16550 and compatible UARTs) serial
support"
and enabled "Xilinx UART Lite" & "Console on UART Lite port" in character
devices.
And the initial kernel command string is changed to "console=ttl0
console=ttyS0,9600 ip=off root=/dev/xsysace/disc0/part3 rw".

The kernel boot log dosen't mention any serial device and it hangs up until
"System started." There is no login prompt.

My /etc/inittab is :

::sysinit:/etc/init.d/rcS
#::askfirst:-/bin/sh
::ctrlaltdel:/sbin/reboot
::shutdown:/sbin/swapoff -a
::shutdown:/bin/umount -a -r
::restart:/sbin/init
::respawn:/sbin/getty 9600 tts/0


What else should I do?
Thank you!

Qichen

------=_Part_56883_25050329.1151594429640
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div id="mb_0"><div>Hi all,<br><br>I'm trying to port linuxppc_2_4_devel to Xilinx ML403. I want to use UartLite instead of Uart 16550. What changes should I do?<br><br>I have disabled &quot;Standard/generic (8250/16550 and compatible UARTs) serial support&quot;
<br>and enabled &quot;Xilinx UART Lite&quot; &amp; &quot;Console on UART Lite port&quot; in character devices.<br>And the initial kernel command string is changed to &quot;console=ttl0 console=ttyS0,9600 ip=off root=/dev/xsysace/disc0/part3 rw&quot;.
<br><br>The kernel boot log dosen't mention any serial device and it hangs up until &quot;System started.&quot; There is no login prompt. <br><br>My /etc/inittab is :<br><br>::sysinit:/etc/init.d/rcS<br>#::askfirst:-/bin/sh
<br>::ctrlaltdel:/sbin/reboot<br>::shutdown:/sbin/swapoff -a<br>::shutdown:/bin/umount -a -r<br>::restart:/sbin/init<br>::respawn:/sbin/getty 9600 tts/0<br><br><br>What else should I do?<br>Thank you!<br></div><div><span class="sg">
<br>Qichen<br>

</span></div></div>

------=_Part_56883_25050329.1151594429640--
