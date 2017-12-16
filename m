Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-it0-x22e.google.com (mail-it0-x22e.google.com
 [IPv6:2607:f8b0:4001:c0b::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yzJ4R5t9JzDrn8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Dec 2017 17:56:39 +1100 (AEDT)
Received: by mail-it0-x22e.google.com with SMTP id m11so594819iti.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Dec 2017 22:56:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <19ce4850-5561-45b1-3c16-1dd5591ab88a@tabi.org>
References: <1513207108-30430-1-git-send-email-nicoleotsuka@gmail.com>
 <19ce4850-5561-45b1-3c16-1dd5591ab88a@tabi.org>
From: Nicolin Chen <nicoleotsuka@gmail.com>
Date: Fri, 15 Dec 2017 22:56:36 -0800
Message-ID: <CAGoOwPRN8pf2D72E342F+nqcL1quYg4Y3tbr09rU3OW6hypN2w@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] ASoC: fsl_ssi: Clean up - coding style level
To: Timur Tabi <timur@tabi.org>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 fabio.estevam@nxp.com, mail@maciej.szmigiero.name, caleb@crome.org,
 lgirdwood@gmail.com, arnaud.mouiche@invoxia.com, lukma@denx.de,
 kernel@pengutronix.de
Content-Type: multipart/alternative; boundary="94eb2c030a104d1b3f05606f9e29"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--94eb2c030a104d1b3f05606f9e29
Content-Type: text/plain; charset="UTF-8"

Hello Mark,

Can you please take the first two patches since Timur acked? For the rest
ones, we probably still need some discussion.

Thanks
Nicolin


On Dec 15, 2017 20:53, "Timur Tabi" <timur@tabi.org> wrote:

On 12/13/17 5:18 PM, Nicolin Chen wrote:

> Additionally, in order to fix/work-around hardware bugs and design
> flaws, the driver made a lot of compromise so now its program flow
> looks very complicated and it's getting hard to maintain or update.
>
> So I am going to clean up the driver on both coding style level and
> program flow level.
>

I'm okay with everything except patch #3.




On Dec 15, 2017 20:53, "Timur Tabi" <timur@tabi.org> wrote:

On 12/13/17 5:18 PM, Nicolin Chen wrote:

> Additionally, in order to fix/work-around hardware bugs and design
> flaws, the driver made a lot of compromise so now its program flow
> looks very complicated and it's getting hard to maintain or update.
>
> So I am going to clean up the driver on both coding style level and
> program flow level.
>

I'm okay with everything except patch #3.

--94eb2c030a104d1b3f05606f9e29
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div dir=3D"auto">Hello Mark,<div dir=3D"auto"><br></div>=
<div dir=3D"auto">Can you please take the first two patches since Timur ack=
ed? For the rest ones, we probably still need some discussion.</div><div di=
r=3D"auto"><br></div><div dir=3D"auto">Thanks</div><div dir=3D"auto">Nicoli=
n</div><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Dec=
 15, 2017 20:53, &quot;Timur Tabi&quot; &lt;<a href=3D"mailto:timur@tabi.or=
g">timur@tabi.org</a>&gt; wrote:<br type=3D"attribution"><blockquote class=
=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex"><div class=3D"quoted-text">On 12/13/17 5:18 PM, Nicolin Chen wrote:=
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Additionally, in order to fix/work-around hardware bugs and design<br>
flaws, the driver made a lot of compromise so now its program flow<br>
looks very complicated and it&#39;s getting hard to maintain or update.<br>
<br>
So I am going to clean up the driver on both coding style level and<br>
program flow level.<br>
</blockquote>
<br></div>
I&#39;m okay with everything except patch #3.<br>
</blockquote></div><br></div></div><br><div class=3D"gmail_extra" dir=3D"au=
to"><br><div class=3D"gmail_quote">On Dec 15, 2017 20:53, &quot;Timur Tabi&=
quot; &lt;<a href=3D"mailto:timur@tabi.org">timur@tabi.org</a>&gt; wrote:<b=
r type=3D"attribution"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"quoted-text">=
On 12/13/17 5:18 PM, Nicolin Chen wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Additionally, in order to fix/work-around hardware bugs and design<br>
flaws, the driver made a lot of compromise so now its program flow<br>
looks very complicated and it&#39;s getting hard to maintain or update.<br>
<br>
So I am going to clean up the driver on both coding style level and<br>
program flow level.<br>
</blockquote>
<br></div>
I&#39;m okay with everything except patch #3.<br>
</blockquote></div><br></div></div>

--94eb2c030a104d1b3f05606f9e29--
