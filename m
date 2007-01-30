Return-Path: <joe-worker@anti-paladin.com>
Received: from mail.hier.us (adsl-66-218-62-12.dslextreme.com [66.218.62.12])
	by ozlabs.org (Postfix) with ESMTP id 1C9B7DDEBE
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 Jan 2007 16:14:24 +1100 (EST)
Received: from localhost (fillmore [127.0.0.1])
	by mail.hier.us (Postfix) with ESMTP id 29DDF20192
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 29 Jan 2007 20:51:47 -0800 (PST)
Mime-Version: 1.0 (Apple Message framework v752.3)
Message-Id: <89CE61D4-C939-4788-A0AE-30EF410E9628@anti-paladin.com>
Content-Type: multipart/alternative; boundary=Apple-Mail-1-699457625
To: linuxppc-embedded@ozlabs.org
Subject: Led astray? Xilinx ml410 + u-boot + Linux?
From: Joe <joe-worker@anti-paladin.com>
Date: Mon, 29 Jan 2007 20:51:42 -0800
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--Apple-Mail-1-699457625
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

I was told (by Xilinx reps!) that the Xilinx ML410 "supported" Linux.

My goal is to have something "load" Linux and then execute it --  
preferably over NFS / Ethernet (for development purposes).

As far as I can tell from searching the 'Net the ML403 is fairly well  
supported but I have yet to see any level of confirmation that the  
ML410 fully supports u-boot, Linux and Ethernet.

When I download the u-boot file(s) from Xilinx they basically don't  
work:

   0)  I get a u-boot command prompt via the serial port!! ;)
   1)  The u-boot loadb command fails to accept any data via the  
kermit protocol
   2)  The u-boot 'dhcp' command fails to obtain an address -- either  
by simply crashing or by sitting there indicating that it is re- 
trying (in which case an Ethernet sniffer shows no activity from the  
Ethernet ports).

Linux 2.6.19 shows arc/ppc/configs/ml[403|300]_defconfig, but I see  
*zero* indication that the 410 is supported.  Has anyone seen the  
ML410 fully functional with Linux + a patch to enable the Ethernet  
ports?
(I also note that on the mvi$ta site they list support for:  ML300  
and ML40x -- but NOT the ML410.)  My searches also seem to indicate  
that the IP included for the 410 Ethernet MAC's is distinctly  
different from the 403...

My current project has a *very* short fuse -- I should have been  
"running" (e.g. past init into a shell w/filesystem) two weeks ago.

If someone could confirm that this platform *is* supported (and I'm  
just missing this on my searches) I'd be quite grateful for some  
pointers on where to re-direct my searches.

OTOH, if someone could confirm that this platform is NOT currently  
supported that would be just as useful -- decisions can be made and  
actions taken.

TIA.

-- 
Joe





--Apple-Mail-1-699457625
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=ISO-8859-1

<HTML><BODY style=3D"word-wrap: break-word; -khtml-nbsp-mode: space; =
-khtml-line-break: after-white-space; ">I was told (by Xilinx reps!) =
that the Xilinx ML410 "supported" Linux.<DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>My goal is to have =
something "load" Linux and then execute it -- preferably over NFS / =
Ethernet (for development purposes).</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>As=A0far as I can tell from =
searching the 'Net the ML403 is fairly well supported but I have yet to =
see any level of confirmation that the ML410 fully supports u-boot, =
Linux and Ethernet.</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>When I download the u-boot =
file(s) from Xilinx they basically don't work:</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>=A0 0)=A0 I get a u-boot =
command prompt via the serial port!! ;)</DIV><DIV>=A0 1)=A0 The u-boot =
loadb command fails to accept any data via the kermit =
protocol</DIV><DIV>=A0 2)=A0 The u-boot 'dhcp' command fails to obtain =
an address -- either by simply crashing or by sitting there indicating =
that it is re-trying (in which case an Ethernet sniffer shows no =
activity from the Ethernet ports).</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>Linux 2.6.19 shows =
arc/ppc/configs/ml[403|300]_defconfig, but I see *zero* indication that =
the 410 is supported.=A0 Has anyone seen the ML410 fully functional with =
Linux + a patch to enable the Ethernet ports?</DIV><DIV>(I also note =
that on the mvi$ta site they list support for:=A0 ML300 and ML40x -- but =
NOT the ML410.)=A0 My searches also seem to indicate that the IP =
included for the 410 Ethernet MAC's is distinctly different from the =
403...</DIV><DIV><BR class=3D"khtml-block-placeholder"></DIV><DIV>My =
current project has a *very* short fuse -- I should have been "running" =
(e.g. past init into a shell w/filesystem) two weeks ago.</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>If someone could confirm =
that this platform *is* supported (and I'm just missing this on my =
searches) I'd be quite grateful for some pointers on where to re-direct =
my searches.</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>OTOH, if someone could =
confirm that this platform is NOT currently supported that would be just =
as useful -- decisions can be made and actions taken.</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>TIA.</DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV><DIV> <SPAN =
class=3D"Apple-style-span" style=3D"border-collapse: separate; =
border-spacing: 0px 0px; color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 14px; font-style: normal; font-variant: normal; font-weight: =
normal; letter-spacing: normal; line-height: normal; text-align: auto; =
-khtml-text-decorations-in-effect: none; text-indent: 0px; =
-apple-text-size-adjust: auto; text-transform: none; orphans: 2; =
white-space: normal; widows: 2; word-spacing: 0px; "><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; "><FONT class=3D"Apple-style-span" size=3D"3"><SPAN =
class=3D"Apple-style-span" style=3D"font-size: 12px;"><SPAN =
class=3D"Apple-style-span" style=3D"font-size: 12px; =
">--=A0</SPAN></SPAN></FONT></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><FONT =
class=3D"Apple-style-span" size=3D"3"><SPAN class=3D"Apple-style-span" =
style=3D"font-size: 12px;"><SPAN class=3D"Apple-style-span" =
style=3D"font-size: 12px; ">Joe</SPAN></SPAN></FONT></DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV><BR =
class=3D"khtml-block-placeholder"></DIV><BR =
class=3D"Apple-interchange-newline"></SPAN> =
</DIV><BR></DIV></BODY></HTML>=

--Apple-Mail-1-699457625--
