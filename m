Return-Path: <vasim98@gmail.com>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A8948B6F6E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 May 2011 17:26:45 +1000 (EST)
Received: by ewy6 with SMTP id 6so559503ewy.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 May 2011 00:26:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <mailman.1.1306461602.19013.linuxppc-dev@lists.ozlabs.org>
References: <mailman.1.1306461602.19013.linuxppc-dev@lists.ozlabs.org>
From: Muhammad Waseem <vasim98@gmail.com>
Date: Fri, 27 May 2011 12:26:20 +0500
Message-ID: <BANLkTima3uLXvF3Zri5DjDDFHAB+CZMDgg@mail.gmail.com>
Subject: Re: Linuxppc-dev Digest, Vol 81, Issue 140
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=0015174c1aeed9396a04a43cdbdb
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0015174c1aeed9396a04a43cdbdb
Content-Type: text/plain; charset=ISO-8859-1

I have developed a simple polling based serial device driver for PC's serial
port (COM1: 0x3F8) which works fine. Now I want to implement the same on
UART # 1 of PPC440EPx (Sequoia board).

By changing the base address 0x3F8 to UART# 1 base address (0xEF600400) in
Sequoia it does not work and return all the registers contents
from 0xEF600400 to 0xEF600407 as 0xFF.

Whereas existing ttyS1 driver works for UART# 1.

How can I access the UART# 1 registers in a custom serial driver under
kernel space.

Waseem

--0015174c1aeed9396a04a43cdbdb
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I have=A0developed=A0a simple polling based serial device driver for PC&#39=
;s serial port (COM1: 0x3F8) which works fine. Now I want to implement the =
same on UART # 1 of PPC440EPx (Sequoia board).=A0<div><br></div><div>By cha=
nging the base address 0x3F8 to UART# 1 base address (0xEF600400) in Sequoi=
a it does not work and return all the registers contents from=A00xEF600400 =
to=A00xEF600407 as 0xFF.</div>

<div><br></div><div>Whereas existing ttyS1 driver works for UART# 1.</div><=
div><br></div><div>How can I access the UART# 1 registers in a custom seria=
l driver under kernel space.</div><div><br></div><div>Waseem</div><div>

<br></div><div>=A0<br><div><br></div></div>

--0015174c1aeed9396a04a43cdbdb--
