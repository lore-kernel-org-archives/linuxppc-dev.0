Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound3-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 7533ADDF22
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Apr 2008 01:49:21 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8AA10.90DD9CDE"
Subject: RE: Virtex4FX12LC hangs in calibrating delay loop
Date: Tue, 29 Apr 2008 08:47:23 -0700
References: <20070621151554.GA22663@cip.informatik.uni-erlangen.de>
	<16955743.post@talk.nabble.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "wangyanlong" <killyouatonce@gmail.com>,
	<linuxppc-embedded@ozlabs.org>
Message-Id: <20080429154912.310D417D808D@mail80-dub.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8AA10.90DD9CDE
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


I think I've seen this happen when the boot code doesn't have the =
workarounds for the cache errata.  I'm not sure if that code ever made
it into grant's git server, but it's definitely is in the xilinx git =
tree at git.xilinx.com.

Steve

-----Original Message-----
From: linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org =
on behalf of wangyanlong
Sent: Tue 4/29/2008 1:53 AM
To: linuxppc-embedded@ozlabs.org
Subject: Re: Virtex4FX12LC hangs in calibrating delay loop
=20

I meet the same problem as yours ,  have you fix your problem now ??? I =
am
keep trying !!!!

Thomas Glanzmann wrote:
>=20
> Hello,
> I used the HEAD secretlabs kernel and used ml403 defconfig. I still =
see
> no serial output from the _kernel_ on the serial console. But I do see
> output from the in kernel embedded boot loader "load_kernel". I typed =
in
> stop in xmd and got an instruction pointer which points to:
>=20
>         c00045a0 <__delay>:
>         c00045a0:       2c 03 00 00     cmpwi   r3,0
>         c00045a4:       7c 69 03 a6     mtctr   r3
>         c00045a8:       4d 82 00 20     beqlr
>         c00045ac:       42 00 00 00     bdnz-   c00045ac <__delay+0xc> =
    =20
> <<<<<<<<
>         c00045b0:       4e 80 00 20     blr
>=20
> So I guess it is the calibrating delay loop and I am not sure. I can
> reproduce
> this. It is always in this function. Now I wonder is my board missing
> timer interrupts? What could be the reason for this. And of course one
> much more important question:
>=20
>         - Is the serial console initialized before or after the
>           calibrating delay loop?
>=20
> Is there a way to get a backtrace out of this? If that is the case =
what
> do I have to do? Recompile the Kernel with frame pointers and attach
> gdb?
>=20
>         Thomas
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
>=20

--=20
View this message in context: =
http://www.nabble.com/Virtex4FX12LC-hangs-in-calibrating-delay-loop-tp112=
35297p16955743.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded



------_=_NextPart_001_01C8AA10.90DD9CDE
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7652.24">
<TITLE>RE: Virtex4FX12LC hangs in calibrating delay loop</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>I think I've seen this happen when the boot code =
doesn't have the workarounds for the cache errata.&nbsp; I'm not sure if =
that code ever made<BR>
it into grant's git server, but it's definitely is in the xilinx git =
tree at git.xilinx.com.<BR>
<BR>
Steve<BR>
<BR>
-----Original Message-----<BR>
From: linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org =
on behalf of wangyanlong<BR>
Sent: Tue 4/29/2008 1:53 AM<BR>
To: linuxppc-embedded@ozlabs.org<BR>
Subject: Re: Virtex4FX12LC hangs in calibrating delay loop<BR>
<BR>
<BR>
I meet the same problem as yours ,&nbsp; have you fix your problem now =
??? I am<BR>
keep trying !!!!<BR>
<BR>
Thomas Glanzmann wrote:<BR>
&gt;<BR>
&gt; Hello,<BR>
&gt; I used the HEAD secretlabs kernel and used ml403 defconfig. I still =
see<BR>
&gt; no serial output from the _kernel_ on the serial console. But I do =
see<BR>
&gt; output from the in kernel embedded boot loader =
&quot;load_kernel&quot;. I typed in<BR>
&gt; stop in xmd and got an instruction pointer which points to:<BR>
&gt;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c00045a0 =
&lt;__delay&gt;:<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
c00045a0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2c 03 00 =
00&nbsp;&nbsp;&nbsp;&nbsp; cmpwi&nbsp;&nbsp; r3,0<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
c00045a4:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7c 69 03 =
a6&nbsp;&nbsp;&nbsp;&nbsp; mtctr&nbsp;&nbsp; r3<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
c00045a8:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4d 82 00 =
20&nbsp;&nbsp;&nbsp;&nbsp; beqlr<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
c00045ac:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 42 00 00 =
00&nbsp;&nbsp;&nbsp;&nbsp; bdnz-&nbsp;&nbsp; c00045ac =
&lt;__delay+0xc&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&gt; &lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
c00045b0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4e 80 00 =
20&nbsp;&nbsp;&nbsp;&nbsp; blr<BR>
&gt;<BR>
&gt; So I guess it is the calibrating delay loop and I am not sure. I =
can<BR>
&gt; reproduce<BR>
&gt; this. It is always in this function. Now I wonder is my board =
missing<BR>
&gt; timer interrupts? What could be the reason for this. And of course =
one<BR>
&gt; much more important question:<BR>
&gt;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - Is the serial =
console initialized before or after the<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
calibrating delay loop?<BR>
&gt;<BR>
&gt; Is there a way to get a backtrace out of this? If that is the case =
what<BR>
&gt; do I have to do? Recompile the Kernel with frame pointers and =
attach<BR>
&gt; gdb?<BR>
&gt;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Thomas<BR>
&gt; _______________________________________________<BR>
&gt; Linuxppc-embedded mailing list<BR>
&gt; Linuxppc-embedded@ozlabs.org<BR>
&gt; <A =
HREF=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://oz=
labs.org/mailman/listinfo/linuxppc-embedded</A><BR>
&gt;<BR>
&gt;<BR>
<BR>
--<BR>
View this message in context: <A =
HREF=3D"http://www.nabble.com/Virtex4FX12LC-hangs-in-calibrating-delay-lo=
op-tp11235297p16955743.html">http://www.nabble.com/Virtex4FX12LC-hangs-in=
-calibrating-delay-loop-tp11235297p16955743.html</A><BR>
Sent from the linuxppc-embedded mailing list archive at Nabble.com.<BR>
<BR>
_______________________________________________<BR>
Linuxppc-embedded mailing list<BR>
Linuxppc-embedded@ozlabs.org<BR>
<A =
HREF=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://oz=
labs.org/mailman/listinfo/linuxppc-embedded</A><BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C8AA10.90DD9CDE--
