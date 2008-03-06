Return-Path: <rmcguire@videopresence.com>
Received: from smtpauth05.prod.mesa1.secureserver.net
	(smtpauth05.prod.mesa1.secureserver.net [64.202.165.99])
	by ozlabs.org (Postfix) with SMTP id 0BD79DDE32
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Mar 2008 20:25:50 +1100 (EST)
From: "Russell McGuire" <rmcguire@videopresence.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: RAW Sockets - HDLC or Ethernet
Date: Thu, 6 Mar 2008 01:24:30 -0800
Message-ID: <000001c87f6b$e1d5e9e0$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0001_01C87F28.D3B2A9E0"
Reply-To: rmcguire@videopresence.com
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

------=_NextPart_000_0001_01C87F28.D3B2A9E0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Anyone,

Yet another mysterious question, at least to me.

I have written to simple utilities to send and receive a file / data through
a newly created driver, HDLC using an MPC8360E. 
Though I doubt this question is limited to that specific HW.

The main question is that everything I send though device HDLC0 I can
immediately read from HDLC0 even though logically there is no connection
there. It as if the kernel is immediately allowing me to read from the same
device, what a separate application just wrote.???
HOW CAN THIS BE?

Details:
I have two applications: send and receive.  (pseudo code as follows)

Send opens a socket(PF_PACKET, SOCK_RAW, htons(ETH_P_ALL)).
And binds it (AF_PACKET, ETH_P_HLDC, if_index(hdlc0))

