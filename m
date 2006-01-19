Return-Path: <jefferxu@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.196])
	by ozlabs.org (Postfix) with ESMTP id 4B2F2689C0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 Jan 2006 18:14:44 +1100 (EST)
Received: by zproxy.gmail.com with SMTP id z31so143804nzd
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 Jan 2006 23:14:43 -0800 (PST)
Message-ID: <98d249d60601182314g774ad2bes@mail.gmail.com>
Date: Thu, 19 Jan 2006 15:14:43 +0800
From: jeffer <jefferxu@gmail.com>
To: "David H. Lynch Jr." <dhlii@dlasys.net>
Subject: Re: [PATCH 00/10] Updated ML300 & ML403 patches
In-Reply-To: <43CEDCE4.5020903@dlasys.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_9730_33083915.1137654883450"
References: <20060114094658.GA12639@secretlab.ca> <43CC5453.3060702@xilinx.com>
	<43CC9F35.8010305@secretlab.ca> <43CEDCE4.5020903@dlasys.net>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_9730_33083915.1137654883450
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi at all


Since two week I have this Problem and can't solve it. I allready read DULG
and search in
Mailinglists but I can't run linux. Perhaps had the same problem and can
help me.
My Problem:
After I load the uImage (uImage at 0x00400000 )
from server, I try to run in with command bootm.
=3D> bootm 00400000
 Booting image at  00400000...
   Image Name:   Linux-2.4.24-pre2
   Created:      2006-01-19   6:25:03 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    700730 Bytes =3D 684.3 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK

 don't  start kernel
  my board  :
  sdram  16m  0----ffffff
  flash     4m   ffc00000 ---fffffff


> routing, so my current assumption is
> that I either have VIRTEX_UART defined improperly or I have the ppc_sys
> data structure created wrong.
>
>
> >
> >
>
>        It would be really nice if the was either some comments in
> xparameters.h or in the Documents directory explaining what the Linux
> xparameters values are so that it it would be easy to know what items
> from xparameters_xxx.h have to be mapped or redefined.
>
>
>
> > This really isn't a big deal anyway; most of this discussion will becom=
e
> > moot in short order.  Sometime in the next few releases, linuxppc will
> > flip over to using a flattened device tree to pass device information
> > from the boot loader to the kernel.  xparameters will drop out of the
> > kernel proper entirely except for the edk-generated device drivers
> > (which is another issue entirely).  All the xparam stuff will be
> > extracted into a device tree by u-boot or the zImage wrapper.  The
> > kernel just won't care.  :)
>        Where can we get more information on what is happening here ?
> I started the E12 port with most info in xparameters, but I have been
> moving towards getting things passed in board_info. I am not using
> u-boot as the E12 has a general purpose elf loader, and it was easier to
> add a fee lines for Linux. Regardless I would like to be compatible with
> whatever is coming - maybe even ahead fo the curve. The e12 is just the
> first of a family of products - the e14 already exists. There maybe
> revisions of each at different speeds with different memory.
>
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

------=_Part_9730_33083915.1137654883450
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Hi at all<br><br><br>Since&nbsp;two week I have this Problem and can't=
 solve it. I allready read DULG and search in<br>Mailinglists but I can't r=
un linux. Perhaps had the same problem and can help me.<br>My Problem:<br>A=
fter I load the uImage (uImage at 0x00400000 )
<br>from server, I try to run in with command bootm.<br>=3D&gt; bootm 00400=
000<br>&nbsp;Booting image at&nbsp;&nbsp;00400000...<br>&nbsp;&nbsp; Image =
Name:&nbsp;&nbsp; Linux-2.4.24-pre2<br>&nbsp;&nbsp; Created:&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; 2006-01-19&nbsp;&nbsp; 6:25:03 UTC<br>&nbsp;&nbsp; Image Ty=
pe:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip compressed)
<br>&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 700730 Bytes =3D 684.3 kB<br>=
&nbsp;&nbsp; Load Address: 00000000<br>&nbsp;&nbsp; Entry Point:&nbsp; 0000=
0000<br>&nbsp;&nbsp; Verifying Checksum ... OK<br>&nbsp;&nbsp; Uncompressin=
g Kernel Image ... OK</div>
<div>&nbsp;</div>
<div>&nbsp;don't&nbsp; start kernel </div>
<div>&nbsp; my board&nbsp; :<br>&nbsp; sdram&nbsp; 16m&nbsp; 0----ffffff</d=
iv>
<div>&nbsp; flash&nbsp;&nbsp;&nbsp;&nbsp; 4m&nbsp;&nbsp; ffc00000 ---ffffff=
f<br>&nbsp;</div>
<div>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">routing, so my current assumptio=
n is<br>that I either have VIRTEX_UART defined improperly or I have the ppc=
_sys
<br>data structure created wrong.<br><br><br>&gt;<br>&gt;<br><br>&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; It would be really nice if the was either some c=
omments in<br>xparameters.h or in the Documents directory explaining what t=
he Linux<br>xparameters values are so that it it would be easy to know what=
 items
<br>from xparameters_xxx.h have to be mapped or redefined.<br><br><br><br>&=
gt; This really isn't a big deal anyway; most of this discussion will becom=
e<br>&gt; moot in short order.&nbsp;&nbsp;Sometime in the next few releases=
, linuxppc will
<br>&gt; flip over to using a flattened device tree to pass device informat=
ion<br>&gt; from the boot loader to the kernel.&nbsp;&nbsp;xparameters will=
 drop out of the<br>&gt; kernel proper entirely except for the edk-generate=
d device drivers
<br>&gt; (which is another issue entirely).&nbsp;&nbsp;All the xparam stuff=
 will be<br>&gt; extracted into a device tree by u-boot or the zImage wrapp=
er.&nbsp;&nbsp;The<br>&gt; kernel just won't care.&nbsp;&nbsp;:)<br>&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Where can we get more information on what is =
happening here ?
<br>I started the E12 port with most info in xparameters, but I have been<b=
r>moving towards getting things passed in board_info. I am not using<br>u-b=
oot as the E12 has a general purpose elf loader, and it was easier to<br>
add a fee lines for Linux. Regardless I would like to be compatible with<br=
>whatever is coming - maybe even ahead fo the curve. The e12 is just the<br=
>first of a family of products - the e14 already exists. There maybe<br>
revisions of each at different speeds with different memory.<br><br><br>___=
____________________________________________<br>Linuxppc-embedded mailing l=
ist<br><a href=3D"mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@oz=
labs.org
</a><br><a href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedded">h=
ttps://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br></blockquote></=
div><br>

------=_Part_9730_33083915.1137654883450--
