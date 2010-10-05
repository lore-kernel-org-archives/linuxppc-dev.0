Return-Path: <bastiaan.nijkamp@gmail.com>
Received: from mail-qy0-f172.google.com (mail-qy0-f172.google.com
	[209.85.216.172]) by ozlabs.org (Postfix) with ESMTP id 95128B70CB
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  6 Oct 2010 01:31:21 +1100 (EST)
Received: by qyk5 with SMTP id 5so676753qyk.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 05 Oct 2010 07:31:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <0CE8B6BE3C4AD74AB97D9D29BD24E552013B9A9D@CORPEXCH1.na.ads.idt.com>
References: <0CE8B6BE3C4AD74AB97D9D29BD24E552013B97E8@CORPEXCH1.na.ads.idt.com>
	<AANLkTimCiHWRR-kVuT0ift3CH63Xk_XcaXS22qmVh6fr@mail.gmail.com>
	<0CE8B6BE3C4AD74AB97D9D29BD24E552013B9A9D@CORPEXCH1.na.ads.idt.com>
From: Bastiaan Nijkamp <bastiaan.nijkamp@gmail.com>
Date: Tue, 5 Oct 2010 16:30:58 +0200
Message-ID: <AANLkTikW7FY0Ptw8iuUGgFkOAWLBqn3_H74U5WvEseR7@mail.gmail.com>
Subject: Re: Serial RapidIO Maintaintance read causes lock up
To: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
Content-Type: multipart/alternative; boundary=00c09f972a7da8a0780491df8388
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--00c09f972a7da8a0780491df8388
Content-Type: text/plain; charset=ISO-8859-1

Hi Alex,

Yes, Sorry, that was a typo. The correct address that is printed is
0xd1080068.
And i did not disable the error handler, CONFIG_E500 is set at compile time.

Regards,
Bastiaan
2010/10/5 Bounine, Alexandre <Alexandre.Bounine@idt.com>

> Hi Bastiaan,
>
>
> Bastiaan Nijkamp <bastiaan.nijkamp@gmail.com> wrote:
>
> >fsl-of-rio e00c0000.rapidio: LAW start 0x00000000c0000000, RIO
> Maintainance Window Size >0x400000,New Main Start: 0xd1080000
> >RIO: enumerate master port 0, RIO0 mport
> >fsl_rio_config_read: index 0 destid 255 hopcount 0 offset 00000068 len
> 4
> ... skip ....
> >fsl_rio_config_read: triggering '__fsl_read_rio_config'
> >fsl_rio_config_read: going to request to read data at d108006
>
> An address printed in the last line looks strange - is this typo or real
> value?
> I would expect to see d1080068 here if your maintenance window starts at
> 0xd1080000.
>
> Alex.
>

--00c09f972a7da8a0780491df8388
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi Alex,</div>
<div>=A0</div>
<div>Yes, Sorry, that was a typo. The correct address that is printed is 0x=
d1080068.</div>
<div>And i did not disable the error handler, CONFIG_E500 is set at compile=
 time.</div>
<div>=A0</div>
<div>Regards,</div>
<div>Bastiaan<br></div>
<div class=3D"gmail_quote">2010/10/5 Bounine, Alexandre <span dir=3D"ltr">&=
lt;<a href=3D"mailto:Alexandre.Bounine@idt.com">Alexandre.Bounine@idt.com</=
a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hi Bastiaan,<br>
<div class=3D"im"><br><br>Bastiaan Nijkamp &lt;<a href=3D"mailto:bastiaan.n=
ijkamp@gmail.com">bastiaan.nijkamp@gmail.com</a>&gt; wrote:<br><br>&gt;fsl-=
of-rio e00c0000.rapidio: LAW start 0x00000000c0000000, RIO<br>Maintainance =
Window Size &gt;0x400000,New Main Start: 0xd1080000<br>

&gt;RIO: enumerate master port 0, RIO0 mport<br>&gt;fsl_rio_config_read: in=
dex 0 destid 255 hopcount 0 offset 00000068 len<br>4<br></div>... skip ....=
<br>
<div class=3D"im">&gt;fsl_rio_config_read: triggering &#39;__fsl_read_rio_c=
onfig&#39;<br>&gt;fsl_rio_config_read: going to request to read data at d10=
8006<br><br></div>An address printed in the last line looks strange - is th=
is typo or real<br>

value?<br>I would expect to see d1080068 here if your maintenance window st=
arts at<br>0xd1080000.<br><br>Alex.<br></blockquote></div><br>

--00c09f972a7da8a0780491df8388--