Receive opens a socket to the same device 
socket(PF_PACKET, SOCK_RAW, htons(ETH_P_ALL))
bind(AF_PACKET, ETH_P_ALL, if_index(hdlc0)

Note they are opening the same device.

Now if I send anything through the send application, I immediately receive
it via the receive application??
Note, entirely separate processes!

Note, there is NO hardware loopback, this should be a dead end, and I should
get nothing back at least as far as HW is concerned.

What am I missing, that causes all my TX data to show up immediately in the
RX app? Note I have verified my HDLC drier is not actually receiving
anything, so is there something in the kernel that is bridging the TX / RX
paths, or am I just missing the function of this? If so how can I use RAW
mode, while not mixing this, or at least keeping them separate in the
applications?

-Russ

------=_NextPart_000_0001_01C87F28.D3B2A9E0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7036.0">
<TITLE>RAW Sockets - HDLC or Ethernet</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT =
SIZE=3D2 FACE=3D"Arial">Anyone,</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">Yet</FONT><FONT SIZE=3D2 FACE=3D"Arial"> another =
mys</FONT><FONT SIZE=3D2 FACE=3D"Arial">terious question, at least to =
me.</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">I have =
written to simple utilities to send an</FONT><FONT SIZE=3D2 =
FACE=3D"Arial">d</FONT><FONT SIZE=3D2 FACE=3D"Arial"> receive a =
file</FONT> <FONT SIZE=3D2 FACE=3D"Arial">/ data through a =
newl</FONT><FONT SIZE=3D2 FACE=3D"Arial">y created</FONT><FONT SIZE=3D2 =
FACE=3D"Arial"> driver, HDLC using an MPC8360E.</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> </SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Though I =
doubt this question is</FONT> <FONT SIZE=3D2 FACE=3D"Arial">limited to =
that specific HW.</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">The main =
question is that</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Arial">everything</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"></FONT> <FONT SIZE=3D2 =
FACE=3D"Arial">I send though</FONT> <FONT SIZE=3D2 =
FACE=3D"Arial">device</FONT> <FONT SIZE=3D2 =
FACE=3D"Arial">HDLC</FONT><FONT SIZE=3D2 FACE=3D"Arial">0 I can =
immediately read from HDLC0 even though logically there is no connection =
t</FONT><FONT SIZE=3D2 FACE=3D"Arial">h</FONT><FONT SIZE=3D2 =
FACE=3D"Arial">e</FONT><FONT SIZE=3D2 FACE=3D"Arial">r</FONT><FONT =
SIZE=3D2 FACE=3D"Arial">e</FONT><FONT SIZE=3D2 =
FACE=3D"Arial">.</FONT><FONT SIZE=3D2 FACE=3D"Arial"> I</FONT><FONT =
SIZE=3D2 FACE=3D"Arial">t as if the kernel is</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Arial">immediately</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial"></FONT> <FONT SIZE=3D2 FACE=3D"Arial">allowing =
m</FONT><FONT SIZE=3D2 FACE=3D"Arial">e</FONT><FONT SIZE=3D2 =
FACE=3D"Arial"> to read</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"> <FONT SIZE=3D2 FACE=3D"Arial">from =
the</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT =
SIZE=3D2 FACE=3D"Arial"></FONT> <FONT SIZE=3D2 FACE=3D"Arial">same =
device, what a</FONT> <FONT SIZE=3D2 FACE=3D"Arial">separate</FONT><FONT =
SIZE=3D2 FACE=3D"Arial"> application</FONT><FONT SIZE=3D2 =
FACE=3D"Arial"> just wrote.</FONT><FONT SIZE=3D2 =
FACE=3D"Arial">???</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">HOW CAN =
THIS BE?</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">Details</FONT><FONT SIZE=3D2 =
FACE=3D"Arial">:</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">I have =
two applications:</FONT><FONT SIZE=3D2 FACE=3D"Arial"></FONT> <FONT =
SIZE=3D2 FACE=3D"Arial">s</FONT><FONT SIZE=3D2 FACE=3D"Arial">end</FONT> =
<FONT SIZE=3D2 FACE=3D"Arial">and</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Arial">receive</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">.</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;</FONT> <FONT SIZE=3D2 =
FACE=3D"Arial">(ps</FONT><FONT SIZE=3D2 FACE=3D"Arial">e</FONT><FONT =
SIZE=3D2 FACE=3D"Arial">u</FONT><FONT SIZE=3D2 =
FACE=3D"Arial">do</FONT><FONT SIZE=3D2 FACE=3D"Arial"> code as =
follows)</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Send =
opens a</FONT> <FONT SIZE=3D2 FACE=3D"Arial">socket(</FONT><FONT =
SIZE=3D2 FACE=3D"Arial">PF_PACKET, SOCK_RAW, =
htons(ETH_P_ALL)</FONT><FONT SIZE=3D2 =
FACE=3D"Arial">).</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT =
SIZE=3D2 FACE=3D"Arial">A</FONT><FONT SIZE=3D2 FACE=3D"Arial">nd</FONT> =
<FONT SIZE=3D2 FACE=3D"Arial">binds it (</FONT><FONT SIZE=3D2 =
FACE=3D"Arial">AF_PACKET, ETH_P_HLDC,</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Arial">if</FONT><FONT SIZE=3D2 FACE=3D"Arial">_</FONT><FONT =
SIZE=3D2 FACE=3D"Arial">index(hdlc0)</FONT><FONT SIZE=3D2 =
FACE=3D"Arial">)</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">R</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">eceive</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial"></FONT> <FONT SIZE=3D2 FACE=3D"Arial">opens a =
socket</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> =
<FONT SIZE=3D2 FACE=3D"Arial">to the</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial"></FONT> <FONT SIZE=3D2 FACE=3D"Arial">same device =
</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT =
SIZE=3D2 FACE=3D"Arial">socket</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">(</FONT><FONT SIZE=3D2 FACE=3D"Arial">PF_PACKET, =
SOCK_RAW, htons(ETH_P_ALL))</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT =
SIZE=3D2 FACE=3D"Arial">bind(AF_PACKET, ETH_P_ALL, =
if_index(hdlc0)</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Note =
they</FONT><FONT SIZE=3D2 FACE=3D"Arial"></FONT> <FONT SIZE=3D2 =
FACE=3D"Arial">a</FONT><FONT SIZE=3D2 FACE=3D"Arial">re open</FONT><FONT =
SIZE=3D2 FACE=3D"Arial">ing the same device.</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">No</FONT><FONT SIZE=3D2 FACE=3D"Arial">w</FONT><FONT =
SIZE=3D2 FACE=3D"Arial"></FONT> <FONT SIZE=3D2 FACE=3D"Arial">if I send =
anything</FONT><FONT SIZE=3D2 FACE=3D"Arial"> through the send =
application, I immediately</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Arial">receive</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"></FONT> <FONT SIZE=3D2 =
FACE=3D"Arial">it via the</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"> <FONT SIZE=3D2 FACE=3D"Arial">receive</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial"></FONT> <FONT SIZE=3D2 =
FACE=3D"Arial">application??</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Note, =
entirely separate processes!</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Note, =
there is NO hardware loopback, this should be a dead end</FONT><FONT =
SIZE=3D2 FACE=3D"Arial">, and I should get nothing =
bac</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT =
SIZE=3D2 FACE=3D"Arial">k at least as far as HW is =
concerned.</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">What am =
I missing, that</FONT> <FONT SIZE=3D2 FACE=3D"Arial">causes</FONT><FONT =
SIZE=3D2 FACE=3D"Arial"> all my</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Arial">T</FONT><FONT SIZE=3D2 =
FACE=3D"Arial">X</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"> data to show =
up</FONT><FONT SIZE=3D2 FACE=3D"Arial"> immediately</FONT> <FONT =
SIZE=3D2 FACE=3D"Arial">in th</FONT><FONT SIZE=3D2 =
FACE=3D"Arial">e</FONT><FONT SIZE=3D2 FACE=3D"Arial"> RX =
app?</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT =
SIZE=3D2 FACE=3D"Arial"> N</FONT><FONT SIZE=3D2 FACE=3D"Arial">ote I =
have verified my HDLC drier is not</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Arial">actually</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"></FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Arial">receiving</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"></FONT> <FONT SIZE=3D2 =
FACE=3D"Arial">anything, so is there something</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Arial">in the</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"></FONT> <FONT SIZE=3D2 =
FACE=3D"Arial">kernel that is bridging the TX / RX paths, or am I just =
missing the</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Arial">function</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"></FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT SIZE=3D2 =
FACE=3D"Arial">of this?</FONT> <FONT SIZE=3D2 FACE=3D"Arial">If so how =
can I use RAW mode, while not mixing this, or at least keeping =
them</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> =
<FONT SIZE=3D2 FACE=3D"Arial">separate</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial"></FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"> <FONT SIZE=3D2 FACE=3D"Arial">in the</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial"></FONT> <FONT SIZE=3D2 =
FACE=3D"Arial">applications?</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">-Russ</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

</BODY>
</HTML>
------=_NextPart_000_0001_01C87F28.D3B2A9E0--
