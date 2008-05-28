Return-Path: <John.Linn@xilinx.com>
Received: from outbound2-va3-R.bigfish.com (unknown [216.32.180.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 24A8BDDF6C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 May 2008 05:34:19 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8C0F9.BCC63964"
Subject: RE: Cross toolchain for ppc405 (virtex-4)
Date: Wed, 28 May 2008 13:32:51 -0600
References: <20080528171751.D545CBD8071@mail116-sin.bigfish.com>
	<a949fe6be8a76bc2ecfa56313f8e7047@lesc.ufc.br>
From: "John Linn" <John.Linn@xilinx.com>
To: "rodolfo" <rodolfo@lesc.ufc.br>
Message-Id: <20080528193344.065CF7A8089@mail218-va3.bigfish.com>
Cc: linuxppc-embedded@ozlabs.org, Mirek23 <miroslaw.dach@psi.ch>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------_=_NextPart_001_01C8C0F9.BCC63964
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I don't know, I'm not familiar with what you are doing and it's not clear f=
rom the message.
 =

-- John

________________________________

From: rodolfo [mailto:rodolfo@lesc.ufc.br]
Sent: Wed 5/28/2008 12:05 PM
To: John Linn
Cc: Mirek23; linuxppc-embedded@ozlabs.org
Subject: RE: Cross toolchain for ppc405 (virtex-4)



Hi Jonh,

If I use ml403 (with PPC 405) Did i change the predefined compiler flags
for ppc_4xx? The default value is -mcpu=3D403.

On Wed, 28 May 2008 11:16:41 -0600, "John Linn" <John.Linn@xilinx.com>
wrote:
> Hi Miroslaw,
>
> I'm not sure on what version of gcc and glibc it's using, but I have been=

> using ELDK 4.1 from denx.com. There are newer versions.
>
> Thanks,
> John
>
>
>
> -----Original Message-----
> From: linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org on beha=
lf
> of Mirek23
> Sent: Wed 5/28/2008 9:54 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: Cross toolchain for ppc405 (virtex-4)
> =

>
> Hi All,
>
> I am using for some time the crosstool tool-chain (crosstool-0.43) for
the
> ppc405 of my virtex-4.
> It seems to be that the crosstool was not updated for awhile but the
glibc
> and gcc compiler has changed a bit meanwhile.
>
> The latest working configuration to build the toolchain for ppc405 is
> gcc-4.1.0-glibc-2.3.6.dat
> Does any body has tried to adapt the crosstools to use for example glibc
> 2.7
> ?
>
> Another alternative would be to use another tool than crosstool. Could
> somebody recommend something which can refer to newer version of gcc and
> glibc .
>
> Best Regards
>
> Miroslaw Dach
>
>






This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.


------_=_NextPart_001_01C8C0F9.BCC63964
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<HTML dir=3Dltr><HEAD><TITLE>RE: Cross toolchain for ppc405 (virtex-4)</TIT=
LE>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dunicode">
<META content=3D"MSHTML 6.00.2900.3314" name=3DGENERATOR></HEAD>
<BODY>
<DIV id=3DidOWAReplyText13937 dir=3Dltr>
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 size=3D2>I don't know, I'=
m not familiar with what you are doing and it's not clear from the message.=
</FONT></DIV>
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV dir=3Dltr><FONT face=3DArial size=3D2>-- John</FONT></DIV></DIV>
<DIV dir=3Dltr><BR>
<HR tabIndex=3D-1>
<FONT face=3DTahoma size=3D2><B>From:</B> rodolfo [mailto:rodolfo@lesc.ufc.=
br]<BR><B>Sent:</B> Wed 5/28/2008 12:05 PM<BR><B>To:</B> John Linn<BR><B>Cc=
:</B> Mirek23; linuxppc-embedded@ozlabs.org<BR><B>Subject:</B> RE: Cross to=
olchain for ppc405 (virtex-4)<BR></FONT><BR></DIV>
<DIV>
<P><FONT size=3D2>Hi Jonh,<BR><BR>If I use ml403 (with PPC 405) Did i chang=
e the predefined compiler flags<BR>for ppc_4xx? The default value is -mcpu=
=3D403.<BR><BR>On Wed, 28 May 2008 11:16:41 -0600, "John Linn" &lt;John.Lin=
n@xilinx.com&gt;<BR>wrote:<BR>&gt; Hi Miroslaw,<BR>&gt;<BR>&gt; I'm not sur=
e on what version of gcc and glibc it's using, but I have been<BR>&gt; usin=
g ELDK 4.1 from denx.com. There are newer versions.<BR>&gt;<BR>&gt; Thanks,=
<BR>&gt; John<BR>&gt;<BR>&gt;<BR>&gt;<BR>&gt; -----Original Message-----<BR=
>&gt; From: linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org on =
behalf<BR>&gt; of Mirek23<BR>&gt; Sent: Wed 5/28/2008 9:54 AM<BR>&gt; To: l=
inuxppc-embedded@ozlabs.org<BR>&gt; Subject: Cross toolchain for ppc405 (vi=
rtex-4)<BR>&gt;&nbsp;<BR>&gt;<BR>&gt; Hi All,<BR>&gt;<BR>&gt; I am using fo=
r some time the crosstool tool-chain (crosstool-0.43) for<BR>the<BR>&gt; pp=
c405 of my virtex-4.<BR>&gt; It seems to be that the crosstool was not upda=
ted for awhile but the<BR>glibc<BR>&gt; and gcc compiler has changed a bit =
meanwhile.<BR>&gt;<BR>&gt; The latest working configuration to build the to=
olchain for ppc405 is<BR>&gt; gcc-4.1.0-glibc-2.3.6.dat<BR>&gt; Does any bo=
dy has tried to adapt the crosstools to use for example glibc<BR>&gt; 2.7<B=
R>&gt; ?<BR>&gt;<BR>&gt; Another alternative would be to use another tool t=
han crosstool. Could<BR>&gt; somebody recommend something which can refer t=
o newer version of gcc and<BR>&gt; glibc .<BR>&gt;<BR>&gt; Best Regards<BR>=
&gt;<BR>&gt; Miroslaw Dach<BR>&gt;<BR>&gt;<BR><BR><BR></FONT></P></DIV><br =
clear=3Dall> This email and any attachments are intended for the sole use o=
f the named recipient(s) and contain(s) confidential information that may b=
e proprietary, privileged or copyrighted under applicable law. If you are n=
ot the intended recipient, do not read, copy, or forward this email message=
 or any attachments. Delete this email message and any attachments immediat=
ely.
</BODY></HTML>


------_=_NextPart_001_01C8C0F9.BCC63964--
