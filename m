Return-Path: <jcrigby@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.186])
	by ozlabs.org (Postfix) with ESMTP id 7278D67B6F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Dec 2006 12:52:46 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id n15so1132483nfc
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Dec 2006 17:52:42 -0800 (PST)
Message-ID: <4b73d43f0612151752x1602392ehe9933e71fa1ac456@mail.gmail.com>
Date: Fri, 15 Dec 2006 18:52:42 -0700
From: "John Rigby" <jcrigby@gmail.com>
To: "Pedro Luis D. L." <carcadiz@hotmail.com>
Subject: Re: LITE5200B Powerfail
In-Reply-To: <BAY114-F102E7A8BBB9E25B0CC42FCAD40@phx.gbl>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_36801_20067112.1166233962791"
References: <BAY114-F102E7A8BBB9E25B0CC42FCAD40@phx.gbl>
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

------=_Part_36801_20067112.1166233962791
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Have you looked at the Lite5200B schematic to see where the signals in
question go?  Maybe you trying to drive something tied to ground high or
vice-versa.

On 12/15/06, Pedro Luis D. L. <carcadiz@hotmail.com> wrote:
>
> Hi all,
>
> I not pretty sure if this is the correct forum to ask for a solution but =
I
> know that some of you have worked on a driver to make PSCs in this board
> work in an I2S mode.
>
> Have you ever have powerfail problems when writing the configuration
> registers for this mode?
>
> I=B4ve delimited the problem:
> - GPIO Port Config register stores without problems the value "111" in
> bits
> 25:27 (PSC2 to work in CODEC2 functionality with MCLK).
> - When I write a "1" in PSC2->SICR register bit GenClk  to ensure that
> clock
> and FrameSync are generated internally from MCLK the systems suffers a
> powerfail and I suppose that=B4s consecuence or some kind of shortcircuit=
.
> I=B4ve followed the same steps made by Bob Peterson in
> http://ozlabs.org/pipermail/linuxppc-embedded/2005-September/020210.html
> to write the configuration in the proper registers but I still suffer the
> powerfail when GenClk is activated or, if I activate that bit first, when
> Port Config is written.
> I=B4m also trying to understand how things are done in Roman Fietze drive=
r
> but
> can=B4t find a difference. That makes me think that perhaps other registe=
rs
> must be modificated before driver loading. Meanwhile, I keep waiting for
> Grant Likely release, :-).
> Has this happened to someone before?
>
> Thanks for your help.
>
>     Pedro.
>
> _________________________________________________________________
> Hor=F3scopo, tarot, numerolog=EDa... Escucha lo que te dicen los astros.
> http://astrocentro.msn.es/
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

------=_Part_36801_20067112.1166233962791
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Have you looked at the Lite5200B schematic to see where the signals in
question go?&nbsp; Maybe you trying to drive something tied to ground high
or vice-versa.<br><br><div><span class=3D"gmail_quote">On 12/15/06, <b clas=
s=3D"gmail_sendername">Pedro Luis D. L.</b> &lt;<a href=3D"mailto:carcadiz@=
hotmail.com">carcadiz@hotmail.com</a>&gt; wrote:</span><blockquote class=3D=
"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0=
pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi all,<br><br>I not pretty sure if this is the correct forum to ask for a =
solution but I<br>know that some of you have worked on a driver to make PSC=
s in this board<br>work in an I2S mode.<br><br>Have you ever have powerfail=
 problems when writing the configuration
<br>registers for this mode?<br><br>I=B4ve delimited the problem:<br>- GPIO=
 Port Config register stores without problems the value &quot;111&quot; in =
bits<br>25:27 (PSC2 to work in CODEC2 functionality with MCLK).<br>- When I=
 write a &quot;1&quot; in PSC2-&gt;SICR register bit GenClk&nbsp;&nbsp;to e=
nsure that clock
<br>and FrameSync are generated internally from MCLK the systems suffers a<=
br>powerfail and I suppose that=B4s consecuence or some kind of shortcircui=
t.<br>I=B4ve followed the same steps made by Bob Peterson in<br><a href=3D"=
http://ozlabs.org/pipermail/linuxppc-embedded/2005-September/020210.html">
http://ozlabs.org/pipermail/linuxppc-embedded/2005-September/020210.html</a=
><br>to write the configuration in the proper registers but I still suffer =
the<br>powerfail when GenClk is activated or, if I activate that bit first,=
 when
<br>Port Config is written.<br>I=B4m also trying to understand how things a=
re done in Roman Fietze driver but<br>can=B4t find a difference. That makes=
 me think that perhaps other registers<br>must be modificated before driver=
 loading. Meanwhile, I keep waiting for
<br>Grant Likely release, :-).<br>Has this happened to someone before?<br><=
br>Thanks for your help.<br><br>&nbsp;&nbsp;&nbsp;&nbsp;Pedro.<br><br>_____=
____________________________________________________________<br>Hor=F3scopo=
, tarot, numerolog=EDa... Escucha lo que te dicen los astros.
<br><a href=3D"http://astrocentro.msn.es/">http://astrocentro.msn.es/</a><b=
r><br>_______________________________________________<br>Linuxppc-embedded =
mailing list<br><a href=3D"mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-em=
bedded@ozlabs.org
</a><br><a href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedded">h=
ttps://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br></blockquote></=
div><br>

------=_Part_36801_20067112.1166233962791--
