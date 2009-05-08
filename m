Return-Path: <jcrigby@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.228])
	by ozlabs.org (Postfix) with ESMTP id BFF87DDF7B
	for <linuxppc-dev@ozlabs.org>; Fri,  8 May 2009 12:12:56 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f9so901097rvb.9
	for <linuxppc-dev@ozlabs.org>; Thu, 07 May 2009 19:12:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <fa686aa40905061941p6fd4b03dt1097cf4d16bdd665@mail.gmail.com>
References: <1241640919-4650-1-git-send-email-wd@denx.de>
	<1241640919-4650-9-git-send-email-wd@denx.de>
	<fa686aa40905061401k319313c5q89fd3e245c30808f@mail.gmail.com>
	<20090506221908.3927583420E8@gemini.denx.de>
	<fa686aa40905061551l8cf5940sf4d4cbf34331cf9a@mail.gmail.com>
	<fa686aa40905061941p6fd4b03dt1097cf4d16bdd665@mail.gmail.com>
Date: Thu, 7 May 2009 20:12:54 -0600
Message-ID: <4b73d43f0905071912k4bcc8821nabfa27aa5b1f587b@mail.gmail.com>
Subject: Re: [PATCH 08/12] mpc5121: Added I2C support.
From: John Rigby <jcrigby@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Content-Type: multipart/alternative; boundary=000e0cd32e0aa0ba5a04695d2a11
Cc: linux-i2c@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Wolfgang Denk <wd@denx.de>, Detlev Zundel <dzu@denx.de>,
	Piotr Ziecik <kosmo@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--000e0cd32e0aa0ba5a04695d2a11
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Ok, the interrupt enabling should happen in the driver.  Should it key off
compatible or should a new property be added like the existing 5200 clocking
property?

On Wed, May 6, 2009 at 8:41 PM, Grant Likely <grant.likely@secretlab.ca>wrote:

> On Wed, May 6, 2009 at 4:51 PM, Grant Likely <grant.likely@secretlab.ca>
> wrote:
> > On Wed, May 6, 2009 at 4:19 PM, Wolfgang Denk <wd@denx.de> wrote:
> >> Dear Grant Likely,
> >>
> >> In message <fa686aa40905061401k319313c5q89fd3e245c30808f@mail.gmail.com>
> you wrote:
> >>> On Wed, May 6, 2009 at 2:15 PM, Wolfgang Denk <wd@denx.de> wrote:
> >>> > From: Piotr Ziecik <kosmo@semihalf.com>
> >>> >
> >>> > - Enabled I2C interrupts on MPC5121.
> >>> > - Updated Kconfig for i2c-mpc driver.
> >>>
> >>> I think this workaround belongs in the driver itself.
> >>
> >> Sorry, I don't get it. Which workaround? What exactly should I change?
> >
> > Sorry, I misread the patch.  Never mind.
>
> Actually, on 3rd reading, I think my first impression was correct
> (even if I was wrong about it being a workaround).  This code in
> mpc512x_init_i2c() is only relevant for i2c busses (it isn't shared
> with any other drivers).  Therefore, it belongs with the i2c bus
> itself.  It does not belong in platform code.
>
> Cheers,
> g.
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>

--000e0cd32e0aa0ba5a04695d2a11
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Ok, the interrupt enabling should happen in the driver.=A0 Should it key of=
f compatible or should a new property be added like the existing 5200 clock=
ing property?<br><br><div class=3D"gmail_quote">On Wed, May 6, 2009 at 8:41=
 PM, Grant Likely <span dir=3D"ltr">&lt;<a href=3D"mailto:grant.likely@secr=
etlab.ca">grant.likely@secretlab.ca</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class=3D"im"=
>On Wed, May 6, 2009 at 4:51 PM, Grant Likely &lt;<a href=3D"mailto:grant.l=
ikely@secretlab.ca">grant.likely@secretlab.ca</a>&gt; wrote:<br>

&gt; On Wed, May 6, 2009 at 4:19 PM, Wolfgang Denk &lt;<a href=3D"mailto:wd=
@denx.de">wd@denx.de</a>&gt; wrote:<br>
&gt;&gt; Dear Grant Likely,<br>
&gt;&gt;<br>
&gt;&gt; In message &lt;<a href=3D"mailto:fa686aa40905061401k319313c5q89fd3=
e245c30808f@mail.gmail.com">fa686aa40905061401k319313c5q89fd3e245c30808f@ma=
il.gmail.com</a>&gt; you wrote:<br>
&gt;&gt;&gt; On Wed, May 6, 2009 at 2:15 PM, Wolfgang Denk &lt;<a href=3D"m=
ailto:wd@denx.de">wd@denx.de</a>&gt; wrote:<br>
&gt;&gt;&gt; &gt; From: Piotr Ziecik &lt;<a href=3D"mailto:kosmo@semihalf.c=
om">kosmo@semihalf.com</a>&gt;<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; - Enabled I2C interrupts on MPC5121.<br>
&gt;&gt;&gt; &gt; - Updated Kconfig for i2c-mpc driver.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I think this workaround belongs in the driver itself.<br>
&gt;&gt;<br>
&gt;&gt; Sorry, I don&#39;t get it. Which workaround? What exactly should I=
 change?<br>
&gt;<br>
&gt; Sorry, I misread the patch. =A0Never mind.<br>
<br>
</div>Actually, on 3rd reading, I think my first impression was correct<br>
(even if I was wrong about it being a workaround). =A0This code in<br>
mpc512x_init_i2c() is only relevant for i2c busses (it isn&#39;t shared<br>
with any other drivers). =A0Therefore, it belongs with the i2c bus<br>
itself. =A0It does not belong in platform code.<br>
<br>
Cheers,<br>
<div><div></div><div class=3D"h5">g.<br>
<br>
--<br>
Grant Likely, B.Sc., P.Eng.<br>
Secret Lab Technologies Ltd.<br>
</div></div></blockquote></div><br>

--000e0cd32e0aa0ba5a04695d2a11--
