Return-Path: <hunter.cobbs@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.27])
	by ozlabs.org (Postfix) with ESMTP id E0BFDDE114
	for <linuxppc-dev@ozlabs.org>; Sun, 24 May 2009 04:50:05 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 3so1349882qwe.15
	for <linuxppc-dev@ozlabs.org>; Sat, 23 May 2009 11:50:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090523181422.794B3832E416@gemini.denx.de>
References: <ad84a70a0905222048i4e7ae5ddp66418f96d531f5f3@mail.gmail.com>
	<20090523181422.794B3832E416@gemini.denx.de>
Date: Sat, 23 May 2009 13:50:03 -0500
Message-ID: <ad84a70a0905231150s18026213r9360eb6807ab842e@mail.gmail.com>
Subject: Re: PPC405EX based irq flooding with USB-OTG and usbserial device
From: Hunter Cobbs <hunter.cobbs@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=0016364272b5503dac046a98d85a
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0016364272b5503dac046a98d85a
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Sat, May 23, 2009 at 1:14 PM, Wolfgang Denk <wd@denx.de> wrote:

> Dear Hunter,
>
> In message <ad84a70a0905222048i4e7ae5ddp66418f96d531f5f3@mail.gmail.com>
> you wrote:
> >
> > This is my first post to the PPC dev list as my company has just started
> > developing a new project based on Linux.  The good news is, this post is
> not
> > debug-related as much as it is an introduction and query while I download
> > the latest DENX kernel(only place I know that has the DWC_OTG driver).
>
> there is a strong reason why we decided  not  to  try  to  push  this
> driver  upstream:  it  is not in a state that would have a chance for
> being accepted for mainline. The problems you  are  experiencing  are
> probably   not   the   only  one.  Please  consider  this  driver  as
> unsupported.
>
> Best regards,
>
> Wolfgang Denk
>
> --
> DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
> "Ada is PL/I trying to be Smalltalk.                 - Codoso diBlini
>

Which leads me to another question.  Since I should consider this
unsupported, is there a better driver out there as my company is already
well down the road with our design?  Or would you recommend just creating
our own driver for the USB-OTG?

I'm developing with the Kilauea, and I guess I should ask how unstable is
Linux support for this Processor.
-- 
Hunter Cobbs

--0016364272b5503dac046a98d85a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Sat, May 23, 2009 at 1:14 PM, Wolfgan=
g Denk <span dir=3D"ltr">&lt;<a href=3D"mailto:wd@denx.de">wd@denx.de</a>&g=
t;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"border-left:=
 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex=
;">
Dear Hunter,<br>
<div class=3D"im"><br>
In message &lt;<a href=3D"mailto:ad84a70a0905222048i4e7ae5ddp66418f96d531f5=
f3@mail.gmail.com">ad84a70a0905222048i4e7ae5ddp66418f96d531f5f3@mail.gmail.=
com</a>&gt; you wrote:<br>
&gt;<br>
&gt; This is my first post to the PPC dev list as my company has just start=
ed<br>
&gt; developing a new project based on Linux. =A0The good news is, this pos=
t is not<br>
&gt; debug-related as much as it is an introduction and query while I downl=
oad<br>
&gt; the latest DENX kernel(only place I know that has the DWC_OTG driver).=
<br>
<br>
</div>there is a strong reason why we decided =A0not =A0to =A0try =A0to =A0=
push =A0this<br>
driver =A0upstream: =A0it =A0is not in a state that would have a chance for=
<br>
being accepted for mainline. The problems you =A0are =A0experiencing =A0are=
<br>
probably =A0 not =A0 the =A0 only =A0one. =A0Please =A0consider =A0this =A0=
driver =A0as<br>
unsupported.<br>
<br>
Best regards,<br>
<br>
Wolfgang Denk<br>
<font color=3D"#888888"><br>
--<br>
DENX Software Engineering GmbH, =A0 =A0 MD: Wolfgang Denk &amp; Detlev Zund=
el<br>
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany<br>
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: <a href=3D"mailt=
o:wd@denx.de">wd@denx.de</a><br>
&quot;Ada is PL/I trying to be Smalltalk. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 -=
 Codoso diBlini<br>
</font></blockquote></div><br>Which leads me to another question.=A0 Since =
I should consider this unsupported, is there a better driver out there as m=
y company is already well down the road with our design?=A0 Or would you re=
commend just creating our own driver for the USB-OTG?=A0 <br>
<br>I&#39;m developing with the Kilauea, and I guess I should ask how unsta=
ble is Linux support for this Processor. <br>-- <br>Hunter Cobbs<br>

--0016364272b5503dac046a98d85a--
