Return-Path: <liranrazlinux@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id B31EADDF31
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2009 00:39:11 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so1733921ywb.39
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Mar 2009 06:39:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ed82fe3e0903131718u2d49cad3j78e2d08d4de0bf4a@mail.gmail.com>
References: <e3b3ab5c0903131156l45ab934fyf7fb33b71468594a@mail.gmail.com>
	<ed82fe3e0903131718u2d49cad3j78e2d08d4de0bf4a@mail.gmail.com>
Date: Mon, 16 Mar 2009 05:39:08 -0800
Message-ID: <e3b3ab5c0903160639u625a0fd3xa665896bb378b109@mail.gmail.com>
Subject: Re: node /dev/ttyCPM2 not created
From: liran raz <liranrazlinux@gmail.com>
To: Timur Tabi <timur@tabi.org>
Content-Type: multipart/alternative; boundary=000e0cd487ba272d9e04653c9384
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--000e0cd487ba272d9e04653c9384
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Thanks, I don't see any mdev process running.
Just wonder who is creating /dev/ttyCPM1 since in the device table file
(device_table.txt)
I have only node: 204 (major) 46 (minor) defined.
But I can see /dev/ttyCPM1 (204 47)
Liran.

On Fri, Mar 13, 2009 at 4:18 PM, Timur Tabi <timur@tabi.org> wrote:

> On Fri, Mar 13, 2009 at 1:56 PM, liran raz <liranrazlinux@gmail.com>
> wrote:
>
> > Does anyone know what I'm missing? or what do I need to configure
> > in order to have: /dev/ttyCPM2 ?
>
> My guess is that you don't have udev or mdev running.
>
>
> --
> Timur Tabi
> Linux kernel developer at Freescale
>

--000e0cd487ba272d9e04653c9384
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Thanks, I don&#39;t see any mdev process=A0running.</div>
<div>Just wonder who is creating /dev/ttyCPM1 since in the device table fil=
e (device_table.txt)</div>
<div>I have only node: 204 (major) 46 (minor) defined.</div>
<div>But I can see /dev/ttyCPM1 (204 47)</div>
<div>Liran.<br><br></div>
<div class=3D"gmail_quote">On Fri, Mar 13, 2009 at 4:18 PM, Timur Tabi <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:timur@tabi.org">timur@tabi.org</a>&gt;<=
/span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div class=3D"im">On Fri, Mar 13, 2009 at 1:56 PM, liran raz &lt;<a href=3D=
"mailto:liranrazlinux@gmail.com">liranrazlinux@gmail.com</a>&gt; wrote:<br>=
<br>&gt; Does anyone know what I&#39;m missing? or what do I need to config=
ure<br>
&gt; in order to have: /dev/ttyCPM2 ?<br><br></div>My guess is that you don=
&#39;t have udev or mdev running.<br><font color=3D"#888888"><br><br>--<br>=
Timur Tabi<br>Linux kernel developer at Freescale<br></font></blockquote>
</div><br>

--000e0cd487ba272d9e04653c9384--
