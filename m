Return-Path: <pantelis.antoniou@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.199])
	by ozlabs.org (Postfix) with ESMTP id 6AE4967B27
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Feb 2006 03:17:48 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id 57so1089520wri
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Feb 2006 08:17:47 -0800 (PST)
Message-ID: <449c76a00602140817k4cf1af22w6d6c930a9d847ba@mail.gmail.com>
Date: Tue, 14 Feb 2006 11:17:46 -0500
From: Pantelis Antoniou <pantelis.antoniou@gmail.com>
To: Laurent Lagrange <lagrange@fr.oleane.com>
Subject: Re: Gianfar is slower than fcc_enet on MPC8541 ???
In-Reply-To: <000201c63181$cf2c3180$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_20322_10089333.1139933866122"
References: <449c76a00602140728g3a9eb46sd70f23b894c4b96@mail.gmail.com>
	<000201c63181$cf2c3180$5201a8c0@GEG2400>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_20322_10089333.1139933866122
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Can you provide some more information?

Actual timings, and a tcpdump fragment?

On 2/14/06, Laurent Lagrange <lagrange@fr.oleane.com> wrote:
>
> Hi Pantelis,
>
> Thanks for the express reply.
>
> I know that what I say seems incredible. But I don't understand what NAPI
> does.
> My measure is very simple. I display a message on the client when 1000
> exchanges are done.
> I already check the ifconfig stats on the board after some seconds.
> The measures seems the same with or without NAPI.
>
> More details ?
> Thanks again
> Laurent
>
>
>
> -----Message d'origine-----
> *De :* Pantelis Antoniou [mailto:pantelis.antoniou@gmail.com]
> *Envoy=E9 :* mar. 14 f=E9vrier 2006 16:29
> *=C0 :* Laurent Lagrange
> *Cc :* linuxppc-embedded@ozlabs.org
> *Objet :* Re: Gianfar is slower than fcc_enet on MPC8541 ???
>
> Hi Laurent,
>
> I found that pretty hard to believe.
>
> What are you measuring exactly?
>
> Speed of replies? If so it's explainable since the TSECs use
> NAPI.
>
> Regards
>
> Pantelis
>
> On 2/14/06, Laurent Lagrange <lagrange@fr.oleane.com> wrote:
> >
> >
> > Hello,
> >
> > I work on a cutom MPC8541 board with Linux 2.6.9.
> > The kernel activates the L1 cache (instructions and data)
> > and the L2 cache (entirely used as cache and not as sram).
> >
> > I configure
> > 1 FCC (FCC1),
> > 2 TSECs with or without NAPI (no effect) but without stashing in L2
> > sram.
> > All PHYs are automatically configured in 100MB full duplex.
> >
> >         eth0: Gianfar Ethernet Controller Version 1.1, 00:10:cd:48:48:e=
0
> >         eth0: Running with NAPI disabled
> >         eth0: 64/64 RX/TX BD ring size
> >         eth1: Gianfar Ethernet Controller Version 1.1, 00:10:cd:48:48:e=
1
> >         eth1: Running with NAPI disabled
> >         eth1: 64/64 RX/TX BD ring size
> >         eth2: FCC ENET Version custom, 00:10:cd:48:48:e2
> >
> > Then I launch 3 simple TCP servers, one on each ports.
> >
> > From remote machines I runs 3 TCP clients.
> > The client sends messages of 1000 bytes,
> > The server receives and echoes the message
> > The client receives the echoed message, check the content
> > and sends a new message again.
> >
> > The result is that the 2 TSECs are 2 times slower than the FCC.
> >
> > If I run a "top" application on the board, I use less than 10% of the
> > CPU
> > Each port consumes about 1/3 of the CPU.
> >
> > Any idea on how to configure the gianfar driver ?
> >
> > Thanks
> > Laurent
> >
> >
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >
>
>

------=_Part_20322_10089333.1139933866122
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Can you provide some more information?<br><br>Actual timings, and a tcpdump=
 fragment?<br><br><div><span class=3D"gmail_quote">On 2/14/06, <b class=3D"=
gmail_sendername">Laurent Lagrange</b> &lt;<a href=3D"mailto:lagrange@fr.ol=
eane.com">
lagrange@fr.oleane.com</a>&gt; wrote:</span><blockquote class=3D"gmail_quot=
e" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt =
0.8ex; padding-left: 1ex;">






