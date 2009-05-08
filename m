Return-Path: <jcrigby@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.233])
	by ozlabs.org (Postfix) with ESMTP id 63C5DDDF81
	for <linuxppc-dev@ozlabs.org>; Fri,  8 May 2009 12:22:15 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f9so904262rvb.9
	for <linuxppc-dev@ozlabs.org>; Thu, 07 May 2009 19:22:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <fa686aa40905061359p3ba2115fj57f4d9a79f01efda@mail.gmail.com>
References: <1241640919-4650-1-git-send-email-wd@denx.de>
	<1241640919-4650-7-git-send-email-wd@denx.de>
	<fa686aa40905061359p3ba2115fj57f4d9a79f01efda@mail.gmail.com>
Date: Thu, 7 May 2009 20:22:14 -0600
Message-ID: <4b73d43f0905071922x7b5ed328q86b14a35c0040270@mail.gmail.com>
Subject: Re: [PATCH 06/12] mpc5121: Added NAND Flash Controller driver.
From: John Rigby <jcrigby@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Content-Type: multipart/alternative; boundary=000e0cd2e6e6f7030404695d4b3c
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	Wolfgang Denk <wd@denx.de>, Piotr Ziecik <kosmo@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--000e0cd2e6e6f7030404695d4b3c
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Wed, May 6, 2009 at 2:59 PM, Grant Likely <grant.likely@secretlab.ca>wrote:

>
>
> > diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c
> b/arch/powerpc/platforms/512x/mpc512x_shared.c
> > index d8cd579..7135d89 100644
> > --- a/arch/powerpc/platforms/512x/mpc512x_shared.c
> > +++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
> > @@ -71,6 +71,7 @@ void __init mpc512x_init_IRQ(void)
> >  static struct of_device_id __initdata of_bus_ids[] = {
> >        { .compatible = "fsl,mpc5121-immr", },
> >        { .compatible = "fsl,mpc5121-localbus", },
> > +       { .compatible = "fsl,mpc5121-nfc", },
>
> This doesn't look right.  Shouldn't the NAND controller be hanging of
> the IMMR node?
>

I just wanted to confirm that NFC is in its own memory space.   It has its
own mapping and is not part of the IMMR space.

--000e0cd2e6e6f7030404695d4b3c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Wed, May 6, 2009 at 2:59 PM, Grant Li=
kely <span dir=3D"ltr">&lt;<a href=3D"mailto:grant.likely@secretlab.ca">gra=
nt.likely@secretlab.ca</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_=
quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt =
0pt 0.8ex; padding-left: 1ex;">
<br>
<div class=3D"im"><br>
&gt; diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/power=
pc/platforms/512x/mpc512x_shared.c<br>
&gt; index d8cd579..7135d89 100644<br>
&gt; --- a/arch/powerpc/platforms/512x/mpc512x_shared.c<br>
&gt; +++ b/arch/powerpc/platforms/512x/mpc512x_shared.c<br>
&gt; @@ -71,6 +71,7 @@ void __init mpc512x_init_IRQ(void)<br>
&gt; =A0static struct of_device_id __initdata of_bus_ids[] =3D {<br>
&gt; =A0 =A0 =A0 =A0{ .compatible =3D &quot;fsl,mpc5121-immr&quot;, },<br>
&gt; =A0 =A0 =A0 =A0{ .compatible =3D &quot;fsl,mpc5121-localbus&quot;, },<=
br>
&gt; + =A0 =A0 =A0 { .compatible =3D &quot;fsl,mpc5121-nfc&quot;, },<br>
<br>
</div>This doesn&#39;t look right. =A0Shouldn&#39;t the NAND controller be =
hanging of<br>
the IMMR node?<br>
</blockquote><div><br>I just wanted to confirm that NFC is in its own memor=
y space. =A0 It has its own mapping and is not part of the IMMR space.<br><=
/div></div><br>

--000e0cd2e6e6f7030404695d4b3c--
