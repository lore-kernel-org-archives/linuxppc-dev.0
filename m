Return-Path: <gnathita@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.204])
	by ozlabs.org (Postfix) with ESMTP id 072F067A63
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Feb 2006 18:47:51 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id 69so480768wri
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 09 Feb 2006 23:47:50 -0800 (PST)
Message-ID: <259581790602092347m5f61bd27j170763176ee6cf6e@mail.gmail.com>
Date: Fri, 10 Feb 2006 08:47:49 +0100
From: =?ISO-8859-1?Q?Paula_Saame=F1o?= <gnathita@gmail.com>
To: linuxppc-embedded@ozlabs.org, bennett78@digis.net
Subject: Re: Getting started with Xilinx V4 PPC?
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_11181_15866610.1139557669957"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_11181_15866610.1139557669957
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi!!

I am using ML403 right now and everything works fine with the
linuxppc_2_4_devel. My basic design has a simple UART, DDR, Ethernet, IIC
and XSysAce.
I haven't measured the power consumption yet, but I will soon. I'll let you
know when I do it.

I thought about using the internal FPGA MAC as a complete PHY. For Ethernet
over fiber it's ok, but for Ethernet over copper, we should implement the
collision detector, serder... "manually" and I don't think we had enough
space in the FPGA (XC4VFX12), since the actual design uses the 85% of
slices.
Maybe with a bigger FPGA we could do the complete design "inside".

Have a good weekend!
Paula

------=_Part_11181_15866610.1139557669957
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br>
Hi!!<br>
<br>
I am using ML403 right now and everything works fine with the
linuxppc_2_4_devel. My basic design has a simple UART, DDR, Ethernet,
IIC and XSysAce.<br>
I haven't measured the power consumption yet, but I will soon. I'll let you=
 know when I do it.<br>
<br>
I thought about using the internal FPGA MAC as a complete PHY. For
Ethernet over fiber it's ok, but for Ethernet over copper, we should
implement the collision detector, serder... &quot;manually&quot; and I don'=
t
think we had enough space in the FPGA (XC4VFX12), since the actual
design uses the 85% of slices.<br>
Maybe with a bigger FPGA we could do the complete design &quot;inside&quot;=
.<br>
<br>
Have a good weekend!<br>
Paula<br>
<br>

------=_Part_11181_15866610.1139557669957--