<div><span><font color=3D"#0000ff" face=3D"Arial" size=3D"2">Hi=20
Pantelis,</font></span></div>
<div><span><font color=3D"#0000ff" face=3D"Arial" size=3D"2"></font></span>=
&nbsp;</div>
<div><span><font color=3D"#0000ff" face=3D"Arial" size=3D"2">Thanks=20
for the express reply.</font></span></div>
<div><span><font color=3D"#0000ff" face=3D"Arial" size=3D"2"></font></span>=
&nbsp;</div>
<div><span><font color=3D"#0000ff" face=3D"Arial" size=3D"2">I know=20
that what I say seems incredible. </font></span><span><font color=3D"#0000f=
f" face=3D"Arial" size=3D"2">But I don't=20
understand what NAPI does.</font></span></div>
<div><span><font color=3D"#0000ff" face=3D"Arial" size=3D"2">My=20
measure is very simple. I display a message </font></span><span><font color=
=3D"#0000ff" face=3D"Arial" size=3D"2">on the client=20
when 1000 exchanges are done.</font></span></div>
<div><span><font color=3D"#0000ff" face=3D"Arial" size=3D"2">I=20
already check the ifconfig stats on the board after some=20
seconds.</font></span></div>
<div><span><font color=3D"#0000ff" face=3D"Arial" size=3D"2">The=20
measures seems the same with or without NAPI.</font></span></div>
<div><span><font color=3D"#0000ff" face=3D"Arial" size=3D"2"></font></span>=
&nbsp;</div>
<div><span><font color=3D"#0000ff" face=3D"Arial" size=3D"2">More=20
details ?</font></span></div>
<div><span><font color=3D"#0000ff" face=3D"Arial" size=3D"2">Thanks=20
again</font></span></div>
<div><span><font color=3D"#0000ff" face=3D"Arial" size=3D"2">Laurent</font>=
</span></div>
<div><span><font color=3D"#0000ff" face=3D"Arial" size=3D"2"></font></span>=
&nbsp;</div>
<div><span><font color=3D"#0000ff" face=3D"Arial" size=3D"2"></font></span>=
&nbsp;</div>
<blockquote style=3D"border-left: 2px solid rgb(0, 0, 255); padding-left: 5=
px; margin-left: 5px;">
  <div dir=3D"ltr" align=3D"left"><font face=3D"Tahoma" size=3D"2">-----Mes=
sage d'origine-----<br><b>De&nbsp;:</b> Pantelis Antoniou=20
  [mailto:<a href=3D"mailto:pantelis.antoniou@gmail.com" target=3D"_blank" =
onclick=3D"return top.js.OpenExtLink(window,event,this)">pantelis.antoniou@=
gmail.com</a>]<br><b>Envoy=E9&nbsp;:</b> mar. 14 f=E9vrier=20
  2006 16:29<br><b>=C0&nbsp;:</b> Laurent Lagrange<br><b>Cc&nbsp;:</b>=20
  <a href=3D"mailto:linuxppc-embedded@ozlabs.org" target=3D"_blank" onclick=
=3D"return top.js.OpenExtLink(window,event,this)">linuxppc-embedded@ozlabs.=
org</a><br><b>Objet&nbsp;:</b> Re: Gianfar is slower than=20
  fcc_enet on MPC8541 ???<br><br></font></div><div><span class=3D"e" id=3D"=
q_1096952d8b1af181_1">Hi Laurent,<br><br>I found that=20
  pretty hard to believe.<br><br>What are you measuring exactly?<br><br>Spe=
ed of=20
  replies? If so it's explainable since the TSECs=20
  use<br>NAPI.<br><br>Regards<br><br>Pantelis<br><br>
  <div><span class=3D"gmail_quote">On 2/14/06, <b class=3D"gmail_sendername=
">Laurent=20
  Lagrange</b> &lt;<a href=3D"mailto:lagrange@fr.oleane.com" target=3D"_bla=
nk" onclick=3D"return top.js.OpenExtLink(window,event,this)">lagrange@fr.ol=
eane.com</a>&gt;=20
  wrote:</span>
  <blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204=
, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>Hello,<br><=
br>I=20
    work on a cutom MPC8541 board with Linux 2.6.9.<br>The kernel activates=
 the=20
    L1 cache (instructions and data)<br>and the L2 cache (entirely used as =
cache=20
    and not as sram).<br><br>I configure<br>1 FCC (FCC1), <br>2 TSECs with =
or=20
    without NAPI (no effect) but without stashing in L2 sram.<br>All PHYs a=
re=20
    automatically configured in 100MB full=20
    duplex.<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;eth0: Gi=
anfar=20
    Ethernet Controller Version 1.1,=20
    00:10:cd:48:48:e0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;et=
h0:=20
    Running with NAPI=20
    disabled<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;eth0: 64/64=
=20
    RX/TX BD ring size<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;e=
th1:=20
    Gianfar Ethernet Controller Version 1.1,=20
    00:10:cd:48:48:e1<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;et=
h1:=20
    Running with NAPI=20
    disabled<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;eth1: 64/64=
=20
    RX/TX BD ring size <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
eth2:=20
    FCC ENET Version custom, 00:10:cd:48:48:e2<br><br>Then I launch 3 simpl=
e TCP=20
    servers, one on each ports.<br><br>From remote machines I runs 3 TCP=20
    clients.<br>The client sends messages of 1000 bytes,<br>The server rece=
ives=20
    and echoes the message <br>The client receives the echoed message, chec=
k the=20
    content<br>and sends a new message again.<br><br>The result is that the=
 2=20
    TSECs are 2 times slower than the FCC.<br><br>If I run a &quot;top&quot=
; application=20
    on the board, I use less than 10% of the CPU <br>Each port consumes abo=
ut=20
    1/3 of the CPU.<br><br>Any idea on how to configure the gianfar driver=
=20
    ?<br><br>Thanks<br>Laurent<br><br><br>_________________________________=
______________<br>Linuxppc-embedded=20
    mailing list<br><a href=3D"mailto:Linuxppc-embedded@ozlabs.org" target=
=3D"_blank" onclick=3D"return top.js.OpenExtLink(window,event,this)">Linuxp=
pc-embedded@ozlabs.org</a><br><a href=3D"https://ozlabs.org/mailman/listinf=
o/linuxppc-embedded" target=3D"_blank" onclick=3D"return top.js.OpenExtLink=
(window,event,this)">
https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br></blockquote><=
/div><br></span></div></blockquote>

</blockquote></div><br>

------=_Part_20322_10089333.1139933866122--
