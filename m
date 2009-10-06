Return-Path: <r.goyet@gmail.com>
Received: from mail-fx0-f214.google.com (mail-fx0-f214.google.com
	[209.85.220.214]) by ozlabs.org (Postfix) with ESMTP id 8D551B7BFB
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  6 Oct 2009 22:44:11 +1100 (EST)
Received: by fxm10 with SMTP id 10so3520427fxm.8
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 06 Oct 2009 04:44:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1254826247.4278.985.camel@thor.local>
References: <8028e5750910060216x134a8a9cm461fa5a6e87eb6bb@mail.gmail.com>
	<1254826247.4278.985.camel@thor.local>
Date: Tue, 6 Oct 2009 13:44:08 +0200
Message-ID: <8028e5750910060444jd63dffcl6f57bb15c708e4c6@mail.gmail.com>
Subject: Re: SMU-base PowerMac and server_mode
From: Romain Goyet <r.goyet@gmail.com>
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Content-Type: multipart/alternative; boundary=0015174757428e6239047542bf62
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0015174757428e6239047542bf62
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Michel :-)
Acutally I didn't figure it out by myself :
http://saintaardvarkthecarpeted.com/blog/archive/2005/02/THE_WINE_OF_BOOT.h=
tml

However, here's my 2 cents about it :
1/ The fix (removing "screen" line in ofboot.b on yaboot partition) doesn't
work with all versions of the yaboot binary. Works with the one from Debian=
.
Doesn't with yaboot-static on GentooPPC64. But you still can fetch the righ=
t
binary from the .deb archive
2/ Another possible solution can be to hook up a DVI-> VGA adapter, and plu=
g
in a resistor between the right pins (don't remember which) so that yaboot
thinks a display is plugged in

Hope that helps !!

 - Romain

2009/10/6 Michel D=C3=A4nzer <michel@daenzer.net>

> On Tue, 2009-10-06 at 11:16 +0200, Romain Goyet wrote:
> >
> >   I have this Quad G5 here, running GentooPPC64. Runs fine. Had a hard
> > time getting it to boot without a screen attached, but I eventually
> > managed to (yaboot was the culprit).
>
> Out of curiosity, how did you solve this? I still have an unused monitor
> connected to mine...
>
> --
> Earthling Michel D=C3=A4nzer           |                http://www.vmware=
.com
> Libre software enthusiast         |          Debian, X and DRI developer
>

--0015174757428e6239047542bf62
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Michel :-)<div><br></div><div>Acutally I didn&#39;t figure it out by mys=
elf :</div><div><a href=3D"http://saintaardvarkthecarpeted.com/blog/archive=
/2005/02/THE_WINE_OF_BOOT.html">http://saintaardvarkthecarpeted.com/blog/ar=
chive/2005/02/THE_WINE_OF_BOOT.html</a></div>
<div><br></div><div>However, here&#39;s my 2 cents about it :</div><div>1/ =
The fix (removing &quot;screen&quot; line in ofboot.b on yaboot partition) =
doesn&#39;t work with all versions of the yaboot binary. Works with the one=
 from Debian. Doesn&#39;t with yaboot-static on GentooPPC64. But you still =
can fetch the right binary from the .deb archive</div>
<div>2/ Another possible solution can be to hook up a DVI-&gt; VGA adapter,=
 and plug in a resistor between the right pins (don&#39;t remember which) s=
o that yaboot thinks a display is plugged in</div><div><br></div><div>Hope =
that helps !!</div>
<div><br></div><div>=C2=A0- Romain<br><br><div class=3D"gmail_quote">2009/1=
0/6 Michel D=C3=A4nzer <span dir=3D"ltr">&lt;<a href=3D"mailto:michel@daenz=
er.net">michel@daenzer.net</a>&gt;</span><br><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;=
">
<div class=3D"im">On Tue, 2009-10-06 at 11:16 +0200, Romain Goyet wrote:<br=
>
&gt;<br>
</div><div class=3D"im">&gt; =C2=A0 I have this Quad G5 here, running Gento=
oPPC64. Runs fine. Had a hard<br>
&gt; time getting it to boot without a screen attached, but I eventually<br=
>
&gt; managed to (yaboot was the culprit).<br>
<br>
</div>Out of curiosity, how did you solve this? I still have an unused moni=
tor<br>
connected to mine...<br>
<font color=3D"#888888"><br>
--<br>
Earthling Michel D=C3=A4nzer =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://www.vmwar=
e.com" target=3D"_blank">http://www.vmware.com</a><br>
Libre software enthusiast =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0Debian, X and DRI developer<br>
</font></blockquote></div><br></div>

--0015174757428e6239047542bf62--
