Return-Path: <john.d@servergy.com>
Received: from mail-oa0-f47.google.com (mail-oa0-f47.google.com
 [209.85.219.47])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E20F62C00BE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 06:47:57 +1100 (EST)
Received: by mail-oa0-f47.google.com with SMTP id m1so19686830oag.20
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Feb 2014 11:47:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1392665821.6733.630.camel@snotra.buserror.net>
References: <CAGtOQbTRSk32p7U=v9V9GPb_ro+WYbKLLCCfrmdypePcHA++mw@mail.gmail.com>
 <CAP=VYLpgMYaSVjTwJ2Q15XB+nozz=OhAPU85Nb9xG_FdP5dcyA@mail.gmail.com>
 <1392665821.6733.630.camel@snotra.buserror.net>
Date: Tue, 18 Feb 2014 13:47:54 -0600
Message-ID: <CAGtOQbQXLpdzAzxgwtzisEJ1MAeND8057103oUO-v9x4Ki8qYQ@mail.gmail.com>
Subject: Re: Anyone using SysRQ key sequences on console serial port ?
From: John Donnelly <john.d@servergy.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: multipart/alternative; boundary=001a11c2ec9a54869b04f2b38c16
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a11c2ec9a54869b04f2b38c16
Content-Type: text/plain; charset=ISO-8859-1

I am enable to get one keyboard sequence responded to with the noted change
in the dts .

 for instance:

   SysRQ ( Break)   c

  Panics .. Which is a good response, and since it doesn't require a return
to user mode ( I suspect )  it appears to work.

Any other requests fail to report any information :

 SysRQ (break )  l - list active processes
                         m - list memory

  Any additional SysRQ are ignored., and the system appears hung.

 On an reference Intel platform, multiple SyqRQ can be issued and the
system remains healthy .









On Mon, Feb 17, 2014 at 1:37 PM, Scott Wood <scottwood@freescale.com> wrote:

> On Sun, 2014-02-16 at 10:56 -0500, Paul Gortmaker wrote:
> > On Fri, Feb 14, 2014 at 3:42 PM, John Donnelly <john.d@servergy.com>
> wrote:
> > > Hi,
> > >
> > >  I tried using the SysRq hotkey sequence on a serial console -
> > > 3.11.0-5-powerpc-e500mc system, by issuing a " break " and the system
> > > immediately wedges after displaying "SysRQ : HELP : " using both
> "Putty" and
> > > "Teraterm"  terminal emulators. I know the system is dead because my
> ssh
> > > sessions stopped too.
> >
> > Yes it does work -- or at least it _did_ work.  Make sure your dts has
> an entry
> >
> >                         compatible = "fsl,ns16550", "ns16550";
> >
> > since that enables a workaround I'd added for a hardware errata relating
> > to sending breaks over the serial console.   What you describe above
> > makes me think you aren't getting the workaround enabled.
>
> Also make sure CONFIG_SERIAL_8250_FSL is enabled.
>
> -Scott
>
>
>


-- 

*Regards,*
* John.*

*--*

*o* Energy-efficiency is #1 reason data centers look to expand.  -- Digital
Realty Trust
*o* Green Data Centers spending to increase 300% worldwide by 2016.  --
Pike Research
*o *Data Centers have become as vital to the functioni
ng of society as power stations.  -- The Economist

--001a11c2ec9a54869b04f2b38c16
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I am enable to get one keyboard sequence responded to with=
 the noted change in the dts .<div><br></div><div>=A0for instance:=A0</div>=
<div><br></div><div><div>=A0 =A0SysRQ ( Break) =A0 c=A0</div><div><br></div=
><div>=A0 Panics .. Which is a good response, and since it doesn&#39;t requ=
ire a return to user mode ( I suspect ) =A0it appears to work.=A0</div>
<div><br></div><div>Any other requests fail to report any information :=A0<=
/div><div><br></div><div>=A0SysRQ (break ) =A0l - list active processes</di=
v><div>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0m - list memory=
=A0</div><div><br></div><div>=A0 Any additional SysRQ are ignored., and the=
 system appears hung.</div>
