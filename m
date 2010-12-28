Return-Path: <vsabarin@gmail.com>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4A6B3B70DA
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Dec 2010 00:09:53 +1100 (EST)
Received: by ywe10 with SMTP id 10so4373726ywe.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Dec 2010 05:09:48 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 28 Dec 2010 18:39:48 +0530
Message-ID: <AANLkTi=TCkjhnZvjP=tADHTUnLGY7nzE+9Ke6bqOidAA@mail.gmail.com>
Subject: Hang in Freescale Host Controller
From: Sabari <vsabarin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=0016e644c714d1490e0498782a8f
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016e644c714d1490e0498782a8f
Content-Type: text/plain; charset=ISO-8859-1

Hi,
    I am expereincing some sort of end less loop in FHCI, we are using linux
2.6.11 on MPC836X we got as part of BSP from freescale. When we connect the
usb device and try to do some data transfer we see an endless loop happens
in function

scan_ed_list(..) of fhci-hcd.c when list_type BULK list is passed to it.

Is any one faced similar issue on the freescale host controller interface
for any USB device? If so tell us how you have overcomed this issue.

Thanks,
Sabari.

--0016e644c714d1490e0498782a8f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi,</div>
<div>=A0=A0=A0 I am expereincing some sort of end less loop in FHCI, we are=
 using linux 2.6.11 on MPC836X we got as part of BSP from freescale. When w=
e connect the usb device and try to do some data transfer we see an endless=
 loop happens in function</div>

<div>=A0</div>
<div>scan_ed_list(..) of fhci-hcd.c when list_type BULK list is passed to i=
t.</div>
<div>=A0</div>
<div>Is any one faced similar issue on the freescale host controller interf=
ace for any USB device? If so tell us how you have overcomed this issue.</d=
iv>
<div>=A0</div>
<div>Thanks,</div>
<div>Sabari.</div>
<div>=A0</div>
<div>=A0</div>

--0016e644c714d1490e0498782a8f--
