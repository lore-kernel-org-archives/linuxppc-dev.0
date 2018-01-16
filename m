Return-Path: <madskateman@gmail.com>
Received: from mail-qk0-x229.google.com (mail-qk0-x229.google.com
 [IPv6:2607:f8b0:400d:c09::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLjg44p5vzF0Wk
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 08:15:28 +1100 (AEDT)
Received: by mail-qk0-x229.google.com with SMTP id z12so22624268qkf.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jan 2018 13:15:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180116210048.GB29888@lunn.ch>
References: <CAHkrCmFCzPd_a1UmyfuZHKM4hXvou0uO0FYoG5bd_fxE8QMueg@mail.gmail.com>
 <DB3PR0402MB3849EEF00D71FF7A230B70C3ECEB0@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <1516035556.18795.71.camel@infinera.com> <20180116143836.GC22903@lunn.ch>
 <1516125454.18795.87.camel@infinera.com>
 <CAHkrCmE5GzvkKTm5=Yy5QxKOL_OJn+9xrWLjhH=Zayg_nsQt7A@mail.gmail.com>
 <20180116210048.GB29888@lunn.ch>
From: mad skateman <madskateman@gmail.com>
Date: Tue, 16 Jan 2018 22:15:25 +0100
Message-ID: <CAHkrCmF21tEOcuRYNVmWdiyJCACo86t=DLrU9OcGS2Lgp-P8aQ@mail.gmail.com>
Subject: Re: DPAA Ethernet traffice troubles with Linux kernel
To: Andrew Lunn <andrew@lunn.ch>,
 Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "madalin.bucur@nxp.com" <madalin.bucur@nxp.com>,
 Christian Zigotzky <chzigotzky@xenosoft.de>
Content-Type: multipart/alternative; boundary="001a114a8236bac03a0562eb3add"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a114a8236bac03a0562eb3add
Content-Type: text/plain; charset="UTF-8"

This makes me really start to wonder if the mainboard producer Varisys/AEON
has Purchased MAC`s for these boards at IEEE

Uboot system info gives for both MAC adresses the value NULL ... and i have
checked the mainboard for any stickers regarding the MAC adresses but there
is none..

I also tried to just create a ethaddr, eth1addr and eth2addr as mention on
the Wiki..but no luck

http://wiki.amiga.org/index.php?title=AmigaONE_X5000



On Tue, Jan 16, 2018 at 10:00 PM, Andrew Lunn <andrew@lunn.ch> wrote:

> > *Given this if we disable that bit, we get the matching "Universally
> > Administered Address" 00000100 (Binary), 04 (Hex) -> "04:00:00", hence my
> > question:"*
> >
> > This has something to do with the MAC adresses being locally administered
> > .. and since whe can use Uboot and choose any Mac addr we want, this
> could
> > make sense..
>
> You cannot just flip this bit. Universally administered addresses are
> allocated by the IEEE. You need to purchase them from the IEEE.
> Locally administered MAC addresses you can use, and any sane DHCP
> server should work with them.
>
> This also does not fit with mii-tool -R observation.
>
>      Andrew
>

--001a114a8236bac03a0562eb3add
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">This makes me really start to wonder if the mainboard prod=
ucer Varisys/AEON has Purchased MAC`s for these boards at IEEE<div><br></di=
v><div>Uboot system info gives for both MAC adresses the value NULL ... and=
 i have checked the mainboard for any stickers regarding the MAC adresses b=
ut there is none..</div><div><br></div><div>I also tried to just create a e=
thaddr, eth1addr and eth2addr as mention on the Wiki..but no luck</div><div=
><br></div><div><a href=3D"http://wiki.amiga.org/index.php?title=3DAmigaONE=
_X5000">http://wiki.amiga.org/index.php?title=3DAmigaONE_X5000</a><br></div=
><div><br></div><div><br></div></div><div class=3D"gmail_extra"><br><div cl=
ass=3D"gmail_quote">On Tue, Jan 16, 2018 at 10:00 PM, Andrew Lunn <span dir=
=3D"ltr">&lt;<a href=3D"mailto:andrew@lunn.ch" target=3D"_blank">andrew@lun=
n.ch</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">&gt; *Given th=
is if we disable that bit, we get the matching &quot;Universally<br>
&gt; Administered Address&quot; 00000100 (Binary), 04 (Hex) -&gt; &quot;04:=
00:00&quot;, hence my<br>
&gt; question:&quot;*<br>
&gt;<br>
&gt; This has something to do with the MAC adresses being locally administe=
red<br>
&gt; .. and since whe can use Uboot and choose any Mac addr we want, this c=
ould<br>
&gt; make sense..<br>
<br>
You cannot just flip this bit. Universally administered addresses are<br>
allocated by the IEEE. You need to purchase them from the IEEE.<br>
Locally administered MAC addresses you can use, and any sane DHCP<br>
server should work with them.<br>
<br>
This also does not fit with mii-tool -R observation.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
=C2=A0 =C2=A0 =C2=A0Andrew<br>
</font></span></blockquote></div><br></div>

--001a114a8236bac03a0562eb3add--
