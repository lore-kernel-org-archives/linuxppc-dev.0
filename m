Return-Path: <bhayanisunny@gmail.com>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2E7F8B70F9
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 29 Jan 2011 00:45:38 +1100 (EST)
Received: by bwz10 with SMTP id 10so3399542bwz.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Jan 2011 05:45:33 -0800 (PST)
MIME-Version: 1.0
From: sunny bhayani <bhayanisunny@gmail.com>
Date: Fri, 28 Jan 2011 19:15:13 +0530
Message-ID: <AANLkTikatrqNZydG3Do8UgYeB4c=iteBG==r2dBn6hZV@mail.gmail.com>
Subject: Need help for USB OTG feature for Canyonlands PPC460EX Board
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=0016e6d97652bb16a1049ae8472e
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016e6d97652bb16a1049ae8472e
Content-Type: text/plain; charset=ISO-8859-1

Hi All,

I am trying to enable the USB DWC OTG feature for Canyonlands PPC460EX
Board, and am using the 2.6.30 kernel from denx.

Now the issue is I am selecting the "USB Gadget" feature from the kernel
menuconfig, but the kernel log only shows,

dwc_otg: version 2.60a 22-NOV-2006


The probe() function in "drivers/usb/gadged/dwc_otg/dwc_otg_driver.c" is not
getting called. So I am not getting the following kernel boot messages:

dwc_otg: Shared Tx FIFO mode
dwc_otg: Using Slave mode
dwc_otg dwc_otg.0: DWC OTG Controller
dwc_otg dwc_otg.0: new USB bus registered, assigned bus number 2
dwc_otg dwc_otg.0: irq 28, io mem 0x00000000
dwc_otg: dwc_otg_core_host_init: Unable to clear halt on channel 1
dwc_otg: Init: Port Power? op_state=4


Can you please let me know, what might be the problem.


Regards,
Sunny Bhayani
+91-88921-80558

--0016e6d97652bb16a1049ae8472e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi All,<div><br></div><div>I am trying to enable the USB DWC OTG feature fo=
r Canyonlands PPC460EX Board, and am using the 2.6.30 kernel from denx.</di=
v><div><br></div><div>Now the issue is I am selecting the &quot;USB Gadget&=
quot; feature from the kernel menuconfig, but the kernel log<span class=3D"=
Apple-style-span" style=3D"font-family: arial, sans-serif; font-size: 13px;=
 border-collapse: collapse; ">=A0only shows,</span></div>

<div><span class=3D"Apple-style-span" style=3D"font-family: arial, sans-ser=
if; font-size: 13px; border-collapse: collapse; "><div><pre style=3D"white-=
space: pre-wrap; ">dwc_otg: version 2.60a 22-NOV-2006<br></pre><pre style=
=3D"white-space: pre-wrap; ">

<br></pre><div>The probe() function in &quot;<span class=3D"Apple-style-spa=
n" style=3D"font-family: monospace; white-space: pre-wrap; ">drivers/usb/ga=
dged/dwc_otg/dwc_otg_driver.c</span>&quot; is not getting called. So I am n=
ot getting the following kernel boot messages:</div>

<meta http-equiv=3D"content-type" content=3D"text/html; charset=3Dutf-8"><d=
iv><pre style=3D"white-space: pre-wrap; ">dwc_otg: Shared Tx FIFO mode
dwc_otg: Using Slave mode
dwc_otg dwc_otg.0: DWC OTG Controller
dwc_otg dwc_otg.0: new USB bus registered, assigned bus number 2
dwc_otg dwc_otg.0: irq 28, io mem 0x00000000
dwc_otg: dwc_otg_core_host_init: Unable to clear halt on channel 1
dwc_otg: Init: Port Power? op_state=3D4
</pre></div><div><br></div><div>Can you please let me know, what might be t=
he problem.</div></div><div><br></div></span></div><div><br clear=3D"all">R=
egards,<br>Sunny Bhayani<br>+91-88921-80558<br>
</div>

--0016e6d97652bb16a1049ae8472e--
