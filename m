Return-Path: <bennett78@digis.net>
Received: from mercury.testsyseng.com (unknown [209.120.144.205])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8D4C268869
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Dec 2005 11:30:36 +1100 (EST)
Message-ID: <43A2071A.3030802@digis.net>
Date: Thu, 15 Dec 2005 17:15:22 -0700
From: bennett78 <bennett78@digis.net>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: multipart/alternative;
	boundary="------------010408090708070709060905"
Subject: MPC5200 ppc_md.set_rtc_time 
Reply-To: Frank Bennett <bennett78@digis.net>
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
--------------010408090708070709060905
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi:
   How / when does "ppc_md.set_rtc_time" get filled
in for Lite5200?

Config for support /dev/rtc enables CONFIG_PPC_RTC
which enable driver/char/rtc.c which mentions CMOS_WRITE
panics the kernel!

I trying to use driver/char/genrtc.c.   I can set date
but not hwclock.

 > hwclock --set --date="9/22/96 16:45:05"
gen_set_rtc_irq_bit:exit
gen_rtc_ioctl RTC_SET_TIME 00000060
RTC_SET_TIME: Invalid argument
ioctl() to /dev/rtc to set the time failed.

bash-2.05b# cat /proc/driver/rtc
rtc_time        : 00:50339648:36914
rtc_date        : -1072186980-497--1073718072
rtc_epoch       : 1900
alarm           : 00:00:00
DST_enable      : no
BCD             : yes
24hr            : yes
square_wave     : no
alarm_IRQ       : no
update_IRQ      : no  <----- how can I hook one?
periodic_IRQ    : no
periodic_freq   : 0
batt_status     : okay


thanks,

*/Frank Bennett
/*


--------------010408090708070709060905
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Hi:<br>
&nbsp;&nbsp; How / when does "ppc_md.set_rtc_time" get filled<br>
in for Lite5200?<br>
<br>
Config for support /dev/rtc enables CONFIG_PPC_RTC<br>
which enable driver/char/rtc.c which mentions CMOS_WRITE<br>
panics the kernel!<br>
<br>
I trying to use driver/char/genrtc.c.&nbsp;&nbsp; I can set date<br>
but not hwclock.<br>
<br>
&gt; hwclock --set --date="9/22/96 16:45:05"<br>
gen_set_rtc_irq_bit:exit<br>
gen_rtc_ioctl RTC_SET_TIME 00000060<br>
RTC_SET_TIME: Invalid argument<br>
ioctl() to /dev/rtc to set the time failed.<br>
<br>
bash-2.05b# cat /proc/driver/rtc<br>
rtc_time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 00:50339648:36914<br>
rtc_date&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : -1072186980-497--1073718072<br>
rtc_epoch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 1900<br>
alarm&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 00:00:00<br>
DST_enable&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : no<br>
BCD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : yes<br>
24hr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : yes<br>
square_wave&nbsp;&nbsp;&nbsp;&nbsp; : no<br>
alarm_IRQ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : no<br>
update_IRQ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : no&nbsp; &lt;----- how can I hook one?<br>
periodic_IRQ&nbsp;&nbsp;&nbsp; : no<br>
periodic_freq&nbsp;&nbsp; : 0<br>
batt_status&nbsp;&nbsp;&nbsp;&nbsp; : okay<br>
<br>
<br>
<div class="moz-signature">thanks,<br>
<meta content="text/html;" http-equiv="Content-Type">
<title></title>
<pre wrap=""><b><big><font face="Times New Roman, Times, serif"><em>Frank Bennett
</em></font></big></b>
</pre>
</div>
</body>
</html>

--------------010408090708070709060905--
