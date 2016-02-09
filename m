Return-Path: <michael.heltne@gmail.com>
Received: from mail-yw0-x22f.google.com (mail-yw0-x22f.google.com
 [IPv6:2607:f8b0:4002:c05::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1B2071A0191
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 13:28:02 +1100 (AEDT)
Received: by mail-yw0-x22f.google.com with SMTP id q190so117451715ywd.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Feb 2016 18:28:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <56B943E3.1010407@daenzer.net>
References: <CANtoAtPSgkxEvAdOs-gZGOECYN8OFTvwRrsg+US41ji1fGEDLA@mail.gmail.com>
 <56B865A0.4060707@daenzer.net>
 <CAK90Sjk-AXekt_WKSk53GUeUZk-T4WhrwoNuwPA5N4pX2OPceA@mail.gmail.com>
 <CANtoAtPoYodsC3u-BOi8HM=ew03CX32BBKvFXwZJ4wbSkMWRZQ@mail.gmail.com>
 <56B943E3.1010407@daenzer.net>
Date: Tue, 9 Feb 2016 03:27:59 +0100
Message-ID: <CANtoAtNUbSdS0GgoSGUPK4sRsXOhLtNmPqbFFaQ0xW0gGecCRA@mail.gmail.com>
Subject: Re: PowerPC agpmode issues
From: Mike <michael.heltne@gmail.com>
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Pranith Kumar <bobby.prani@gmail.com>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>,
 Boris Reinhard <reinhard.boris@googlemail.com>
Content-Type: multipart/alternative; boundary=001a114e55fae7fe00052b4d1069
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a114e55fae7fe00052b4d1069
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Ok, so its quirks to be added then? Something not implemented in KMS that
was in UMS?

Reports are that the same issue exsist on PPC Amiga Ones with a VIA
chipset, and the Pegasos 2 with the Artica s chipset, i posted a mail from
detailiing that.

Sure that might be it, but i get different results trying agpmode=3D1-2-4, =
2
gave a noisy screen before the hard crash. i find it rather impossible to
debug at all as the crash happens so fast no logs seem to be written.. I
think i would need serial...

I'd personally love nothing more then to see support restored and a default
as expected working condition ought be the minimum requirement. I use a
powerbook a1106, 5,6. With a 5,8 on the way. Those are the last two
revision powerbooks in the 15" series. In swrast they become useless,
impossible to use for any productivity. Most people trying to use linux on
ppc for personal use come in macs, with the exception of the Amiga PPC
crowd now running their amcc 440/460ex or e600 based x500/5000, all of
which have of course pci-e more cores and more threads. Yet struggle even
with regressions left and right to keep up with the single core performance
of the G4's. Sure it's pushing 10 years , but it's the only alternative if
one wishes to remain mobile.
On 9 Feb 2016 02:41, "Michel D=C3=A4nzer" <michel@daenzer.net> wrote:

> On 08.02.2016 22:28, Mike wrote:
> > Certainly 750~800 fps in glxgears vs 3000+ in debian squeeze, i cant
> > bring myself to say that it's an acceptable situation no matter how
> > tired i am of the problem knowing how well the setup could do. It's
> > clear that the implementation is broken for everything but x86, [...]
>
> Why is that? It was working fine on my last-gen PowerBook. AFAIK Darwin
> / OS X never used anything but a static AGP GART mapping though, so it
> seems very likely that the issues with older UniNorth revisions are
> simply due to the hardware being unable to support the usage patterns of
> modern GPU drivers.
>
> That said, if you guys have specific suggestions for a "proper"
> solution, nobody's standing in your way.
>
>
> --
> Earthling Michel D=C3=A4nzer               |               http://www.amd=
.com
> Libre software enthusiast             |             Mesa and X developer
>

--001a114e55fae7fe00052b4d1069
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Ok, so its quirks to be added then? Something not implemente=
d in KMS that was in UMS?</p>
<p dir=3D"ltr">Reports are that the same issue exsist on PPC Amiga Ones wit=
h a VIA chipset, and the Pegasos 2 with the Artica s chipset, i posted a ma=
il from detailiing that. </p>
<p dir=3D"ltr">Sure that might be it, but i get different results trying ag=
pmode=3D1-2-4, 2 gave a noisy screen before the hard crash. i find it rathe=
r impossible to debug at all as the crash happens so fast no logs seem to b=
e written.. I think i would need serial... </p>
<p dir=3D"ltr">I&#39;d personally love nothing more then to see support res=
tored and a default as expected working condition ought be the minimum requ=
irement. I use a powerbook a1106, 5,6. With a 5,8 on the way. Those are the=
 last two revision powerbooks in the 15&quot; series. In swrast they become=
 useless, impossible to use for any productivity. Most people trying to use=
 linux on ppc for personal use come in macs, with the exception of the Amig=
a PPC crowd now running their amcc 440/460ex or e600 based x500/5000, all o=
f which have of course pci-e more cores and more threads. Yet struggle even=
 with regressions left and right to keep up with the single core performanc=
e of the G4&#39;s. Sure it&#39;s pushing 10 years , but it&#39;s the only a=
lternative if one wishes to remain mobile.=C2=A0=C2=A0 </p>
<div class=3D"gmail_quote">On 9 Feb 2016 02:41, &quot;Michel D=C3=A4nzer&qu=
ot; &lt;<a href=3D"mailto:michel@daenzer.net">michel@daenzer.net</a>&gt; wr=
ote:<br type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 08.02.2016 2=
2:28, Mike wrote:<br>
&gt; Certainly 750~800 fps in glxgears vs 3000+ in debian squeeze, i cant<b=
r>
&gt; bring myself to say that it&#39;s an acceptable situation no matter ho=
w<br>
&gt; tired i am of the problem knowing how well the setup could do. It&#39;=
s<br>
&gt; clear that the implementation is broken for everything but x86, [...]<=
br>
<br>
Why is that? It was working fine on my last-gen PowerBook. AFAIK Darwin<br>
/ OS X never used anything but a static AGP GART mapping though, so it<br>
seems very likely that the issues with older UniNorth revisions are<br>
simply due to the hardware being unable to support the usage patterns of<br=
>
modern GPU drivers.<br>
<br>
That said, if you guys have specific suggestions for a &quot;proper&quot;<b=
r>
solution, nobody&#39;s standing in your way.<br>
<br>
<br>
--<br>
Earthling Michel D=C3=A4nzer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=
=3D"http://www.amd.com" rel=3D"noreferrer" target=3D"_blank">http://www.amd=
.com</a><br>
Libre software enthusiast=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Mesa and X developer<br>
</blockquote></div>

--001a114e55fae7fe00052b4d1069--
