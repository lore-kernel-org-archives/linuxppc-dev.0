Return-Path: <gnathita@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.199])
	by ozlabs.org (Postfix) with ESMTP id 5E001689E6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jan 2006 19:38:35 +1100 (EST)
Received: by zproxy.gmail.com with SMTP id l8so100013nzf
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jan 2006 00:38:33 -0800 (PST)
Message-ID: <259581790601110038w5c4164bcy3a4b2ba916195fa@mail.gmail.com>
Date: Wed, 11 Jan 2006 09:38:32 +0100
From: =?ISO-8859-1?Q?Paula_Saame=F1o?= <gnathita@gmail.com>
To: Peter Ryser <peter.ryser@xilinx.com>, linuxppc-embedded@ozlabs.org
In-Reply-To: <43C430E2.60905@xilinx.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_29013_25954900.1136968712767"
References: <259581790601100820s42d1a311ye40bfcf4ba6c9bd5@mail.gmail.com>
	<43C430E2.60905@xilinx.com>
Subject: Re: Error: Three ML403 boards
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_29013_25954900.1136968712767
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi, Peter,

I have already checked that record, and even fixing that bug and adding the
C_APU_CONTROL parameter, it still does not work in any board but one.

Anyone has suffered the same issue or have any idea of why it is happening?=
?

Thanks a lot!
Paula


On 1/10/06, Peter Ryser <peter.ryser@xilinx.com> wrote:
>
> Paula,
>
> please verify that you are not running into the problem described in
> Xilinx Answer Record 22179
> (
> http://www.xilinx.com/xlnx/xil_ans_display.jsp?iLanguageID=3D1&iCountryID=
=3D1&getPagePath=3D22179
> ).
>
> - Peter
>
>
> Paula Saame=F1o wrote:
>
> > Hello,
> >
> > I have 3 Xilinx ML403 boards. I have implemented a 2.4 kernel with a
> > basic configuration, with network support, systemACE, IIC... and it
> > works perfectly in one of them.
> >
> > However, when I put the ACE card, without making any change, in other
> > ML403 board, it does not work. The .ace file is loaded ok but then the
> > network leds (6 leds) start blinking and nothing else happens.
> >
> > I have tried with two ML403 different boards, and I have no idea of
> > where the problem is. They should work in the same way, don't they?
> >
> > Any help would be great.
> >
> > Also, I am trying to load a 2.6 kernel, but I am still on the way. I
> > will let you know if I get it working.
> >
> > Thanks a lot!
> > Paula
> >
> >------------------------------------------------------------------------
> >
> >_______________________________________________
> >Linuxppc-embedded mailing list
> >Linuxppc-embedded@ozlabs.org
> >https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >
>
>
>
>

------=_Part_29013_25954900.1136968712767
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br>Hi, Peter,<br>
<br>
I have already checked that record, and even fixing that bug and adding
the C_APU_CONTROL parameter, it still does not work in any board but
one.<br>
<br>
Anyone has suffered the same issue or have any idea of why it is happening?=
?<br>
<br>
Thanks a lot!<br>
Paula<br>
<br>
<br><div><span class=3D"gmail_quote">On 1/10/06, <b class=3D"gmail_senderna=
me">Peter Ryser</b> &lt;<a href=3D"mailto:peter.ryser@xilinx.com">peter.rys=
er@xilinx.com</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=
=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; p=
adding-left: 1ex;">
Paula,<br><br>please verify that you are not running into the problem descr=
ibed in<br>Xilinx Answer Record 22179<br>(<a href=3D"http://www.xilinx.com/=
xlnx/xil_ans_display.jsp?iLanguageID=3D1&amp;iCountryID=3D1&amp;getPagePath=
=3D22179">
http://www.xilinx.com/xlnx/xil_ans_display.jsp?iLanguageID=3D1&amp;iCountry=
ID=3D1&amp;getPagePath=3D22179</a>).<br><br>- Peter<br><br><br>Paula Saame=
=F1o wrote:<br><br>&gt; Hello,<br>&gt;<br>&gt; I have 3 Xilinx ML403 boards=
. I have implemented a=20
2.4 kernel with a<br>&gt; basic configuration, with network support, system=
ACE, IIC... and it<br>&gt; works perfectly in one of them.<br>&gt;<br>&gt; =
However, when I put the ACE card, without making any change, in other<br>
&gt; ML403 board, it does not work. The .ace file is loaded ok but then the=
<br>&gt; network leds (6 leds) start blinking and nothing else happens.<br>=
&gt;<br>&gt; I have tried with two ML403 different boards, and I have no id=
ea of
<br>&gt; where the problem is. They should work in the same way, don't they=
?<br>&gt;<br>&gt; Any help would be great.<br>&gt;<br>&gt; Also, I am tryin=
g to load a 2.6 kernel, but I am still on the way. I<br>&gt; will let you k=
now if I get it working.
<br>&gt;<br>&gt; Thanks a lot!<br>&gt; Paula<br>&gt;<br>&gt;---------------=
---------------------------------------------------------<br>&gt;<br>&gt;__=
_____________________________________________<br>&gt;Linuxppc-embedded mail=
ing list
<br>&gt;<a href=3D"mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@o=
zlabs.org</a><br>&gt;<a href=3D"https://ozlabs.org/mailman/listinfo/linuxpp=
c-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br>&g=
t;
<br><br><br><br></blockquote></div><br>

------=_Part_29013_25954900.1136968712767--
