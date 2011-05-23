Return-Path: <vasim98@gmail.com>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 50586B6FB3
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 May 2011 16:34:51 +1000 (EST)
Received: by eyg5 with SMTP id 5so1867789eyg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 22 May 2011 23:34:46 -0700 (PDT)
MIME-Version: 1.0
From: Muhammad Waseem <vasim98@gmail.com>
Date: Mon, 23 May 2011 11:34:26 +0500
Message-ID: <BANLkTims8CrK6s0bJZPBt3jTDRDKzg2e-A@mail.gmail.com>
Subject: UART #1 access on Sequoia board
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=0015174c1aeede7b8f04a3ebaad1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0015174c1aeede7b8f04a3ebaad1
Content-Type: text/plain; charset=ISO-8859-1

Hello,
   I am working on PPC440EPx (Sequoia) to access its UART # 1 port for data
transfer, while UART # 0 is connected to remote terminal access on host.
However there is no module/driver listed for UART # 1 using 'lsmod'. The
kernel version is 2.6.23. How can I access the UART # 1 in user space and/or
kernel space? Do I need to develop own BSP for this? please help.

regards,
Waseem

--0015174c1aeede7b8f04a3ebaad1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hello,</div>=A0 =A0I am working on PPC440EPx (Sequoia) to access its U=
ART # 1 port for data transfer, while UART # 0 is connected to remote termi=
nal access on host. However there is no module/driver listed for UART # 1 u=
sing &#39;lsmod&#39;. The kernel version is 2.6.23. How can I access the UA=
RT # 1 in user space and/or kernel space? Do I need to develop own BSP for =
this? please help.<div>

<br></div><div>regards,</div><div>Waseem</div><div>=A0</div>

--0015174c1aeede7b8f04a3ebaad1--
