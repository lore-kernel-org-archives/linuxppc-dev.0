Return-Path: <jcrigby@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.174])
	by ozlabs.org (Postfix) with ESMTP id 33F38DDF91
	for <linuxppc-dev@ozlabs.org>; Sat, 30 May 2009 06:30:58 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so1952783wfg.15
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 13:30:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1243595599.9769.35.camel@localhost.localdomain>
References: <1243595599.9769.35.camel@localhost.localdomain>
Date: Fri, 29 May 2009 14:30:57 -0600
Message-ID: <4b73d43f0905291330i67c20bd3y2fa3f1a127077b74@mail.gmail.com>
Subject: Re: fastboot.
From: John Rigby <jcrigby@gmail.com>
To: Kenneth Johansson <kenneth@southpole.se>
Content-Type: multipart/alternative; boundary=000e0cd144942d7538046b12f43c
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--000e0cd144942d7538046b12f43c
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Kenneth,

I did some fastboot work for 5121 a few months ago.  U-boot, kernel and
JFFS2 rootfs in NOR.  My reset to userland time was 2.0 seconds, where
userland was first command executed in first rc.whatever file, so it
included the time for /sbin/init to get up and start running the rc scripts.

I did some profiling and noticed that the JFFS2 boot time was a significant
hunk (not just the first time but everytime).  I ran sumtool on the JFFS2
image and it dropped 600 ms from the boot time so my final time was 1.4
seconds.  The sumtool program has been around for a few years but it was
news to mean when I found it.

John

On Fri, May 29, 2009 at 5:13 AM, Kenneth Johansson <kenneth@southpole.se>wrote:

> http://www.cambridgewireless.co.uk/news/article/default.aspx?objid=36792
>
> Anybody know what they mean by booting here.
>
> I have started the ads5121 board using u-boot and kernel in NOR flash
> and root file system on a compact flash card connected to the IDE
> interface in 2.05 second until init is started from the rootfs.
>
> This was fast enough for what was needed I did not try to optimize
> further but since I already was in the domain where changes impacted
> only a few milliseconds I have a hard time imagining going down to less
> than a second.
>
> So I guess the only way is to skip u-boot and run linux kernel directly
> out of NOR. Anyone know what MontaVista is doing ??
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>

--000e0cd144942d7538046b12f43c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Kenneth,<br><br>I did some fastboot work for 5121 a few months ago.=A0 U-bo=
ot, kernel and JFFS2 rootfs in NOR.=A0 My reset to userland time was 2.0 se=
conds, where userland was first command executed in first rc.whatever file,=
 so it included the time for /sbin/init to get up and start running the rc =
scripts.<br>
<br>I did some profiling and noticed that the JFFS2 boot time was a signifi=
cant hunk (not just the first time but everytime).=A0 I ran sumtool on the =
JFFS2 image and it dropped 600 ms from the boot time so my final time was 1=
.4 seconds.=A0 The sumtool program has been around for a few years but it w=
as news to mean when I found it.<br>
<br>John<br><br><div class=3D"gmail_quote">On Fri, May 29, 2009 at 5:13 AM,=
 Kenneth Johansson <span dir=3D"ltr">&lt;<a href=3D"mailto:kenneth@southpol=
e.se">kenneth@southpole.se</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt =
0pt 0pt 0.8ex; padding-left: 1ex;">
<a href=3D"http://www.cambridgewireless.co.uk/news/article/default.aspx?obj=
id=3D36792" target=3D"_blank">http://www.cambridgewireless.co.uk/news/artic=
le/default.aspx?objid=3D36792</a><br>
<br>
Anybody know what they mean by booting here.<br>
<br>
I have started the ads5121 board using u-boot and kernel in NOR flash<br>
and root file system on a compact flash card connected to the IDE<br>
interface in 2.05 second until init is started from the rootfs.<br>
<br>
This was fast enough for what was needed I did not try to optimize<br>
further but since I already was in the domain where changes impacted<br>
only a few milliseconds I have a hard time imagining going down to less<br>
than a second.<br>
<br>
So I guess the only way is to skip u-boot and run linux kernel directly<br>
out of NOR. Anyone know what MontaVista is doing ??<br>
<br>
_______________________________________________<br>
Linuxppc-dev mailing list<br>
<a href=3D"mailto:Linuxppc-dev@ozlabs.org">Linuxppc-dev@ozlabs.org</a><br>
<a href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-dev" target=3D"_bla=
nk">https://ozlabs.org/mailman/listinfo/linuxppc-dev</a><br>
</blockquote></div><br>

--000e0cd144942d7538046b12f43c--
