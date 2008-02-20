Return-Path: <m.louvel@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.235])
	by ozlabs.org (Postfix) with ESMTP id 30225DDDEE
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Feb 2008 00:00:58 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so2796971wxd.15
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Feb 2008 05:00:56 -0800 (PST)
Message-ID: <dda529d0802200500k7cadc8afm4f9e8f04358aea0b@mail.gmail.com>
Date: Wed, 20 Feb 2008 13:00:56 +0000
From: "maxime louvel" <m.louvel@gmail.com>
To: "Kumar Gala" <galak@kernel.crashing.org>, scottwood@freescale.com
Subject: Re: 2.6.24 for mpc8458amc
In-Reply-To: <7CDED5EA-D72B-4D9F-A547-AC3B6A59F174@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_14090_30997020.1203512456799"
References: <OF5ABF0D8A.75A05AE1-ONC12573F4.00426B12-C12573F4.0043B5F0@abengoa.com>
	<7CDED5EA-D72B-4D9F-A547-AC3B6A59F174@kernel.crashing.org>
Cc: linuxppc-embedded-bounces+raul.moreno=telvent.abengoa.com@ozlabs.org,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_14090_30997020.1203512456799
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

yes It has something like 16550 UART.
the compiler version is gcc-3.4.3 with some specific stuff for the platform.
I also have a gcc-4.1.2 vanilla which has been compiled with the previous
one. The 4.1.2 works if you tell it to emulate the floating point
instructions.

thanks Scott,
without the treeboot-walnut it compiled

I have still my first problem though:

AMC=> bootm 0x1000000
## Booting image at 01000000 ...
  Image Name:   Linux-2.6.24
  Image Type:   PowerPC Linux Kernel Image (gzip compressed)
  Data Size:    1802038 Bytes =  1.7 MB
  Load Address: 00000000
  Entry Point:  00000000
  Verifying Checksum ... OK
  Uncompressing Kernel Image ... OK

and nothing else...

Any idea ?

This may become from the fact that the uboot installed on the cards is old
and it apparently doesn't support the newer version of the kernel image...
(I have got that from an another mailing list)

cheers,
Maxime

On Feb 20, 2008 5:19 AM, Kumar Gala <galak@kernel.crashing.org> wrote:

>
> On Feb 19, 2008, at 6:19 AM, raul.moreno@telvent.abengoa.com wrote:
>
> >
> > Hello Maxime,
> >
> > if your board is still running, although you can't see the messages
> > that
> > means you don't have any console. Try to set one (I think you can
> > use a SCM
> > of the CPM) in the kernel configuration (characters devices)  or in
> > the
> > command line (console=).
>
> If you really have a mpc8548 than there is no CPM.  It has 16550 style
> UARTs on it.
>
> - k
>



-- 
Maxime Louvel
0044 7964 5555 80
43 Allen road
Whitemore reans
WV60AW Wolverhampton
United Kingdom

------=_Part_14090_30997020.1203512456799
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>yes It has something like 16550 UART.<br>the compiler version is gcc-3.4.3 with some specific stuff for the platform.<br>I also have a gcc-4.1.2 vanilla which has been compiled with the previous one. The 4.1.2 works if you tell it to emulate the floating point instructions.<br>
<br>thanks Scott,<br>without the treeboot-walnut it compiled<br><br>I have still my first problem though:<br><br>AMC=&gt; bootm 0x1000000<br>## Booting image at 01000000 ...<br> &nbsp; Image Name: &nbsp; Linux-2.6.24<br> &nbsp; Image Type: &nbsp; PowerPC Linux Kernel Image (gzip compressed)<br>






 &nbsp; Data Size: &nbsp; &nbsp;1802038 Bytes = &nbsp;1.7 MB<br> &nbsp; Load Address: 00000000<br> &nbsp; Entry Point: &nbsp;00000000<br> &nbsp; Verifying Checksum ... OK<br> &nbsp; Uncompressing Kernel Image ... OK<br><br>and nothing else...<br><br>Any idea ?<br><br>
This may become from the fact that the uboot installed on the cards is old and it apparently doesn&#39;t support the newer version of the kernel image... (I have got that from an another mailing list)<br><br>cheers,<br>Maxime<br>
<br><div class="gmail_quote">On Feb 20, 2008 5:19 AM, Kumar Gala &lt;<a href="mailto:galak@kernel.crashing.org">galak@kernel.crashing.org</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d"><br>On Feb 19, 2008, at 6:19 AM, <a href="mailto:raul.moreno@telvent.abengoa.com">raul.moreno@telvent.abengoa.com</a> wrote:<br><br>&gt;<br>&gt; Hello Maxime,<br>&gt;<br>&gt; if your board is still running, although you can&#39;t see the messages<br>
&gt; that<br>&gt; means you don&#39;t have any console. Try to set one (I think you can<br>&gt; use a SCM<br>&gt; of the CPM) in the kernel configuration (characters devices) &nbsp;or in<br>&gt; the<br>&gt; command line (console=).<br>
<br></div>If you really have a mpc8548 than there is no CPM. &nbsp;It has 16550 style<br>UARTs on it.<br><font color="#888888"><br>- k<br></font></blockquote></div><br><br clear="all"><br>-- <br>Maxime Louvel<br>0044 7964 5555 80<br>
43 Allen road<br>Whitemore reans<br>WV60AW Wolverhampton<br>United Kingdom

------=_Part_14090_30997020.1203512456799--
