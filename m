Return-Path: <d.stonier@gmail.com>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.191])
	by ozlabs.org (Postfix) with ESMTP id 8AAE7DDF1B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Apr 2008 14:24:00 +1000 (EST)
Received: by ti-out-0910.google.com with SMTP id y6so660033tia.13
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Apr 2008 21:23:58 -0700 (PDT)
Message-ID: <27dfa3d0804212123i1085456bpbc6f39b75e005ff5@mail.gmail.com>
Date: Tue, 22 Apr 2008 13:23:57 +0900
From: "Daniel Stonier" <d.stonier@gmail.com>
To: "Detlev Zundel" <dzu@denx.de>, linuxppc-embedded@ozlabs.org
Subject: Re: eldk and usb to serial converters
In-Reply-To: <m2r6cz45ki.fsf@ohwell.denx.de>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_13477_16195152.1208838238018"
References: <27dfa3d0804171704j711aad1cwe7b558c077da3350@mail.gmail.com>
	<m2r6cz45ki.fsf@ohwell.denx.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_13477_16195152.1208838238018
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Just discovered that this morning! Had made the assumption it was
automatically enabled, but only clued onto it when I noticed udevmonitor
wasn't giving only UEVENT output, not UDEV output. Should have been obvious,
but I kept barking up the wrong tree!

So, turning out to be a good chance to learn how the lower levels of a linux
system work and managed to learn exactly how udev works while stumbling on
this one.
Thanks for the reply

2008/4/21 Detlev Zundel <dzu@denx.de>:

> Hi Daniel,
>
> > I'm currently trying to compile a kernel for an AMCC440EP board within
> an eldk
> > environment. We've got a FTDI usb2serial converter we need to connect to
> the
> > board. Now I've compiled a kernel on a gentoo machine for this device
> and had
> > no problems. With this board, the kernel recognizes the device fine:
> >
> > ftdi_sio 1-1:1.0: FTDI USB Serial Device converter detected
> > usb 1-1: FTDI USB Serial Device converter now attached to ttyUSB0
> > drivers/usb/serial/ftdi_sio.c: v1.4.3:USB FTDI Serial Converters Driver
> >
> > but udev doesn't actually make the ttyUSB0 node. If anyone knows what
> may have
> > caused the problem and how to fix it, it'd be much appreciated.
>
> Maybe udev isn't running at all?  The ELDKs including udev disable it
> per default (what version are you using?).  Embedded systeme like to
> have static kernel configurations presenting no surprises at runtime...
>
> Cheers
>  Detlev
>
> --
> Programming X-Windows is like trying to find the square root of pi
> using roman numerals.
>                                          -- The UNIX Haters Handbook
> --
> DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
> HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

------=_Part_13477_16195152.1208838238018
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Just discovered that this morning! Had made the assumption it was automatically enabled, but only clued onto it when I noticed udevmonitor wasn&#39;t giving only UEVENT output, not UDEV output. Should have been obvious, but I kept barking up the wrong tree! <br>
<br>So, turning out to be a good chance to learn how the lower levels of a linux system work and managed to learn exactly how udev works while stumbling on this one. <br>Thanks for the reply<br><br><div class="gmail_quote">
2008/4/21 Detlev Zundel &lt;<a href="mailto:dzu@denx.de">dzu@denx.de</a>&gt;:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi Daniel,<br>

<div><div></div><div class="Wj3C7c"><br>
&gt; I&#39;m currently trying to compile a kernel for an AMCC440EP board within an eldk<br>
&gt; environment. We&#39;ve got a FTDI usb2serial converter we need to connect to the<br>
&gt; board. Now I&#39;ve compiled a kernel on a gentoo machine for this device and had<br>
&gt; no problems. With this board, the kernel recognizes the device fine:<br>
&gt;<br>
&gt; ftdi_sio 1-1:1.0: FTDI USB Serial Device converter detected<br>
&gt; usb 1-1: FTDI USB Serial Device converter now attached to ttyUSB0<br>
&gt; drivers/usb/serial/ftdi_sio.c: v1.4.3:USB FTDI Serial Converters Driver<br>
&gt;<br>
&gt; but udev doesn&#39;t actually make the ttyUSB0 node. If anyone knows what may have<br>
&gt; caused the problem and how to fix it, it&#39;d be much appreciated.<br>
<br>
</div></div>Maybe udev isn&#39;t running at all? &nbsp;The ELDKs including udev disable it<br>
per default (what version are you using?). &nbsp;Embedded systeme like to<br>
have static kernel configurations presenting no surprises at runtime...<br>
<br>
Cheers<br>
 &nbsp;Detlev<br>
<br>
--<br>
Programming X-Windows is like trying to find the square root of pi<br>
using roman numerals.<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;-- The UNIX Haters Handbook<br>
--<br>
DENX Software Engineering GmbH, &nbsp; &nbsp; &nbsp;MD: Wolfgang Denk &amp; Detlev Zundel<br>
HRB 165235 Munich, &nbsp;Office: Kirchenstr.5, D-82194 Groebenzell, Germany<br>
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: <a href="mailto:dzu@denx.de">dzu@denx.de</a><br>
<br>
_______________________________________________<br>
Linuxppc-embedded mailing list<br>
<a href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a><br>
<a href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded" target="_blank">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br>
</blockquote></div><br>

------=_Part_13477_16195152.1208838238018--
