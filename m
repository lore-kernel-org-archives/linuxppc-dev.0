Return-Path: <sumeshkkn@hotmail.com>
Received: from snt0-omc3-s30.snt0.hotmail.com (snt0-omc3-s30.snt0.hotmail.com
 [65.55.90.169]) by ozlabs.org (Postfix) with ESMTP id D17212C0330
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Oct 2013 19:52:40 +1100 (EST)
Message-ID: <SNT145-W100B62E3580B96CDF6ED340B41E0@phx.gbl>
Content-Type: multipart/alternative;
 boundary="_5f6d327a-16fa-4a36-bb56-29e018f2bb96_"
From: Sumesh Kaana <sumeshkkn@hotmail.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Loading and executing non-Linux kernel outside Linux memory.
Date: Thu, 10 Oct 2013 08:47:28 +0000
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_5f6d327a-16fa-4a36-bb56-29e018f2bb96_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi=2C
I'm running Linux on a PowerPC-44x based board with 256 Megabytes of RAM at=
 0x5000.0000 - 0x6000.0000.Upon an error interrupt=2C I should load my reco=
very module(non-Linux kernel) at 0x4000.0000 and jump the execution to this=
.
Any suggestions for this implementation?=20
Would kexec allow me to load an image ouside linux's memory?



Thanks=2CSumesh.  		 	   		  =

--_5f6d327a-16fa-4a36-bb56-29e018f2bb96_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 12pt=3B
font-family:Calibri
}
--></style></head>
<body class=3D'hmmessage'><div dir=3D'ltr'>Hi=2C<div><br></div><div>I'm run=
ning Linux on a PowerPC-44x based board with 256 Megabytes of RAM at 0x5000=
.0000 - 0x6000.0000.</div><div>Upon an error interrupt=2C I should load my =
recovery module(non-Linux kernel) at 0x4000.0000 and jump the execution to =
this.</div><div><br></div><div>Any suggestions for this implementation?&nbs=
p=3B</div><div><br></div><div>Would kexec allow me to load an image ouside =
linux's memory?</div><div><br></div><div><br></div><div><br></div><div><br>=
</div><div>Thanks=2C</div><div>Sumesh.&nbsp=3B</div> 		 	   		  </div></bod=
y>
</html>=

--_5f6d327a-16fa-4a36-bb56-29e018f2bb96_--
