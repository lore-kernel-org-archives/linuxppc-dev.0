Return-Path: <shawnxjin@gmail.com>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) by ozlabs.org (Postfix) with ESMTP id 37C98B7C8E
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Apr 2010 15:21:19 +1000 (EST)
Received: by gyf2 with SMTP id 2so1819551gyf.15
	for <linuxppc-dev@ozlabs.org>; Sun, 04 Apr 2010 22:21:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <y2ufa686aa41004040027p560c1b8bw6cdf3f096398cd42@mail.gmail.com>
References: <h2nc3d0340b1004040010ga00f75b6k38eccbe66ce11799@mail.gmail.com>
	<y2ufa686aa41004040027p560c1b8bw6cdf3f096398cd42@mail.gmail.com>
Date: Sun, 4 Apr 2010 22:21:17 -0700
Message-ID: <h2jc3d0340b1004042221q3f89ec2fu2811846d5eb09409@mail.gmail.com>
Subject: Re: Migrating from ppc to powerpc
From: Shawn Jin <shawnxjin@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Content-Type: multipart/alternative; boundary=000e0cd5cbf89e99730483767fdb
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--000e0cd5cbf89e99730483767fdb
Content-Type: text/plain; charset=ISO-8859-1

On Sun, Apr 4, 2010 at 12:27 AM, Grant Likely <grant.likely@secretlab.ca>wrote:

> What processor/board/soc are you using?  The easiest path is to start
> with a similar board and adapt the device tree source file (.dts in
> arch/powerpc/boot/dts) to match your board with your devices.  You'll
> need to add a node to the tree for each device you add.  If you post
> your new .dts file to devicetree-discuss@lists.ozlabs.org for review,
> then I and others will help you to craft it and get it into the format
> that it needs to be in.
>

Thanks a lot for the info. The board has a MPC7448 processor. I certainly
like to post the .dts file for review and help.

-Shawn.

--000e0cd5cbf89e99730483767fdb
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Sun, Apr 4, 2010 at 12:27 AM, Grant Likely <s=
pan dir=3D"ltr">&lt;<a href=3D"mailto:grant.likely@secretlab.ca">grant.like=
ly@secretlab.ca</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" =
style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8=
ex; padding-left: 1ex;">
<div><div></div>What processor/board/soc are you using? =A0The easiest path=
 is to start<br></div>
with a similar board and adapt the device tree source file (.dts in<br>
arch/powerpc/boot/dts) to match your board with your devices. =A0You&#39;ll=
<br>
need to add a node to the tree for each device you add. =A0If you post<br>
your new .dts file to <a href=3D"mailto:devicetree-discuss@lists.ozlabs.org=
">devicetree-discuss@lists.ozlabs.org</a> for review,<br>
then I and others will help you to craft it and get it into the format<br>
that it needs to be in.<br></blockquote></div><br>Thanks a lot for the info=
. The board has a MPC7448 processor. I certainly like to post the .dts file=
 for review and help.<br><br>-Shawn.<br>

--000e0cd5cbf89e99730483767fdb--
