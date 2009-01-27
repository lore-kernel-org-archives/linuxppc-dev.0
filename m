Return-Path: <jhautbois@gmail.com>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.190])
	by ozlabs.org (Postfix) with ESMTP id 28B3CDE024
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jan 2009 19:18:16 +1100 (EST)
Received: by fk-out-0910.google.com with SMTP id 18so3631456fkq.9
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jan 2009 00:18:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20090126170929.GA5820@ld0162-tx32.am.freescale.net>
References: <8cad0aa0901260217u5a981c77gc09caba76cce32a7@mail.gmail.com>
	<20090126170929.GA5820@ld0162-tx32.am.freescale.net>
Date: Tue, 27 Jan 2009 09:18:14 +0100
Message-ID: <8cad0aa0901270018l197ed1dei305819bcbffa9ae@mail.gmail.com>
Subject: Re: Help needed with initramfs
From: Jean-Michel Hautbois <jhautbois@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: multipart/alternative; boundary=001636c598d62dc79b0461727f69
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--001636c598d62dc79b0461727f69
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

2009/1/26 Scott Wood <scottwood@freescale.com>

> On Mon, Jan 26, 2009 at 11:17:05AM +0100, Jean-Michel Hautbois wrote:
> > I understand that my load address is 0x400000 and that the image is too
> big,
> > but I can't find where this load adress is defined.
> > It seems (from the .../arch/powerpc/boot/wrapper file) that this adress
> is
> > calculated from the _start adress in the objfile.
> >
> > Is it possible to change this adress ?
> > What can I do (with the idea of not reducing the size of my rootfs) ?
>
> You can change link_address in arch/powerpc/boot/wrapper, or provide a
> vmlinux_alloc method in the wrapper ops struct.
>
> -Scott
>

Thanks !
It works perfectly :)

JM

--001636c598d62dc79b0461727f69
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">2009/1/26 Scott Wood <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:scottwood@freescale.com">scottwood@freescale.com</a>&gt;</span=
><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(=
204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div><div></div><div class=3D"Wj3C7c">On Mon, Jan 26, 2009 at 11:17:05AM +0=
100, Jean-Michel Hautbois wrote:<br>
&gt; I understand that my load address is 0x400000 and that the image is to=
o big,<br>
&gt; but I can&#39;t find where this load adress is defined.<br>
&gt; It seems (from the .../arch/powerpc/boot/wrapper file) that this adres=
s is<br>
&gt; calculated from the _start adress in the objfile.<br>
&gt;<br>
&gt; Is it possible to change this adress ?<br>
&gt; What can I do (with the idea of not reducing the size of my rootfs) ?<=
br>
<br>
</div></div>You can change link_address in arch/powerpc/boot/wrapper, or pr=
ovide a<br>
vmlinux_alloc method in the wrapper ops struct.<br>
<font color=3D"#888888"><br>
-Scott<br>
</font></blockquote></div><br>Thanks !<br>It works perfectly :)<br><br>JM<b=
r>

--001636c598d62dc79b0461727f69--
