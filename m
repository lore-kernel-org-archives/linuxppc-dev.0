Return-Path: <isaac.gomez.morales@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2090AB7B66
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Sep 2009 17:30:46 +1000 (EST)
Received: from mail-ew0-f227.google.com (mail-ew0-f227.google.com
	[209.85.219.227]) by ozlabs.org (Postfix) with ESMTP id 14D75DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Sep 2009 17:30:43 +1000 (EST)
Received: by ewy27 with SMTP id 27so906209ewy.40
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Sep 2009 00:30:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090910163244.GA24878@b07421-ec1.am.freescale.net>
References: <38a5a2d10909100801x11049cddi1799c0ed6ee44410@mail.gmail.com>
	<20090910163244.GA24878@b07421-ec1.am.freescale.net>
Date: Fri, 11 Sep 2009 09:30:41 +0200
Message-ID: <38a5a2d10909110030k31f3574aocd7cb237bd6d088c@mail.gmail.com>
Subject: Re: Debian on MPC8572DS
From: Isaac Gomez Morales <isaac.gomez.morales@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: multipart/alternative; boundary=00504502d49516bf9f0473484ba3
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--00504502d49516bf9f0473484ba3
Content-Type: text/plain; charset=ISO-8859-1

Hello,

I'll try the "linutronix-lenny-gnuspe/" distro option, because i prefer a
option without a fp emulation.

Thanks u all.



2009/9/10 Scott Wood <scottwood@freescale.com>

> On Thu, Sep 10, 2009 at 05:01:53PM +0200, Isaac Gomez Morales wrote:
> > Hello,
> >
> > I'm trying to get a Linux distro such as Debian in the following system
> >
> > System:
> > mpc8572ds HW
>
> The 8572 does not have classic PowerPC floating point.  The Debian
> binaries use this, so they cannot run without emulation.
>
> Emulation is slow, so you probably want something like this instead:
>
> http://groups.google.com/group/linux.debian.ports.powerpc/browse_thread/thread/235607517fd7ae1e/f4638a2cdef09bf7?lnk=raot
> http://download.breakpoint.cc/debian/linutronix-lenny-gnuspe/
>
> -Scott
>

--00504502d49516bf9f0473484ba3
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,<br><br>
I&#39;ll try the &quot;linutronix-lenny-gnuspe/&quot; distro option, becaus=
e i prefer a option without a fp emulation.<br><br>Thanks u all.<br><br><br=
><br><div class=3D"gmail_quote">2009/9/10 Scott Wood <span dir=3D"ltr">&lt;=
<a href=3D"mailto:scottwood@freescale.com">scottwood@freescale.com</a>&gt;<=
/span><br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class=3D"im"=
>On Thu, Sep 10, 2009 at 05:01:53PM +0200, Isaac Gomez Morales wrote:<br>
&gt; Hello,<br>
&gt;<br>
&gt; I&#39;m trying to get a Linux distro such as Debian in the following s=
ystem<br>
&gt;<br>
&gt; System:<br>
&gt; mpc8572ds HW<br>
<br>
</div>The 8572 does not have classic PowerPC floating point. =A0The Debian<=
br>
binaries use this, so they cannot run without emulation.<br>
<br>
Emulation is slow, so you probably want something like this instead:<br>
<a href=3D"http://groups.google.com/group/linux.debian.ports.powerpc/browse=
_thread/thread/235607517fd7ae1e/f4638a2cdef09bf7?lnk=3Draot" target=3D"_bla=
nk">http://groups.google.com/group/linux.debian.ports.powerpc/browse_thread=
/thread/235607517fd7ae1e/f4638a2cdef09bf7?lnk=3Draot</a><br>

<a href=3D"http://download.breakpoint.cc/debian/linutronix-lenny-gnuspe/" t=
arget=3D"_blank">http://download.breakpoint.cc/debian/linutronix-lenny-gnus=
pe/</a><br>
<font color=3D"#888888"><br>
-Scott<br>
</font></blockquote></div><br>

--00504502d49516bf9f0473484ba3--
