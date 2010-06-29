Return-Path: <B04825@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C6478B6F35
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jun 2010 09:39:23 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o5TNdKJJ000749
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jun 2010 16:39:21 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id o5TNpgcG017301
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jun 2010 18:51:42 -0500 (CDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CB17E4.4AB23E4B"
Subject: Re: [PATCH] powerpc: introduce basic support for the Freescale
	P1022DS reference board
Date: Tue, 29 Jun 2010 16:39:17 -0700
Message-ID: <5610599F537DD74A8D1F5CC946A7507303478FF9@az33exm25.fsl.freescale.net>
In-Reply-To: <20100629171904.d6ae6233.kim.phillips@freescale.com>
References: <1277847274-24648-1-git-send-email-timur@freescale.com>
	<20100629171904.d6ae6233.kim.phillips@freescale.com>
From: "Tabi Timur-B04825" <B04825@freescale.com>
To: "Phillips Kim-R1AAHA" <kim.phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CB17E4.4AB23E4B
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Kim Phillips wrote:
> On Tue, 29 Jun 2010 16:34:34 -0500
> Timur Tabi<timur@freescale.com>  wrote:
>
>> Introduce basic support for the Freescale P1022DS reference board, =
based on the
>> Freescale BSP for this board.
>>
>> Details: No DIU video or SSI audio support, no MMC/SD card support, =
36-bit and
>> SWIOTLB support enabled, 36-bit DTS only, and CONFIG_NO_HZ disabled =
because it
>> causes performance problems on this kernel.
>
> what kind of performance problems?

See my post on linuxppc-dev about CONFIG_NO_HZ.

>> +			queue-group@0{
>> +				#address-cells =3D<1>;
>> +				#size-cells =3D<1>;
>> +				reg =3D<0xB1000 0x1000>;
>> +				fsl,rx-err-int-map =3D<0xAA>;
>> +				fsl,tx-int-map =3D<0xAA>;
>> +				interrupts =3D<35 2 36 2 40 2>;
>> +			};
>> +			queue-group@1{
>> +				#address-cells =3D<1>;
>> +				#size-cells =3D<1>;
>> +				reg =3D<0xB5000 0x1000>;
>> +				fsl,rx-err-int-map =3D<0x55>;
>> +				fsl,tx-int-map =3D<0x55>;
>> +				interrupts =3D<51 2 52 2 67 2>;
>> +			};
>
> these queue-group nodes, fsl,{r,t}x-* properties...

I just copied this tree from the BSP.  I have no idea what they should =
ok=20
like.  Can you be more specific?

>> +		crypto@30000 {
>
>> +			fsl,multi-host-mode =3D "dual";
>> +			fsl,channel-remap =3D<0x3>;
>
> and the above two properties aren't supported by their respective
> drivers, nor are they listed in the dts bindings documentation.

Then please tell me what these nodes should look like.


--=20
Timur Tabi
Linux kernel developer

------_=_NextPart_001_01CB17E4.4AB23E4B
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7654.12">
<TITLE>Re: [PATCH] powerpc: introduce basic support for the Freescale =
P1022DS reference board</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Kim Phillips wrote:<BR>
&gt; On Tue, 29 Jun 2010 16:34:34 -0500<BR>
&gt; Timur Tabi&lt;timur@freescale.com&gt;&nbsp; wrote:<BR>
&gt;<BR>
&gt;&gt; Introduce basic support for the Freescale P1022DS reference =
board, based on the<BR>
&gt;&gt; Freescale BSP for this board.<BR>
&gt;&gt;<BR>
&gt;&gt; Details: No DIU video or SSI audio support, no MMC/SD card =
support, 36-bit and<BR>
&gt;&gt; SWIOTLB support enabled, 36-bit DTS only, and CONFIG_NO_HZ =
disabled because it<BR>
&gt;&gt; causes performance problems on this kernel.<BR>
&gt;<BR>
&gt; what kind of performance problems?<BR>
<BR>
See my post on linuxppc-dev about CONFIG_NO_HZ.<BR>
<BR>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue-group@0{<BR>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #address-cells =
=3D&lt;1&gt;;<BR>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #size-cells =3D&lt;1&gt;;<BR>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D&lt;0xB1000 =
0x1000&gt;;<BR>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fsl,rx-err-int-map =
=3D&lt;0xAA&gt;;<BR>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fsl,tx-int-map =
=3D&lt;0xAA&gt;;<BR>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupts =3D&lt;35 2 36 2 =
40 2&gt;;<BR>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<BR>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue-group@1{<BR>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #address-cells =
=3D&lt;1&gt;;<BR>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #size-cells =3D&lt;1&gt;;<BR>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D&lt;0xB5000 =
0x1000&gt;;<BR>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fsl,rx-err-int-map =
=3D&lt;0x55&gt;;<BR>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fsl,tx-int-map =
=3D&lt;0x55&gt;;<BR>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupts =3D&lt;51 2 52 2 =
67 2&gt;;<BR>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<BR>
&gt;<BR>
&gt; these queue-group nodes, fsl,{r,t}x-* properties...<BR>
<BR>
I just copied this tree from the BSP.&nbsp; I have no idea what they =
should ok<BR>
like.&nbsp; Can you be more specific?<BR>
<BR>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
crypto@30000 {<BR>
&gt;<BR>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fsl,multi-host-mode =3D =
&quot;dual&quot;;<BR>
&gt;&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fsl,channel-remap =
=3D&lt;0x3&gt;;<BR>
&gt;<BR>
&gt; and the above two properties aren't supported by their =
respective<BR>
&gt; drivers, nor are they listed in the dts bindings documentation.<BR>
<BR>
Then please tell me what these nodes should look like.<BR>
<BR>
<BR>
--<BR>
Timur Tabi<BR>
Linux kernel developer<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01CB17E4.4AB23E4B--
