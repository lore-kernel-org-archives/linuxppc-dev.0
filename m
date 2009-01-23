Return-Path: <ratheeshreddy@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.228])
	by ozlabs.org (Postfix) with ESMTP id 2D071DDF37
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jan 2009 19:48:19 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so4827118rvb.9
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jan 2009 00:48:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20090122180001.GB18427@ld0162-tx32.am.freescale.net>
References: <21589420.post@talk.nabble.com> <49783993.4090408@denx.de>
	<21605367.post@talk.nabble.com>
	<1232646323.4661.3.camel@r54964-12.am.freescale.net>
	<20090122180001.GB18427@ld0162-tx32.am.freescale.net>
Date: Fri, 23 Jan 2009 14:18:17 +0530
Message-ID: <c94019ff0901230048m73b3d918k4544c73d07d3fbb0@mail.gmail.com>
Subject: Re: eth0: Could not attach to PHY
From: Ratheesh <ratheeshreddy@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: multipart/alternative; boundary=00163645924649b89b0461227391
Cc: linuxppc-dev@ozlabs.org, wael showair <showair2003@yahoo.com>,
	Haiying Wang <Haiying.Wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--00163645924649b89b0461227391
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi
The device tree format has changed from linux-2.6.24. You need to port the
U-Boot to the latest version. Even I faced the same issue.

Regards
Ratheesh

On Thu, Jan 22, 2009 at 11:30 PM, Scott Wood <scottwood@freescale.com>wrote:

> On Thu, Jan 22, 2009 at 12:45:22PM -0500, Haiying Wang wrote:
> > On Thu, 2009-01-22 at 06:37 -0800, wael showair wrote:
> >
> > >             mdio@24520 {
> > >                     #address-cells = <1>;
> > >                     #size-cells = <0>;
> > >                     device_type = "mdio";
> > >                     compatible = "gianfar";
> > >                     reg = <24520 20>;
> > >                     linux,phandle = <24520>;
> >
> > Change compatible to "gianfar-mdio".
>
> "fsl,gianfar-mdio"
>
> -Scott
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>

--00163645924649b89b0461227391
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi<br>The device tree format has changed from linux-2.6.24. You need to por=
t the U-Boot to the latest version. Even I faced the same issue.<br><br>Reg=
ards<br>Ratheesh<br><br><div class=3D"gmail_quote">On Thu, Jan 22, 2009 at =
11:30 PM, Scott Wood <span dir=3D"ltr">&lt;<a href=3D"mailto:scottwood@free=
scale.com">scottwood@freescale.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class=3D"Ih2=
E3d">On Thu, Jan 22, 2009 at 12:45:22PM -0500, Haiying Wang wrote:<br>
&gt; On Thu, 2009-01-22 at 06:37 -0800, wael showair wrote:<br>
&gt;<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; mdio@24520 {<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; #address-cells =3D &lt;1&gt;;<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; #size-cells =3D &lt;0&gt;;<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; device_type =3D &quot;mdio&quot;;<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; compatible =3D &quot;gianfar&quot;;<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; reg =3D &lt;24520 20&gt;;<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; linux,phandle =3D &lt;24520&gt;;<br>
&gt;<br>
&gt; Change compatible to &quot;gianfar-mdio&quot;.<br>
<br>
</div>&quot;fsl,gianfar-mdio&quot;<br>
<font color=3D"#888888"><br>
-Scott<br>
</font><div><div></div><div class=3D"Wj3C7c">______________________________=
_________________<br>
Linuxppc-dev mailing list<br>
<a href=3D"mailto:Linuxppc-dev@ozlabs.org">Linuxppc-dev@ozlabs.org</a><br>
<a href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-dev" target=3D"_bla=
nk">https://ozlabs.org/mailman/listinfo/linuxppc-dev</a><br>
</div></div></blockquote></div><br>

--00163645924649b89b0461227391--
