Return-Path: <ojordan12345@hotmail.co.uk>
Received: from bay0-omc3-s25.bay0.hotmail.com (bay0-omc3-s25.bay0.hotmail.com
 [65.54.190.163]) by ozlabs.org (Postfix) with ESMTP id CE021B7073
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2012 05:54:47 +1000 (EST)
Message-ID: <BAY163-W54EBB2437ED2068EF5AF5D03F0@phx.gbl>
Content-Type: multipart/alternative;
 boundary="_f820c196-4e01-4b39-bb25-f04470c2913e_"
From: o jordan <ojordan12345@hotmail.co.uk>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: PowerPC radeon KMS - is it possible?
Date: Tue, 17 Apr 2012 20:49:35 +0100
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_f820c196-4e01-4b39-bb25-f04470c2913e_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi list=2C
Firstly let me say thanks for the great work you do!!!
I've been trying to get Kernel Mode Setting working on my iBook with Ubuntu=
 12.04.  I can only get it working by forcing PCI mode (agpmode=3D-1).  Set=
ting agpmode=3D1 or a higher number just results in freezing and a flashing=
 screen.  Does anybody know how to get it working fully with agp?
I've tried the Debian experimental kernel with the same results.  I notice =
with Fedora 16 they also recommend setting agpmode=3D-1 with a radeon card.=
  So I'm guessing there is no easy fix??
I've been trying to sort out the kernel configuration for ati/radeon cards =
with Ubuntu.  I raised a bug to build back in the framebuffers https://bugs=
.launchpad.net/ubuntu/+source/linux/+bug/949288 .  I'd appreciate any help =
with that bug report.
With Userspace Mode Setting there is nolonger any 3D hardware acceleration =
(https://bugs.launchpad.net/ubuntu/+source/mesa/+bug/946677 ) so this is wh=
y I'm interested in getting KMS working properly.  However=2C some people s=
eem to really want suspend which currently requires radeonfb.  So I'm tryin=
g to find a kernel configuration that works well for UMS and KMS!!! =20
This is what I proposed:

CONFIG_DRM_RADEON_KMS=3Dy

CONFIG_FB_RADEON=3Dy

CONFIG_FB_ATY128=3Dy

CONFIG_FB_ATY=3Dy
So people can disable radeonfb from the yaboot prompt/conf if they want ful=
ly working KMS.  I'm not sure if CONFIG_AGP_UNINORTH should be compiled as =
a module or built in.   We are now in kernel freeze for 12.04 so to get any=
 changes is going to take some serious begging!!!
Cheers
Adam 		 	   		  =

--_f820c196-4e01-4b39-bb25-f04470c2913e_
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
font-size: 10pt=3B
font-family:Tahoma
}
--></style></head>
<body class=3D'hmmessage'><div dir=3D'ltr'>
Hi list=2C<div><br></div><div>Firstly let me say thanks for the great work =
you do!!!</div><div><br></div><div>I've been trying to get Kernel Mode Sett=
ing working on my iBook with Ubuntu 12.04. &nbsp=3BI can only get it workin=
g by forcing PCI mode (agpmode=3D-1). &nbsp=3BSetting agpmode=3D1 or a high=
er number just results in freezing and a flashing screen. &nbsp=3BDoes anyb=
ody know how to get it working fully with agp?</div><div><br></div><div>I'v=
e tried the Debian experimental kernel with the same results. &nbsp=3BI not=
ice with Fedora 16 they also recommend setting agpmode=3D-1 with a radeon c=
ard. &nbsp=3BSo I'm guessing there is no easy fix??</div><div><br></div><di=
v>I've been trying to sort out the kernel configuration for ati/radeon card=
s with Ubuntu. &nbsp=3BI raised a bug to build back in the framebuffers&nbs=
p=3Bhttps://bugs.launchpad.net/ubuntu/+source/linux/+bug/949288 . &nbsp=3BI=
'd appreciate any help with that bug report.</div><div><br></div><div>With =
Userspace Mode Setting there is nolonger any 3D hardware acceleration (http=
s://bugs.launchpad.net/ubuntu/+source/mesa/+bug/946677 ) so this is why I'm=
 interested in getting KMS working properly. &nbsp=3BHowever=2C some people=
 seem to really want suspend which currently requires radeonfb. &nbsp=3BSo =
I'm trying to find a kernel configuration that works well for UMS and KMS!!=
! &nbsp=3B</div><div><br></div><div>This is what I proposed:<BR><br><BR>
<p id=3D"yui_3_2_0_1_1334689900582519">CONFIG_<wbr>DRM_RADEON_<wbr>KMS=3Dy<=
br>
CONFIG_FB_RADEON=3Dy<br>
CONFIG_FB_ATY128=3Dy<br>
CONFIG_FB_ATY=3Dy</p></div><div><br></div><div>So people can disable radeon=
fb from the yaboot prompt/conf if they want fully working KMS. &nbsp=3BI'm =
not sure if&nbsp=3BCONFIG_<wbr>AGP_UNINORTH should be compiled as a module =
or built in. &nbsp=3B</div><div>&nbsp=3B</div><div>We are now in kernel fre=
eze for 12.04 so to get any changes is going to take some serious begging!!=
!</div><div><br></div><div>Cheers</div><div><br></div><div>Adam</div> 		 	 =
  		  </div></body>
</html>=

--_f820c196-4e01-4b39-bb25-f04470c2913e_--
