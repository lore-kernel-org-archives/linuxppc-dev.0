Return-Path: <neorf3k@gmail.com>
Received: from mail-wg0-x229.google.com (mail-wg0-x229.google.com
 [IPv6:2a00:1450:400c:c00::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 157352C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Nov 2013 20:49:36 +1100 (EST)
Received: by mail-wg0-f41.google.com with SMTP id n12so440698wgh.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Nov 2013 01:49:32 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_71842823-AE98-417D-98C1-533AC17633FD"
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Subject: Re: Problem reading and programming memory location...
From: neorf3k <neorf3k@gmail.com>
In-Reply-To: <20131114100917.31f674d7@crub>
Date: Thu, 14 Nov 2013 10:49:26 +0100
Message-Id: <614414FC-B406-4ADD-9F65-93BF474E51EF@gmail.com>
References: <985685C7-0122-4D45-96D1-4412E9774A5D@gmail.com>
 <20131113083259.1b69ed18@crub>
 <50EBA514-5BB1-40B3-B27B-309A829D2E05@gmail.com>
 <20131113190606.2a5d08fb@crub>
 <5DC55309-D920-44CE-8F89-AB7FA6BD383A@gmail.com>
 <20131114100917.31f674d7@crub>
To: Anatolij Gustschin <agust@denx.de>
Cc: Linux Ppc Dev List Dev List <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Apple-Mail=_71842823-AE98-417D-98C1-533AC17633FD
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

Sorry, the address is 0x10020000.
I've executed this code:

/* code */
   unsigned char *virt_base;
    u8 regval;
   =20
    /* map 4kbyte reg. space */
    virt_base =3D ioremap(0x10020000, 0x1000);
    if (!virt_base) {
        printk("fpga ioremap failed\n");
        return;
    }
   =20
    regval =3D in_8(virt_base);
   =20
   =20
    printk("reg. value 0x%02x\n", regval);
    printk("reg. value %x\n", virt_base);
/* code */

and i've:

reg. value 0x10
address c90e8000

in U-BOOT in reg. value i've: 0xf8

Thank you so much again=85

Lorenzo

On 14/nov/2013, at 10:09 AM, Anatolij Gustschin <agust@denx.de> wrote:

>  u8 regval;
>=20
>   /* map 4kbyte reg. space */
>   virt_base =3D ioremap(0x10020000, 0x1000);
>   if (!virt_base) {
>     printk("fpga ioremap failed\n");
>     return;
>   }
>=20
>   regval =3D in_8(virt_base);
>=20
>   printk("reg. value 0x%02x\n", regval);


--Apple-Mail=_71842823-AE98-417D-98C1-533AC17633FD
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=windows-1252

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dwindows-1252"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;"><div>Sorry, the address is =
0x10020000.</div><div>I've executed this =
code:</div><div><br></div><div>/* code */</div><div>&nbsp; =
&nbsp;unsigned char *virt_base;</div><div>&nbsp; &nbsp; u8 =
regval;</div><div>&nbsp; &nbsp;&nbsp;</div><div>&nbsp; &nbsp; /* map =
4kbyte reg. space */</div><div>&nbsp; &nbsp; virt_base =3D =
ioremap(0x10020000, 0x1000);</div><div>&nbsp; &nbsp; if (!virt_base) =
{</div><div>&nbsp; &nbsp; &nbsp; &nbsp; printk("fpga ioremap =
failed\n");</div><div>&nbsp; &nbsp; &nbsp; &nbsp; =
return;</div><div>&nbsp; &nbsp; }</div><div>&nbsp; =
&nbsp;&nbsp;</div><div>&nbsp; &nbsp; regval =3D =
in_8(virt_base);</div><div>&nbsp; &nbsp;&nbsp;</div><div>&nbsp; =
&nbsp;&nbsp;</div><div>&nbsp; &nbsp; printk("reg. value 0x%02x\n", =
regval);</div><div>&nbsp; &nbsp; printk("reg. value %x\n", =
virt_base);</div><div>/* code */</div><div><br></div><div>and =
i've:</div><div><br></div><div>reg. value 0x10</div><div>address =
c90e8000</div><div><br></div><div>in U-BOOT in reg. value i've: =
0xf8</div><div><br></div><div>Thank you so much =
again=85</div><div><br></div><div>Lorenzo</div><div><br></div><div><div>On=
 14/nov/2013, at 10:09 AM, Anatolij Gustschin &lt;<a =
href=3D"mailto:agust@denx.de">agust@denx.de</a>&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><blockquote type=3D"cite"><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
line-height: normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px; float: none; display: inline =
!important;">&nbsp;u8 regval;</span><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant: normal; font-weight: =
normal; letter-spacing: normal; line-height: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;"><br style=3D"font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant: normal; font-weight: normal; letter-spacing: =
normal; line-height: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;"><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
line-height: normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px; float: none; display: inline =
!important;">&nbsp;&nbsp;/* map 4kbyte reg. space */</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
line-height: normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px;"><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; line-height: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;">&nbsp;&nbsp;virt_base =3D ioremap(0x10020000, =
0x1000);</span><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant: normal; font-weight: normal; =
letter-spacing: normal; line-height: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;"><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
line-height: normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px; float: none; display: inline =
!important;">&nbsp;&nbsp;if (!virt_base) {</span><br style=3D"font-family:=
 Helvetica; font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; line-height: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;"><span style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant: normal; font-weight: =
normal; letter-spacing: normal; line-height: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
float: none; display: inline =
!important;">&nbsp;&nbsp;&nbsp;&nbsp;printk("fpga ioremap =
failed\n");</span><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant: normal; font-weight: normal; =
letter-spacing: normal; line-height: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;"><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
line-height: normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px; float: none; display: inline =
!important;">&nbsp;&nbsp;&nbsp;&nbsp;return;</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
line-height: normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px;"><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; line-height: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;">&nbsp;&nbsp;}</span><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant: normal; font-weight: =
normal; letter-spacing: normal; line-height: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;"><br style=3D"font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant: normal; font-weight: normal; letter-spacing: =
normal; line-height: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;"><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
line-height: normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px; float: none; display: inline =
!important;">&nbsp;&nbsp;regval =3D in_8(virt_base);</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
line-height: normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px;"><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; line-height: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;"><span style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant: normal; font-weight: =
normal; letter-spacing: normal; line-height: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
float: none; display: inline !important;">&nbsp;&nbsp;printk("reg. value =
0x%02x\n", regval);</span></blockquote></div><br></body></html>=

--Apple-Mail=_71842823-AE98-417D-98C1-533AC17633FD--
