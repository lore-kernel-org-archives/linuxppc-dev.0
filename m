Return-Path: <r.goyet@gmail.com>
Received: from mail-fx0-f214.google.com (mail-fx0-f214.google.com
	[209.85.220.214]) by ozlabs.org (Postfix) with ESMTP id F3B39B7B8B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  7 Oct 2009 22:25:16 +1100 (EST)
Received: by fxm10 with SMTP id 10so4482567fxm.8
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 07 Oct 2009 04:25:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20091006160749.GA29195@lixom.net>
References: <8028e5750910060216x134a8a9cm461fa5a6e87eb6bb@mail.gmail.com>
	<1254823882.6035.5.camel@pasglop> <20091006160749.GA29195@lixom.net>
Date: Wed, 7 Oct 2009 13:25:13 +0200
Message-ID: <8028e5750910070425v45a3e036p1444a8ee5937a4bb@mail.gmail.com>
Subject: Re: SMU-base PowerMac and server_mode
From: Romain Goyet <r.goyet@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=000e0ce0eea8bd327904755699c4
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--000e0ce0eea8bd327904755699c4
Content-Type: text/plain; charset=UTF-8

On Tue, Oct 6, 2009 at 6:07 PM, Olof Johansson <olof@lixom.net> wrote:

> On Tue, Oct 06, 2009 at 09:11:22PM +1100, Benjamin Herrenschmidt wrote:
> > On Tue, 2009-10-06 at 11:16 +0200, Romain Goyet wrote:
> > > Hi there,
> > >
> > >
> > >   I have this Quad G5 here, running GentooPPC64. Runs fine. Had a hard
> > > time getting it to boot without a screen attached, but I eventually
> > > managed to (yaboot was the culprit). However, this machine is
> > > SMU-based, and I couldn't find a way to enable the equivalent of the
> > > PMU's "server_mode" (i.e. automatically reboot after a power failure).
> > > Is there any known way to do that ?
> >
> > I'm pretty sure I reverse engineered the necessary command a while back
> > and somebody wrote a userland tool to set it, but I can't find it
> > anymore :-)
>
> Yeah, I had one but I have since lost it.  I suspect it was on the
> drive of my second quad that I wiped before I sold it, thinking there
> was nothing of value on it. :(
>
>
> -Olof
>

Ha, that's too bad. Do you know if it might be online somewhere ? Maybe an
idea of the right keywords to google ?

Thanks !

 - Romain

--000e0ce0eea8bd327904755699c4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Tue, Oct 6, 2009 at 6:07 PM, Olof Johansson <=
span dir=3D"ltr">&lt;<a href=3D"mailto:olof@lixom.net">olof@lixom.net</a>&g=
t;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
<div><div></div><div class=3D"h5">On Tue, Oct 06, 2009 at 09:11:22PM +1100,=
 Benjamin Herrenschmidt wrote:<br>
&gt; On Tue, 2009-10-06 at 11:16 +0200, Romain Goyet wrote:<br>
&gt; &gt; Hi there,<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; =C2=A0 I have this Quad G5 here, running GentooPPC64. Runs fine. =
Had a hard<br>
&gt; &gt; time getting it to boot without a screen attached, but I eventual=
ly<br>
&gt; &gt; managed to (yaboot was the culprit). However, this machine is<br>
&gt; &gt; SMU-based, and I couldn&#39;t find a way to enable the equivalent=
 of the<br>
&gt; &gt; PMU&#39;s &quot;server_mode&quot; (i.e. automatically reboot afte=
r a power failure).<br>
&gt; &gt; Is there any known way to do that ?<br>
&gt;<br>
&gt; I&#39;m pretty sure I reverse engineered the necessary command a while=
 back<br>
&gt; and somebody wrote a userland tool to set it, but I can&#39;t find it<=
br>
&gt; anymore :-)<br>
<br>
</div></div>Yeah, I had one but I have since lost it. =C2=A0I suspect it wa=
s on the<br>
drive of my second quad that I wiped before I sold it, thinking there<br>
was nothing of value on it. :(<br>
<font color=3D"#888888"><br>
<br>
-Olof<br>
</font></blockquote></div><br><div>Ha, that&#39;s too bad. Do you know if i=
t might be online somewhere ? Maybe an idea of the right keywords to google=
 ?</div><div><br></div><div>Thanks !</div><div><br></div><div>=C2=A0- Romai=
n<br>
<br></div><div><br></div>

--000e0ce0eea8bd327904755699c4--
