Return-Path: <GRuescher@dspace.de>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C780DD.22586D62"
Subject: Problem cloning Linus' GIT tree!
Date: Tue, 17 Apr 2007 11:42:45 +0100
Message-ID: <18A49CF3586FC14290887ECC63C9141F0104D042@exchange2003.dspace.de>
From: "Gerald Ruescher" <GRuescher@dspace.de>
To: <Linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C780DD.22586D62
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Folks,

stupid newbie question:

I'm trying to get Grant Likelys latest TEMAC driver from his git-tree.
Follwing the directions on the secretlab.ca website I start by cloning=20
Linus' tree.  Since I'm behind a firewall which blocks the git port I =
use:

   git clone =
http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

At first everything is fine and git happily seems to download the tree.
After a while however, git exits with the following error message:

   error: Couldn't get =
http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/ref=
s/tags/v2.6.11 for tags/v2.6.11
   The requested URL returned error: 404
   error: Could not interpret tags/v2.6.11 as something to pull
   rm: cannot remove directory =
`/cygdrive/c/home/git/linux-2.6/.git/clone-tmp': Directory not empty

Any hint what I did wrong? =20

Many thanks in advance,
	Gerald

_______________________________________________

Gerald R=FCscher
Software Development Engineer
Core Real-Time Implementation

dSPACE GmbH          Tel.:  +49 5251 1638-1826
Technologiepark 25   Fax:   +49 5251 16198-1826
33100 Paderborn      http://www.dspace.de
Germany              mailto:GRuescher@dspace.de
_______________________________________________



------_=_NextPart_001_01C780DD.22586D62
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7233.69">
<TITLE>Problem cloning Linus' GIT tree!</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Hi Folks,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">stupid newbie question:</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I'm trying to get Grant Likelys latest =
TEMAC driver from his git-tree.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Follwing the directions on the =
secretlab.ca website I start by cloning </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Linus' tree.&nbsp; Since I'm behind a =
firewall which blocks the git port I use:</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp; git clone </FONT><A =
HREF=3D"http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6=
.git"><U><FONT COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"Arial">http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux-2.6.git</FONT></U></A>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">At first everything is fine and git =
happily seems to download the tree.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">After a while however, git exits with =
the following error message:</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp; error: Couldn't get =
</FONT><A =
HREF=3D"http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6=
.git/refs/tags/v2.6.11"><U><FONT COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"Arial">http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux-2.6.git/refs/tags/v2.6.11</FONT></U></A><FONT SIZE=3D2 =
FACE=3D"Arial"> for tags/v2.6.11</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp; The requested URL returned =
error: 404</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp; error: Could not =
interpret tags/v2.6.11 as something to pull</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp; rm: cannot remove =
directory `/cygdrive/c/home/git/linux-2.6/.git/clone-tmp': Directory not =
empty</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Any hint what I did wrong?&nbsp; =
</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Many thanks in advance,</FONT>

<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2 =
FACE=3D"Arial">Gerald</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier =
New">_______________________________________________</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Gerald R=FCscher</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Software Development =
Engineer</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Core Real-Time =
Implementation</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">dSPACE =
GmbH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Tel.:&nbsp; =
+49 5251 1638-1826</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Technologiepark 25&nbsp;&nbsp; =
Fax:&nbsp;&nbsp; +49 5251</FONT> <FONT SIZE=3D2 FACE=3D"Courier =
New">16198-</FONT><FONT SIZE=3D2 FACE=3D"Courier New">1826</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">33100 =
Paderborn&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT><A =
HREF=3D"http://www.dspace.de"><U><FONT COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"Courier New">http://www.dspace.de</FONT></U></A>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">Germany&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; </FONT><A HREF=3D"mailto:GRuescher@dspace.de"><U><FONT =
COLOR=3D"#0000FF" SIZE=3D2 FACE=3D"Courier =
New">mailto:GRuescher@dspace.de</FONT></U></A>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">_______________________________________________</FONT>
</P>
<BR>

</BODY>
</HTML>
------_=_NextPart_001_01C780DD.22586D62--
