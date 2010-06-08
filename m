Return-Path: <yaanhyy@gmail.com>
Received: from mail-px0-f179.google.com (mail-px0-f179.google.com
	[209.85.212.179]) by ozlabs.org (Postfix) with ESMTP id B99DCB7D64
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Jun 2010 16:26:10 +1000 (EST)
Received: by pxi3 with SMTP id 3so1721514pxi.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 07 Jun 2010 23:26:08 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 8 Jun 2010 14:26:08 +0800
Message-ID: <AANLkTik4J5rT1IABynQT3F68gXuw6GoKvrxu537CxoG-@mail.gmail.com>
Subject: Packet error when using kgdb
From: yy Hong <yaanhyy@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=001636e0a7a8664cae04887edd1f
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001636e0a7a8664cae04887edd1f
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: quoted-printable

Hi all:
    I want to use kgdb debug kernel and driver on 8641d_hpcn. I refer to
Essential linux device drivers. I compile the kernel, open Magic SysRq key
and kgdb option in menuconfig.
But, when I use  ttyS0 connect to target board. I meet the error:

Ignoring packet error, continuing...
Ignoring packet error, continuing...
Ignoring packet error, continuing...
Malformed response to offset query, timeout
 Sometimes, I can connect to target board.But when I set breakpoint and ste=
p
to debug. I meet the same error above.
I use kernel v2.6.27.38.Toolchain is ELDK for ppc.
Is the kgdb tool  not stable=A3=BF
I am a freeshman. Hope getting some suggestiong.
Thank you!

--001636e0a7a8664cae04887edd1f
Content-Type: text/html; charset=GB2312
Content-Transfer-Encoding: quoted-printable

<div>Hi all:</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;I want to use kgdb debug kernel and driver on =
8641d_hpcn. I refer to Essential linux device drivers. I compile the kernel=
, open <font color=3D"#000000">Magic SysRq key and kgdb option in menuconfi=
g.</font></div>
<div>But, when I use&nbsp;&nbsp;ttyS0 connect to target board.&nbsp;I meet&=
nbsp;the error:</div>
<div><br>Ignoring packet error, continuing...<br>Ignoring packet error, con=
tinuing...<br>Ignoring packet error, continuing...<br>Malformed response to=
 offset query, timeout<br></div>
<div>
<div>Sometimes, I can connect to target board.But when I set breakpoint and=
 step to debug. I meet the same error above.</div>
<div>I use kernel v2.6.27.38.Toolchain is ELDK for ppc.</div>
<div>Is&nbsp;the kgdb tool&nbsp; not stable=A3=BF</div>
<div>I am a freeshman. Hope getting some suggestiong.</div>
<div>Thank you!</div></div>

--001636e0a7a8664cae04887edd1f--
