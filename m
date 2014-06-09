Return-Path: <blacklites@gmail.com>
Received: from mail-yk0-x231.google.com (mail-yk0-x231.google.com
 [IPv6:2607:f8b0:4002:c07::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 304D71A0039
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 01:28:24 +1000 (EST)
Received: by mail-yk0-f177.google.com with SMTP id 10so1970103ykt.22
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Jun 2014 08:28:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5395CC7C.4040608@Freescale.com>
References: <CAE1uq6vw0VSDUymckX51FyoJ8NH4Gsj3npfiYeZNff1Vq0cKsQ@mail.gmail.com>
 <5395CC7C.4040608@Freescale.com>
Date: Mon, 9 Jun 2014 20:58:21 +0530
Message-ID: <CAE1uq6uSEd+NZW+Q+9V8QqxcEDaiQQmcQTJ1GCrgQGL7N98t_g@mail.gmail.com>
Subject: Re: <fsl,qman-channel-id> in dts file
From: Tony <blacklites@gmail.com>
To: Emil Medve <Emilian.Medve@freescale.com>
Content-Type: multipart/alternative; boundary=14dae9d679f483b39904fb68dc52
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--14dae9d679f483b39904fb68dc52
Content-Type: text/plain; charset=UTF-8

Thank Emil.

Where can i find the details about a 'diff' of qman revisions ? The code i
ported doesnt support latest qman revision (REV3). Can i still work on qman
REV1.1 for all the latest targets ? (read t-series)

Regards


On Mon, Jun 9, 2014 at 8:32 PM, Emil Medve <Emilian.Medve@freescale.com>
wrote:

> Hello Tony,
>
>
> On 06/09/2014 06:43 AM, Tony wrote:
> > How's the fsl,qman-channel-id value different for different targets ?
>
> Channel ids are assigned in hardware
>
> > Is there any document on how this value is achieved ?
>
> They are described in the RM of each SoC and in the DPAA RM
>
> > Or can it be any value ???
>
> Nope. It must be the right value or frames will end up in the wrong
> portal or worse
>
>
> Cheers,
>

--14dae9d679f483b39904fb68dc52
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Thank Emil.<br><br></div>Where can i find t=
he details about a=20
&#39;diff&#39; of qman revisions ? The code i ported doesnt support latest =
qman=20
revision (REV3). Can i still work on qman REV1.1 for all the latest targets=
 ? (read t-series)<br></div><br></div>Regards<br></div><div class=3D"gmail_=
extra"><br><br><div class=3D"gmail_quote">On Mon, Jun 9, 2014 at 8:32 PM, E=
mil Medve <span dir=3D"ltr">&lt;<a href=3D"mailto:Emilian.Medve@freescale.c=
om" target=3D"_blank">Emilian.Medve@freescale.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hello Tony,<br>
<div class=3D""><br>
<br>
On 06/09/2014 06:43 AM, Tony wrote:<br>
&gt; How&#39;s the fsl,qman-channel-id value different for different target=
s ?<br>
<br>
</div>Channel ids are assigned in hardware<br>
<div class=3D""><br>
&gt; Is there any document on how this value is achieved ?<br>
<br>
</div>They are described in the RM of each SoC and in the DPAA RM<br>
<div class=3D""><br>
&gt; Or can it be any value ???<br>
<br>
</div>Nope. It must be the right value or frames will end up in the wrong<b=
r>
portal or worse<br>
<br>
<br>
Cheers,<br>
</blockquote></div><br></div>

--14dae9d679f483b39904fb68dc52--
