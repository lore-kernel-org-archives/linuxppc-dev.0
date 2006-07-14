Return-Path: <rza1@so-logic.co.at>
Received: from mail.so-logic.net (mail.so-logic.net [62.99.208.149])
	by ozlabs.org (Postfix) with ESMTP id 7EE1867A3E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Jul 2006 20:14:12 +1000 (EST)
Received: from localhost (mail.so-logic.net [62.99.208.149])
	by mail.so-logic.net (Postfix) with ESMTP id 657CB155D6
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Jul 2006 11:47:05 +0200 (CEST)
Received: from [192.168.1.196] (62-99-208-147.c-vbergg.xdsl-line.inode.at
	[62.99.208.147])
	by mail.so-logic.net (Postfix) with ESMTP id 86CE3155F2
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Jul 2006 11:46:45 +0200 (CEST)
Mime-Version: 1.0 (Apple Message framework v752.2)
To: linuxppc-embedded@ozlabs.org
Message-Id: <1397A8F2-0E9E-40B9-AB4B-132C30C09F25@so-logic.co.at>
Content-Type: multipart/alternative; boundary=Apple-Mail-1-618626276
From: Robert Zach so-logic <rza1@so-logic.co.at>
Subject: native gcc for ml403(ppc405)
Date: Fri, 14 Jul 2006 12:13:21 +0200
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--Apple-Mail-1-618626276
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

Hello!

I am working on a ml403 with virtex 4 (ppc405).
I have build me a crosscompiler and  a glibc with crosstool.
This worked very good for me...(i can compile 2.4 and 2.6 kernel...)

Now i would like to build a native compiler for the ppc405...(I need  
a native compiler for a few things that are hard to crosscompile.)

Is it possible to compile the binutils and gcc with my crosscompiler  
to get a native compiler??

Yes anybody done this already? How?

Thanks in Advanced!

Nice greetings
Robert Zach
robert.zach@wvnet.at



--Apple-Mail-1-618626276
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=ISO-8859-1

<HTML><BODY style=3D"word-wrap: break-word; -khtml-nbsp-mode: space; =
-khtml-line-break: after-white-space; "><DIV>Hello!</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>I am working on a ml403 =
with virtex 4 (ppc405).</DIV><DIV>I have build me a crosscompiler and=A0 =
a glibc with crosstool.</DIV><DIV>This worked very good for me...(i can =
compile 2.4 and 2.6 kernel...)</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>Now i would like to build a =
native compiler for the ppc405...(I need a native compiler for a few =
things that are hard to crosscompile.)</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>Is it possible to compile =
the binutils and gcc with my crosscompiler to get a native =
compiler??</DIV><DIV><BR class=3D"khtml-block-placeholder"></DIV><DIV>Yes =
anybody done this already? How?</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>Thanks in =
Advanced!</DIV><BR><DIV> <SPAN class=3D"Apple-style-span" =
style=3D"border-collapse: separate; border-spacing: 0px 0px; color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant: normal; font-weight: normal; letter-spacing: =
normal; line-height: normal; text-align: auto; =
-khtml-text-decorations-in-effect: none; text-indent: 0px; =
-apple-text-size-adjust: auto; text-transform: none; orphans: 2; =
white-space: normal; widows: 2; word-spacing: 0px; "><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; "><FONT class=3D"Apple-style-span" face=3D"Arial" =
size=3D"4"><SPAN class=3D"Apple-style-span" style=3D"font-size: 13.3px;; =
font-family: Arial; ">Nice greetings=A0<SPAN class=3D"Apple-style-span" =
style=3D"font-family: Arial; font-size: 13.3px; =
"></SPAN></SPAN></FONT></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><FONT =
class=3D"Apple-style-span" face=3D"Arial" size=3D"4"><SPAN =
class=3D"Apple-style-span" style=3D"font-size: 13.3px;; font-family: =
Arial; "><SPAN class=3D"Apple-style-span" style=3D"font-family: Arial; =
font-size: 13.3px; ">Robert Zach</SPAN></SPAN></FONT></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; "><A href=3D"mailto:robert.zach@wvnet.at"><FONT =
class=3D"Apple-style-span" face=3D"Arial" size=3D"4"><SPAN =
class=3D"Apple-style-span" style=3D"font-size: 13.3px;; color: rgb(0, 0, =
238); font-family: Arial; -khtml-text-decorations-in-effect: underline; =
"><SPAN class=3D"Apple-style-span" style=3D"color: rgb(0, 0, 238); =
font-family: Arial; font-size: 13.3px; =
-khtml-text-decorations-in-effect: underline; =
">robert.zach@wvnet.at</SPAN></SPAN></FONT></A></DIV><BR =
class=3D"Apple-interchange-newline"></SPAN> </DIV><BR></BODY></HTML>=

--Apple-Mail-1-618626276--
