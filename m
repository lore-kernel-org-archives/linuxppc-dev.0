Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-it0-x233.google.com (mail-it0-x233.google.com
 [IPv6:2607:f8b0:4001:c0b::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yzH3p0xn2zDsPs
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Dec 2017 17:11:01 +1100 (AEDT)
Received: by mail-it0-x233.google.com with SMTP id o130so539709itg.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Dec 2017 22:11:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAGoOwPSqf4oKB=gZdD8=W=q9y=CcpjYyUuWkmfm7dQc+P6QDmw@mail.gmail.com>
References: <1513207108-30430-1-git-send-email-nicoleotsuka@gmail.com>
 <1513207108-30430-4-git-send-email-nicoleotsuka@gmail.com>
 <aad404d3-fa61-3c49-6265-04fc3b256bc6@tabi.org>
 <CAGoOwPSqf4oKB=gZdD8=W=q9y=CcpjYyUuWkmfm7dQc+P6QDmw@mail.gmail.com>
From: Nicolin Chen <nicoleotsuka@gmail.com>
Date: Fri, 15 Dec 2017 22:10:58 -0800
Message-ID: <CAGoOwPR3BQY9VNyi5qgQH-tdY3WPNyRhfiC26hLQabQQejGBRw@mail.gmail.com>
Subject: Re: [PATCH v3 03/11] ASoC: fsl_ssi: Refine all comments
To: Timur Tabi <timur@tabi.org>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 fabio.estevam@nxp.com, mail@maciej.szmigiero.name, caleb@crome.org,
 lgirdwood@gmail.com, arnaud.mouiche@invoxia.com, lukma@denx.de,
 kernel@pengutronix.de
Content-Type: multipart/alternative; boundary="94eb2c030a10207d6305606efbb1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--94eb2c030a10207d6305606efbb1
Content-Type: text/plain; charset="UTF-8"

Hi,

I am outside so can't use mutt. Sorry for that.

This comment is going to be replaced in the 2nd set anyway because the
whole function will be replaced.

And please point out all comments that you think I need to rework. I am
totally fine to do that. I don't think every single one is bad. And this
patch has to go in as it also adds a lot of new comments.

Thank you for your effort
Nicolin

On Dec 15, 2017 20:43, "Timur Tabi" <timur@tabi.org> wrote:

On 12/13/17 5:18 PM, Nicolin Chen wrote:

> -        * We are running on a SoC which does not support online SSI
> -        * reconfiguration, so we have to enable all necessary flags at
> once
> -        * even if we do not use them later (capture and playback
> configuration)
> +        * Online configuration is not supported
> +        * Enable or Disable all necessary bits at once
>

This is an example of a bad change, IMHO.  The original was written in
elegant prose.  The new version is just two short sentences.

--94eb2c030a10207d6305606efbb1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div dir=3D"auto" style=3D"font-family:sans-serif">Hi,</d=
iv><div dir=3D"auto" style=3D"font-family:sans-serif"><br></div><span style=
=3D"font-family:sans-serif">I am outside so can&#39;t use mutt. Sorry for t=
hat.</span><div dir=3D"auto" style=3D"font-family:sans-serif"><br></div><di=
v dir=3D"auto" style=3D"font-family:sans-serif">This comment is going to be=
 replaced in the 2nd set anyway because the whole function will be replaced=
.</div><div dir=3D"auto" style=3D"font-family:sans-serif"><br></div><div di=
r=3D"auto" style=3D"font-family:sans-serif">And please point out all commen=
ts that you think I need to rework. I am totally fine to do that. I don&#39=
;t think every single one is bad. And this patch has to go in as it also ad=
ds a lot of new comments.</div><div dir=3D"auto" style=3D"font-family:sans-=
serif"><br></div><div dir=3D"auto" style=3D"font-family:sans-serif">Thank y=
ou for your effort</div><div dir=3D"auto" style=3D"font-family:sans-serif">=
Nicolin</div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote=
">On Dec 15, 2017 20:43, &quot;Timur Tabi&quot; &lt;<a href=3D"mailto:timur=
@tabi.org">timur@tabi.org</a>&gt; wrote:<br type=3D"attribution"><blockquot=
e class=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex"><div class=3D"quoted-text">On 12/13/17 5:18 PM, Nicolin Chen=
 wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * We are running on a SoC which does not suppo=
rt online SSI<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * reconfiguration, so we have to enable all ne=
cessary flags at once<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * even if we do not use them later (capture an=
d playback configuration)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Online configuration is not supported<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Enable or Disable all necessary bits at once=
<br>
</blockquote>
<br></div>
This is an example of a bad change, IMHO.=C2=A0 The original was written in=
 elegant prose.=C2=A0 The new version is just two short sentences.<br>
</blockquote></div><br></div>

--94eb2c030a10207d6305606efbb1--
