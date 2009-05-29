Return-Path: <isaac.nancy@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id C5FE3DDFA9
	for <linuxppc-dev@ozlabs.org>; Sat, 30 May 2009 03:20:54 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so2868709ywt.39
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 10:20:53 -0700 (PDT)
MIME-Version: 1.0
Sender: isaac.nancy@gmail.com
In-Reply-To: <20090529170909.GA22066@b07421-ec1.am.freescale.net>
References: <1bcc666d0905281205p63ee8119td5578a749bce8377@mail.gmail.com>
	<20090528200215.GA9793@b07421-ec1.am.freescale.net>
	<1bcc666d0905281848m5d237742h12b4bac272f28ca9@mail.gmail.com>
	<20090529170909.GA22066@b07421-ec1.am.freescale.net>
Date: Fri, 29 May 2009 10:20:52 -0700
Message-ID: <1bcc666d0905291020t488a0ed8w8d3de8e6d660e1df@mail.gmail.com>
Subject: Re: 8544 external interrupt configuration problems
From: Nancy Isaac <nancy.isaac@pobox.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: multipart/alternative; boundary=001e680f121870ae66046b104c69
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--001e680f121870ae66046b104c69
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Thank you!  That was my problem.  I was looking at the defines in
linux/irq.h and it didn't match what I was seeing at all....but this works
now.

On Fri, May 29, 2009 at 10:09 AM, Scott Wood <scottwood@freescale.com>wrote:

> On Thu, May 28, 2009 at 06:48:48PM -0700, Nancy Isaac wrote:
> > > Is the level/sense information correct?
> >
> >
> > [NI] Yes, these interrupts are supposed to be active low, level sensitive
> > interrupts.
>
> But the level/sense value for that on mpic is 1, not 2.  2 is active
> high (see Documentation/powerpc/booting-without-of.txt).
>
> -Scott
>

--001e680f121870ae66046b104c69
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thank you!=A0 That was my problem.=A0 I was looking at the defines in linux=
/irq.h and it didn&#39;t match what I was seeing at all....but this works n=
ow. <br><br><div class=3D"gmail_quote">On Fri, May 29, 2009 at 10:09 AM, Sc=
ott Wood <span dir=3D"ltr">&lt;<a href=3D"mailto:scottwood@freescale.com">s=
cottwood@freescale.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class=3D"im"=
>On Thu, May 28, 2009 at 06:48:48PM -0700, Nancy Isaac wrote:<br>
&gt; &gt; Is the level/sense information correct?<br>
&gt;<br>
&gt;<br>
&gt; [NI] Yes, these interrupts are supposed to be active low, level sensit=
ive<br>
&gt; interrupts.<br>
<br>
</div>But the level/sense value for that on mpic is 1, not 2. =A02 is activ=
e<br>
high (see Documentation/powerpc/booting-without-of.txt).<br>
<font color=3D"#888888"><br>
-Scott<br>
</font></blockquote></div><br>

--001e680f121870ae66046b104c69--
