Return-Path: <sarans1987@gmail.com>
Received: from mail-qa0-f51.google.com (mail-qa0-f51.google.com
 [209.85.216.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C9E5A2C00BF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jul 2012 16:46:43 +1000 (EST)
Received: by qaea16 with SMTP id a16so798103qae.17
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2012 23:46:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8D983423E7EDF846BB3056827B8CC5D10285E9@corpmail1.na.ads.idt.com>
References: <CAEqOc-QpXcwbLuJXLbGv3VgccKnkMrdGV+ZdwFaFZCzjG3K7Mw@mail.gmail.com>
 <8D983423E7EDF846BB3056827B8CC5D10285E9@corpmail1.na.ads.idt.com>
Date: Sat, 14 Jul 2012 11:54:47 +0530
Message-ID: <CAEqOc-QzeNz0z33yegaa-9FVpbcCUaMix4-Gfkn0P8Y3487YsA@mail.gmail.com>
Subject: Re: Standalone SRIO Driver for Linux
From: Saravanan S <sarans1987@gmail.com>
To: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
Content-Type: multipart/alternative; boundary=00235452e960df204b04c4c440b6
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--00235452e960df204b04c4c440b6
Content-Type: text/plain; charset=ISO-8859-1

Hi ,
     Thanks for the reply . i will try to share some of my code later .
Looking forward to ur ideas.

Regards,

S.Saravanan

On Fri, Jul 13, 2012 at 6:18 PM, Bounine, Alexandre <
Alexandre.Bounine@idt.com> wrote:

>  This should work. We use similar approach to test our mport HW drivers.**
> **
>
> ** **
>
> Alex.****
>
> ** **
>
> *From:* Linuxppc-dev [mailto:linuxppc-dev-bounces+alexandre.bounine=
> idt.com@lists.ozlabs.org] *On Behalf Of *Saravanan S
> *Sent:* Friday, July 13, 2012 2:16 AM
> *To:* linuxppc-dev@lists.ozlabs.org
> *Subject:* Standalone SRIO Driver for Linux****
>
> ** **
>
> Hi ,
>
>       Iam currently working on the GE make DSP230 board consisting of Quad
> PowerPC8640 nodes   interconnected by SRIO with Linux 2.6.34 . However the
> only way to access the SRIO is through rionet facility . Our requirement is
> to use the SRIO interconnect without the Ethernet overheads. This would
> definitely enable higher speeds (though I cant find any throughput figures
> for SRIO in Linux on the net ??? ).  My query is that whether any attempt
> has been made  to develop a  standalone driver and API to access the
> messaging  and doorbell services of SRIO . If no then request you to please
> provide inputs on the same. From my study I have the following thoughts for
> the driver :
>
> a) Have a character device interface for user .
> b) Basically use the rio support functions provided in rio.c like
> rio_add_inb_buffer ,  rio_add_outb_message to transfer and receive messages
> and add buffers .
> c) Maintain a dedicated ring of buffers in the driver and transfer  data
> to and from the buffer to user space .
>
>
> Is this the right direction . Would really appreciate any inputs . thanks
> in advance.
>
> Regards,
>
> S.Saravanan****
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>

--00235452e960df204b04c4c440b6
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi ,<div>=A0 =A0 =A0Thanks for the reply . i will try to share some of my c=
ode later . Looking forward to ur ideas.=A0</div><div><br></div><div>Regard=
s,</div><div><br></div><div>S.Saravanan<br><br><div class=3D"gmail_quote">O=
n Fri, Jul 13, 2012 at 6:18 PM, Bounine, Alexandre <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:Alexandre.Bounine@idt.com" target=3D"_blank">Alexandre.Boun=
ine@idt.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">





<div lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div><div class=3D"im">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d">This should work. We use =
similar approach to test our mport HW drivers.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>=A0<u></u></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d">Alex.<u></u><u></u></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>=A0<u></u></span><=
/p>
</div><div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0i=
n 0in 4.0pt"><div class=3D"im">
<div>
<div style=3D"border:none;border-top:solid #b5c4df 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;font-family:&quot=
;Tahoma&quot;,&quot;sans-serif&quot;">From:</span></b><span style=3D"font-s=
ize:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;"> Linuxppc=
-dev [mailto:<a href=3D"mailto:linuxppc-dev-bounces%2Balexandre.bounine" ta=
rget=3D"_blank">linuxppc-dev-bounces+alexandre.bounine</a>=3D<a href=3D"mai=
lto:idt.com@lists.ozlabs.org" target=3D"_blank">idt.com@lists.ozlabs.org</a=
>]
<b>On Behalf Of </b>Saravanan S<br>
<b>Sent:</b> Friday, July 13, 2012 2:16 AM<br>
<b>To:</b> <a href=3D"mailto:linuxppc-dev@lists.ozlabs.org" target=3D"_blan=
k">linuxppc-dev@lists.ozlabs.org</a><br>
<b>Subject:</b> Standalone SRIO Driver for Linux<u></u><u></u></span></p>
</div>
</div>
<p class=3D"MsoNormal"><u></u>=A0<u></u></p>
</div><p class=3D"MsoNormal">Hi ,</p><div><div class=3D"h5"><br>
=A0=A0=A0=A0=A0 Iam currently working on the GE make DSP230 board consistin=
g of Quad PowerPC8640 nodes =A0 interconnected by SRIO with Linux 2.6.34 . =
However the only way to access the SRIO is through rionet facility . Our re=
quirement is to use the SRIO interconnect without
 the Ethernet overheads. This would definitely enable higher speeds (though=
 I cant find any throughput figures for SRIO in Linux on the net ??? ).=A0 =
My query is that whether any attempt has been made=A0 to develop a=A0 stand=
alone driver and API to access the messaging=A0
 and doorbell services of SRIO . If no then request you to please provide i=
nputs on the same. From my study I have the following thoughts for the driv=
er :<br>
<br>
a) Have a character device interface for user .<br>
b) Basically use the rio support functions provided in rio.c like=A0 rio_ad=
d_inb_buffer ,=A0 rio_add_outb_message to transfer and receive messages and=
 add buffers .<br>
c) Maintain a dedicated ring of buffers in the driver and transfer=A0 data =
to and from the buffer to user space .<br>
<br>
<br>
Is this the right direction . Would really appreciate any inputs . thanks i=
n advance.<br>
<br>
Regards,<br>
<br>
S.Saravanan<u></u><u></u></div></div><p></p>
</div>
</div>
</div>

<br>_______________________________________________<br>
Linuxppc-dev mailing list<br>
<a href=3D"mailto:Linuxppc-dev@lists.ozlabs.org">Linuxppc-dev@lists.ozlabs.=
org</a><br>
<a href=3D"https://lists.ozlabs.org/listinfo/linuxppc-dev" target=3D"_blank=
">https://lists.ozlabs.org/listinfo/linuxppc-dev</a><br></blockquote></div>=
<br></div>

--00235452e960df204b04c4c440b6--
