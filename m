Return-Path: <a.sudheer443@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.157])
	by bilbo.ozlabs.org (Postfix) with ESMTP id F1813B7B69
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Jul 2009 14:07:55 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id l27so1368424fgb.8
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Jul 2009 21:07:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <579B119545DAEF4689C8FBEEFEC5793F01D4FF0A202C@ATLMBX.verint.corp.verintsystems.com>
References: <4312c3250907150136y4c98c78ak1b4fe50534248442@mail.gmail.com>
	<579B119545DAEF4689C8FBEEFEC5793F01D4FF0A202C@ATLMBX.verint.corp.verintsystems.com>
Date: Thu, 16 Jul 2009 09:37:51 +0530
Message-ID: <4312c3250907152107o1362fd0aicd95c521f5b42608@mail.gmail.com>
Subject: Re: ethernet driver - problem capturing own packet in promiscous mode
From: sudheer a <a.sudheer443@gmail.com>
To: "Cote, Sylvain" <Sylvain.Cote@verint.com>
Content-Type: multipart/alternative; boundary=001485f7d7febced0e046ecad0ea
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001485f7d7febced0e046ecad0ea
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Wed, Jul 15, 2009 at 5:52 PM, Cote, Sylvain <Sylvain.Cote@verint.com>wrote:

>    > Hi all
>
>
>
> > In ethernet driver  i need to enable promiscous mode and have to capture
> the packet that is sent by the same ethernet.
>
>
>
> > The board is connected to a packet generator and could send/receive
> packets  whenever i need .
>
>
>
> > In the board ethernet driver , I made sure that am sending only
> broadcast packets and promisc mode is enabled but the packets are not
> captured. If i am sending a packet to the board from packetgenerator it is
> receiving.
>
>
>
> > Could any one please suggest me any clues.
>
>
>
> > Having the promisc enabled:
>
> > Packet sent by packetgenerator is received by board.
>
> > Packet sent by board is received by packetgenerator, The same packet
> should be captured by board as promiscuous is enabled. but not happening.
>
>
>
>
>
> The Ethernet interface that sent the packet will never receive the packet
> it sent even if you are in promiscuous mode.  To be able to do that you
> should put your interface in loopback mode.
>
> In promiscuous mode, you will be able to receive any packets sent by other
> interfaces (broadcast, multicast and also unicast that is not directed to
> you interface MAC address).  But not
>
> from your interface.
>
Thanks for your inputs Sylvain.
I tried with loopback, it is working.
But during the time the hardware is in lopback mode, it may miss some rx
packets coming from outside or packet generator unfortunately and i dont
want it to happen.
Please let me know your views and suggestions.

Thanks
Sudheer

--001485f7d7febced0e046ecad0ea
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br>
<div class=3D"gmail_quote">On Wed, Jul 15, 2009 at 5:52 PM, Cote, Sylvain <=
span dir=3D"ltr">&lt;<a href=3D"mailto:Sylvain.Cote@verint.com">Sylvain.Cot=
e@verint.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div lang=3D"EN-CA" vlink=3D"purple" link=3D"blue">
<div>
<div>
<div></div>
<div class=3D"h5">
<div>
<p><font face=3D"Times New Roman" color=3D"navy" size=3D"3"><span lang=3D"E=
N-US" style=3D"FONT-SIZE: 12pt; COLOR: navy">&gt; </span></font>Hi all</p><=
/div>
<div>
<p><font face=3D"Times New Roman" size=3D"3"><span style=3D"FONT-SIZE: 12pt=
">=A0</span></font></p></div>
<div>
<p><font face=3D"Times New Roman" color=3D"navy" size=3D"3"><span style=3D"=
FONT-SIZE: 12pt; COLOR: navy">&gt; </span></font>In ethernet driver =A0i ne=
ed to enable promiscous mode and have to capture the packet that is sent by=
 the same ethernet. </p>
</div>
<div>
<p><font face=3D"Times New Roman" size=3D"3"><span style=3D"FONT-SIZE: 12pt=
">=A0</span></font></p></div>
<div>
<p><font face=3D"Times New Roman" color=3D"navy" size=3D"3"><span style=3D"=
FONT-SIZE: 12pt; COLOR: navy">&gt; </span></font>The board is connected to =
a packet generator and could send/receive packets =A0whenever i need .</p><=
/div>

