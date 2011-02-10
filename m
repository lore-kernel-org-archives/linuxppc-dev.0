Return-Path: <resnuw@gmail.com>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E50C6B711E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Feb 2011 18:15:47 +1100 (EST)
Received: by qwb7 with SMTP id 7so767545qwb.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 09 Feb 2011 23:15:43 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 10 Feb 2011 12:45:43 +0530
Message-ID: <AANLkTikBqpHPf1oJbJXPDHBqVEGUjOTwxbNAug-JkzDP@mail.gmail.com>
Subject: pls help-problem with mmap DMA buffer
From: reshi nuwa <resnuw@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=0016e645ba2e878fed049be8596f
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016e645ba2e878fed049be8596f
Content-Type: text/plain; charset=ISO-8859-1

Hi ,

I get the same problem as in
http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-November/077394.html

posted by Jonathan.

One solution suggested is using get_user_pages(), which give a pointer of
user space buffer to the kernel module to DMA( as I got it)
But the code in teh above link tries to get the kernel buffer pointer in to
the user space. What I want to know is what's wrong/what modifications
should be done to the above code to achieve this? Is this a bad aproach to
access the DMA buffer in user space?

Thanx in advance.

--0016e645ba2e878fed049be8596f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi ,<div><br><div>I get the same problem as in</div><div><a href=3D"http://=
lists.ozlabs.org/pipermail/linuxppc-dev/2009-November/077394.html">http://l=
ists.ozlabs.org/pipermail/linuxppc-dev/2009-November/077394.html</a></div>
<div><br></div><div>posted by=A0<span class=3D"Apple-style-span" style=3D"f=
ont-family: monospace; font-size: medium; white-space: pre; ">Jonathan.</sp=
an></div><div><span class=3D"Apple-style-span" style=3D"font-family: monosp=
ace; font-size: medium; white-space: pre; "><br>
</span></div><div><span class=3D"Apple-style-span" style=3D"font-family: mo=
nospace; font-size: medium; white-space: pre; ">One solution suggested is u=
sing get_user_pages(), which give a pointer of user space buffer to the ker=
nel module to DMA( as I got it)</span></div>
<div><span class=3D"Apple-style-span" style=3D"font-family: monospace; font=
-size: medium; white-space: pre; ">But the code in teh above link tries to =
get the kernel buffer pointer in to the user space. What I want to know is =
what&#39;s wrong/what modifications should be done to the above code to ach=
ieve this? Is this a bad aproach to access the DMA buffer in user space?</s=
pan></div>
<div><span class=3D"Apple-style-span" style=3D"font-family: monospace; font=
-size: medium; white-space: pre; "><br></span></div><div><span class=3D"App=
le-style-span" style=3D"font-family: monospace; font-size: medium; white-sp=
ace: pre; ">Thanx in advance.</span></div>
<div><span class=3D"Apple-style-span" style=3D"font-family: monospace; font=
-size: medium; white-space: pre; "><br></span></div></div>

--0016e645ba2e878fed049be8596f--