<div><br></div><div>=A0On an reference Intel platform, multiple SyqRQ can b=
e issued and the system remains healthy .</div><div><br></div><div><br></di=
v><div><br></div><div>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0</=
div><div>=A0</div><div><br>
</div><div>=A0 =A0 =A0 =A0 =A0=A0</div></div></div><div class=3D"gmail_extr=
a"><br><br><div class=3D"gmail_quote">On Mon, Feb 17, 2014 at 1:37 PM, Scot=
t Wood <span dir=3D"ltr">&lt;<a href=3D"mailto:scottwood@freescale.com" tar=
get=3D"_blank">scottwood@freescale.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">On Sun, 2014-02-16 at 10:56 -0500, Paul Gort=
maker wrote:<br>
&gt; On Fri, Feb 14, 2014 at 3:42 PM, John Donnelly &lt;<a href=3D"mailto:j=
ohn.d@servergy.com">john.d@servergy.com</a>&gt; wrote:<br>
&gt; &gt; Hi,<br>
&gt; &gt;<br>
&gt; &gt; =A0I tried using the SysRq hotkey sequence on a serial console -<=
br>
&gt; &gt; 3.11.0-5-powerpc-e500mc system, by issuing a &quot; break &quot; =
and the system<br>
&gt; &gt; immediately wedges after displaying &quot;SysRQ : HELP : &quot; u=
sing both &quot;Putty&quot; and<br>
&gt; &gt; &quot;Teraterm&quot; =A0terminal emulators. I know the system is =
dead because my ssh<br>
&gt; &gt; sessions stopped too.<br>
&gt;<br>
&gt; Yes it does work -- or at least it _did_ work. =A0Make sure your dts h=
as an entry<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D &quot;f=
sl,ns16550&quot;, &quot;ns16550&quot;;<br>
&gt;<br>
&gt; since that enables a workaround I&#39;d added for a hardware errata re=
lating<br>
&gt; to sending breaks over the serial console. =A0 What you describe above=
<br>
&gt; makes me think you aren&#39;t getting the workaround enabled.<br>
<br>
Also make sure CONFIG_SERIAL_8250_FSL is enabled.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
-Scott<br>
<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div dir=3D"ltr"><div style=3D"font-family:Arial;font-size:12px"><span st=
yle=3D"border-collapse:collapse"><div style=3D"border-collapse:collapse"><d=
iv style=3D"margin:0px;display:inline!important">
<span style=3D"color:rgb(80,0,80);border-collapse:collapse"><font color=3D"=
#67b545"><b><br></b></font></span></div></div><div style=3D"border-collapse=
:collapse"><font color=3D"#67b545"><b>Regards,</b></font></div><div style=
=3D"border-collapse:collapse">
<font color=3D"#67b545"><b>=A0John.</b></font></div><div style=3D"border-co=
llapse:collapse"><font color=3D"#67b545"><b><br></b></font></div><div style=
=3D"border-collapse:collapse"><div style=3D"margin:0px;display:inline!impor=
tant"><span style=3D"color:rgb(80,0,80);border-collapse:collapse"><font col=
or=3D"#67b545"><b>--</b></font></span></div>
</div><div style=3D"border-collapse:collapse"><div style=3D"margin:0px;disp=
lay:inline!important"><span style=3D"color:rgb(80,0,80);border-collapse:col=
lapse"><font color=3D"#67b545"><b><br></b></font></span></div></div><div st=
yle=3D"border-collapse:collapse">
<div style=3D"margin:0px;display:inline!important"><span style=3D"color:rgb=
(80,0,80);border-collapse:collapse"><font color=3D"#67b545"><b>o</b></font>=
=A0</span><span style=3D"border-collapse:collapse"><font color=3D"#000000">=
Energy-efficiency is #1 reason data centers look to expand. =A0-- Digital R=
ealty Trust</font></span></div>
</div><div style=3D"border-collapse:collapse"><div style=3D"margin:0px;disp=
lay:inline!important"><font style=3D"color:rgb(51,204,0)"><b style=3D"color=
:rgb(103,181,69)">o</b>=A0</font><font color=3D"#000000">Green Data Centers=
 spending to increase 300% worldwide by 2016. =A0-- Pike Research</font></d=
iv>
</div></span></div><div style=3D"font-family:Arial;font-size:12px"><div sty=
le=3D"margin:0px"><b style=3D"color:rgb(103,181,69)">o=A0</b><font color=3D=
"#000000">Data Centers have=A0become as vital to the=A0functioni</font><div=
 style=3D"margin:0px;display:inline!important">
<font color=3D"#000000">ng</font><font color=3D"#000000">=A0of society as p=
ower stations. =A0-- The Economist</font></div></div><div style=3D"margin:0=
px"><br></div></div></div>
</div>

--001a11c2ec9a54869b04f2b38c16--