<div>
<p><font face=3D"Times New Roman" size=3D"3"><span style=3D"FONT-SIZE: 12pt=
">=A0</span></font></p></div>
<div>
<p><font face=3D"Times New Roman" color=3D"navy" size=3D"3"><span style=3D"=
FONT-SIZE: 12pt; COLOR: navy">&gt; </span></font>In the board ethernet driv=
er , I made sure that am sending only broadcast packets and promisc mode is=
 enabled but the packets are not captured. If i am sending a packet to the=
=A0board from=A0packetgenerator it is receiving.</p>
</div>
<div>
<p><font face=3D"Times New Roman" size=3D"3"><span style=3D"FONT-SIZE: 12pt=
">=A0</span></font></p></div>
<div>
<p><font face=3D"Times New Roman" color=3D"navy" size=3D"3"><span style=3D"=
FONT-SIZE: 12pt; COLOR: navy">&gt; </span></font>Could any one please sugge=
st me any clues.</p></div>
<div>
<p><font face=3D"Times New Roman" size=3D"3"><span style=3D"FONT-SIZE: 12pt=
">=A0</span></font></p></div>
<div>
<p><font face=3D"Times New Roman" color=3D"navy" size=3D"3"><span style=3D"=
FONT-SIZE: 12pt; COLOR: navy">&gt; </span></font>Having the promisc enabled=
:</p></div>
<div>
<p><font face=3D"Times New Roman" color=3D"navy" size=3D"3"><span style=3D"=
FONT-SIZE: 12pt; COLOR: navy">&gt; </span></font>Packet sent by packetgener=
ator is received by board.</p></div>
<div>
<p><font face=3D"Times New Roman" color=3D"navy" size=3D"3"><span style=3D"=
FONT-SIZE: 12pt; COLOR: navy">&gt; </span></font>Packet sent by board is re=
ceived by packetgenerator, The same packet should be captured by board as p=
romiscuous is enabled. but not happening.<font color=3D"navy"><span style=
=3D"COLOR: navy"></span></font></p>

<p><font face=3D"Arial" color=3D"navy" size=3D"2"><span style=3D"FONT-SIZE:=
 10pt; COLOR: navy; FONT-FAMILY: Arial">=A0</span></font></p>
<p><font face=3D"Arial" color=3D"navy" size=3D"2"><span style=3D"FONT-SIZE:=
 10pt; COLOR: navy; FONT-FAMILY: Arial">=A0</span></font></p></div></div></=
div>
<div>
<p><font face=3D"Times New Roman" color=3D"navy" size=3D"3"><span style=3D"=
FONT-SIZE: 12pt; COLOR: navy">The Ethernet interface that sent the packet w=
ill never receive the packet it sent even if you are in promiscuous mode.=
=A0 To be able to do that you should put your interface in loopback mode.=
=A0 </span></font></p>

<p><font face=3D"Times New Roman" color=3D"navy" size=3D"3"><span style=3D"=
FONT-SIZE: 12pt; COLOR: navy">In promiscuous mode, you will be able to rece=
ive any packets sent by other interfaces (broadcast, multicast and also uni=
cast that is not directed to you interface MAC address). =A0But not</span><=
/font></p>

<p><font face=3D"Arial" color=3D"navy" size=3D"2"><span style=3D"FONT-SIZE:=
 10pt; COLOR: navy; FONT-FAMILY: Arial">from your interface.</span></font><=
/p></div></div></div></blockquote>
<div>Thanks for your inputs Sylvain.</div>
<div>I=A0tried with loopback, it is working. </div>
<div>But=A0during=A0the time=A0the hardware is in lopback mode, it may miss=
 some rx packets coming from outside or packet generator unfortunately and =
i dont want it to happen.</div>
<div>Please=A0let me know=A0your=A0views and suggestions.</div>
<div>=A0</div>
<div>Thanks</div>
<div>Sudheer</div>
<div>=A0</div>
<div>=A0</div></div>
<div>=A0</div>
<div>=A0</div>
<div><br>=A0</div>

--001485f7d7febced0e046ecad0ea--
