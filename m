Return-Path: <srinivas.surabhi@wipro.com>
Received: from wip-ectls-mx3.wipro.com (wip-ectls-mx3.wipro.com
	[203.101.113.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wip-ectls-mx3.wipro.com",
	Issuer "certserv.wipro.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4156E67A65
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Feb 2005 01:29:28 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C514FC.FF000D5D"
Date: Thu, 17 Feb 2005 19:58:49 +0530
Message-ID: <EF9B29C78F41FA488927FCBC7750AF0E08DA16@hyd-mdp-msg.wipro.com>
From: <srinivas.surabhi@wipro.com>
To: <wd@denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Mounta Vista Linux prompt on serial console 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C514FC.FF000D5D
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


The latest update is that the init was also found in one of the packages.=
 So now I am not facing init not found problem . But there was a hung=
 problem, once the init is invoked .. Please find the output below...
=0D
RAMDISK: Compressed image found at block 0

Freeing initrd memory: 1235k freed

kjournald starting. Commit interval 5 seconds

EXT3-fs: mounted filesystem with ordered data mode.

VFS: Mounted root (ext3 filesystem) readonly.

Mounted devfs on /dev

Freeing unused kernel memory: 56k init

< there is no output after the above statement.....>=0D

Thanks & Regards
Surabhi Srinivas

________________________________

From: Wolfgang Denk [mailto:wd@denx.de]
Sent: Thu 2/17/2005 5:12 PM
To: Srinivas Surabhi (WT01 - EMBEDDED & PRODUCT ENGINEERING SOLUTIONS)
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Mounta Vista Linux prompt on serial console=0D



In message <EF9B29C78F41FA488927FCBC7750AF0E08DA14@hyd-mdp-msg.wipro.com>=
 you wrote:
>
> But the problem is that it was stopping at
>
> "No init found.  Try passing init=3D option to kernel". Before that there
>  were no errors. Everthing looks fine Mounted VFS root file system was=
 also

Fine. So you can mount the root filesystem, but it obviously does not
contain all the required files.

>  seen. From the net I understood is that the fstab file was the cause. So
>  edited the filesytem parameter for / as /dev/ram earlier it used to be
>  /dev/root.

No. /etc/fstab has absolutley nothing to do with  your  problem.  The
kernel  cannot  start  the  init  porocess - make sure init is in the
filesystem, plus all required libraries.

> So please tell me whether the given fstab file will suffice? The=
 filesystem

This is completley unrelated.

> 2. I have one more doubt /sbin/init utility comes with what package?
>  Because in /sbin directory although the init binary is present, not=
 shown
>  in the file system heirarchy view. For eg. if I select DHCPD package=
 then
>  able to see dhcpd related binary in the /sbin similarly my question was
>  which package has to be selected to have init included.

Please contact MV support. I have no  idea  how  they  package  their
distribution,  or  how  their  config  tools might work. You paid for
their stuff, so ask _them_.

Best regards,

Wolfgang Denk

--
See us @ Embedded World, Nuremberg, Feb 22 - 24,  Hall 10.0 Booth 310
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The most exciting phrase to hear in science, the one that heralds new
discoveries, is not "Eureka!" (I found it!) but "That's funny ..."
                                                      -- Isaac Asimov






Confidentiality Notice=0D

The information contained in this electronic message and any attachments to=
 this message are intended
for the exclusive use of the addressee(s) and may contain confidential or=
 privileged information. If
you are not the intended recipient, please notify the sender at Wipro or=
 Mailadmin@wipro.com immediately
and destroy all copies of this message and any attachments.
------_=_NextPart_001_01C514FC.FF000D5D
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=
=3Diso-8859-1">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>

<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version=
 6.5.7232.39">
<TITLE>Re: Mounta Vista Linux prompt on serial console </TITLE>
</HEAD>
<BODY>
<DIV id=3DidOWAReplyText29619 dir=3Dltr>
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 size=3D2>The latest=
 update is that the=0D
init was also found in one of the packages. So now I am not facing init not=
=0D
found problem . But there was a hung problem, once the init is invoked ..=
 Please=0D
find the output below...</FONT></DIV>
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV dir=3Dltr><FONT size=3D2>
<P>RAMDISK: Compressed image found at block 0</P>
<P>Freeing initrd memory: 1235k freed</P>
<P>kjournald starting. Commit interval 5 seconds</P>
<P>EXT3-fs: mounted filesystem with ordered data mode.</P>
<P>VFS: Mounted root (ext3 filesystem) readonly.</P>
<P>Mounted devfs on /dev</P>
<P>Freeing unused kernel memory: 56k init</P>
<P>&lt; there is no output after the above statement.....&gt;=
 </P></FONT></DIV>
<DIV dir=3Dltr><FONT face=3DArial size=3D2>Thanks &amp;=
 Regards</FONT></DIV>
<DIV dir=3Dltr><FONT face=3DArial size=3D2>Surabhi=
 Srinivas</FONT></DIV></DIV>
<DIV dir=3Dltr><BR>
<HR tabIndex=3D-1>
<FONT face=3DTahoma size=3D2><B>From:</B> Wolfgang Denk=0D
[mailto:wd@denx.de]<BR><B>Sent:</B> Thu 2/17/2005 5:12 PM<BR><B>To:</B>=
 Srinivas=0D
Surabhi (WT01 - EMBEDDED &amp; PRODUCT ENGINEERING SOLUTIONS)<BR><B>Cc:</B>=
=0D
linuxppc-embedded@ozlabs.org<BR><B>Subject:</B> Re: Mounta Vista Linux=
 prompt on=0D
serial console <BR></FONT><BR></DIV>
<DIV>
<P><FONT size=3D2>In message=0D
&lt;EF9B29C78F41FA488927FCBC7750AF0E08DA14@hyd-mdp-msg.wipro.com&gt; you=0D
wrote:<BR>&gt;<BR>&gt; But the problem is that it was stopping=0D
at<BR>&gt;<BR>&gt; "No init found.&nbsp; Try passing init=3D option to=
 kernel".=0D
Before that there<BR>&gt;&nbsp; were no errors. Everthing looks fine=
 Mounted VFS=0D
root file system was also<BR><BR>Fine. So you can mount the root=
 filesystem, but=0D
it obviously does not<BR>contain all the required files.<BR><BR>&gt;&nbsp;=
 seen.=0D
>From the net I understood is that the fstab file was the cause.=
 So<BR>&gt;&nbsp;=0D
edited the filesytem parameter for / as /dev/ram earlier it used to=0D
be<BR>&gt;&nbsp; /dev/root.<BR><BR>No. /etc/fstab has absolutley nothing to=
 do=0D
with&nbsp; your&nbsp; problem.&nbsp; The<BR>kernel&nbsp; cannot&nbsp;=0D
start&nbsp; the&nbsp; init&nbsp; porocess - make sure init is in=0D
the<BR>filesystem, plus all required libraries.<BR><BR>&gt; So please tell=
 me=0D
whether the given fstab file will suffice? The filesystem<BR><BR>This is=0D
completley unrelated.<BR><BR>&gt; 2. I have one more doubt /sbin/init=
 utility=0D
comes with what package?<BR>&gt;&nbsp; Because in /sbin directory although=
 the=0D
init binary is present, not shown<BR>&gt;&nbsp; in the file system=
 heirarchy=0D
view. For eg. if I select DHCPD package then<BR>&gt;&nbsp; able to see=
 dhcpd=0D
related binary in the /sbin similarly my question was<BR>&gt;&nbsp; which=0D
package has to be selected to have init included.<BR><BR>Please contact MV=
=0D
support. I have no&nbsp; idea&nbsp; how&nbsp; they&nbsp; package&nbsp;=0D
their<BR>distribution,&nbsp; or&nbsp; how&nbsp; their&nbsp; config&nbsp;=
 tools=0D
might work. You paid for<BR>their stuff, so ask _them_.<BR><BR>Best=0D
regards,<BR><BR>Wolfgang Denk<BR><BR>--<BR>See us @ Embedded World,=
 Nuremberg,=0D
Feb 22 - 24,&nbsp; Hall 10.0 Booth 310<BR>Phone: (+49)-8142-66989-10 Fax:=0D
(+49)-8142-66989-80 Email: wd@denx.de<BR>The most exciting phrase to hear=
 in=0D
science, the one that heralds new<BR>discoveries, is not "Eureka!" (I found=
 it!)=0D
but "That's funny=0D
..."<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;=0D
-- Isaac Asimov<BR></FONT></P></DIV>

</BODY>
</HTML>
<table><tr><td bgcolor=3D#ffffff><font color=3D#000000><br>
<br>
Confidentiality Notice <br>
<br>
The information contained in this electronic message and any attachments to=
 this message are intended<br>
for the exclusive use of the addressee(s) and may contain confidential or=
 privileged information. If<br>
you are not the intended recipient, please notify the sender at Wipro or=
 Mailadmin@wipro.com immediately<br>
and destroy all copies of this message and any attachments.<br>
</font></td></tr></table>
------_=_NextPart_001_01C514FC.FF000D5D--
