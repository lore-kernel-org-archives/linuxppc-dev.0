Return-Path: <mbergandi@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.26])
	by ozlabs.org (Postfix) with ESMTP id E4D46DDE19
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Feb 2009 00:22:45 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 3so498087qwe.15
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Feb 2009 05:22:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <2a27d3730902252243i6e0e65f6te78831cfcbae823b@mail.gmail.com>
References: <1c641bc80902251151v5a4a5e15g13f6711510acb7ee@mail.gmail.com>
	<2a27d3730902252243i6e0e65f6te78831cfcbae823b@mail.gmail.com>
Date: Thu, 26 Feb 2009 08:22:42 -0500
Message-ID: <1c641bc80902260522j45073db8h4da0b0c8f3440e00@mail.gmail.com>
Subject: Re: MPC8313E-RDB and USB OTG
From: Michael Bergandi <mbergandi@gmail.com>
To: Li Yang <leoli@freescale.com>
Content-Type: multipart/alternative; boundary=0015175ccf1a4a89430463d23fa2
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0015175ccf1a4a89430463d23fa2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Leo, sorry for sending this twice. Forgot to cc the list.

> I am hoping someone can shed some light on the state of the USB support in
> > the
> > 2.6.28 kernel for USB OTG on the MPC8313E RDB. The configuration options
> are
> > a bit different than the ones from the provided LTIB kernel--- for
> obvious
> > reasons---
> > and I am trying to figure out how to get OTG working in this version of
> the
> > kernel
> > on my board.
>
> USB OTG support for Freescale USB has not been included in mainline.
> So you need to bring the OTG code up-to-date, or stay with the LTIB
> kernel.
>
> - Leo
>

Thanks Leo. I will look into getting the OTG code included.

Do you have a general outline of what would need to be done to it?

Any potential trouble spots?

Mike

--0015175ccf1a4a89430463d23fa2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Leo, sorry for sending this twice. Forgot to cc the list.<br><br><div class="gmail_quote"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class="Ih2E3d">
&gt; I am hoping someone can shed some light on the state of the USB support in<br>
&gt; the<br>
&gt; 2.6.28 kernel for USB OTG on the MPC8313E RDB. The configuration options are<br>
&gt; a bit different than the ones from the provided LTIB kernel--- for obvious<br>
&gt; reasons---<br>
&gt; and I am trying to figure out how to get OTG working in this version of the<br>
&gt; kernel<br>
&gt; on my board.<br>
<br>
</div>USB OTG support for Freescale USB has not been included in mainline.<br>
So you need to bring the OTG code up-to-date, or stay with the LTIB<br>
kernel.<br>
<br>
- Leo<br>
</blockquote></div><br clear="all">Thanks Leo. I will look into getting the OTG code included.<br><br>Do you have a general outline of what would need to be done to it?<br><br>Any potential trouble spots?<br><br>Mike<br>
<br>

--0015175ccf1a4a89430463d23fa2--
