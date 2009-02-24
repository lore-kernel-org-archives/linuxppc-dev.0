Return-Path: <mbergandi@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.25])
	by ozlabs.org (Postfix) with ESMTP id B0222DDE00
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2009 05:55:56 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 3so969900qwe.15
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Feb 2009 10:55:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <49A3EBFF.4030906@aimvalley.nl>
References: <E1LbNft-0007z6-Pf@garm.runbox.com> <49A3EBFF.4030906@aimvalley.nl>
Date: Tue, 24 Feb 2009 13:55:53 -0500
Message-ID: <1c641bc80902241055j33984de6re0f9a887494fa93a@mail.gmail.com>
Subject: Re: Can not get "new" MPC8313e-RDB to boot "as-shipped" flash image
From: Michael Bergandi <mbergandi@gmail.com>
To: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
Content-Type: multipart/alternative; boundary=0015175ce1be27363d0463aeab22
Cc: linuxppc-dev@ozlabs.org, Eric Cottrell <wb1hbu@runbox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0015175ce1be27363d0463aeab22
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi guys,

I have the Rev B board and I have it working quite well. I'll share what I
have
discovered so far.

In Eric's case, the board seems suspect. There is already a Rev C of this
board, but
I am not sure if it is actually available yet. You may want to check on
that.

Regarding U-Boot, mine shipped with v. 1.3.0. The LTIB provided dts files
follow
the original dts format. There is a new dts spec and if you ever intend to
use
a mainline kernel, you will need to use the newer dts provided in the kernel
source. Did I mention this board has at least basic support in 2.6.28 :). I
have
not determined the extent of the support though.

I have successfully used the provided U-Boot v1.3.0 to boot a 2.6.28 kernel
with
the dts-v1 device tree. Hence, I hope that will clear your speculation about
the
device tree being the problem.

I have seen the same problem that you guys have seen where U-Boot gets to
the "Uncompressing kernel ..." then reboots. This happened to me when I
passed the wrong device tree .dtb. I have also had this happen if I made
a change to the kernel config. I haven't been able to determine what exactly

that I changed that caused the problem though.

Also, if you are feeling adventurous, you can also get the latest U-Boot.
There
is a specifc branch for this board:

$ git clone git://git.denx.de/u-boot-mpc83xx.git

I haven't attempted this since I don't currently have a probe to recovery a
bad boot loader flash.

Hope this helps,

Mike

--0015175ce1be27363d0463aeab22
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi guys,<br><br>I have the Rev B board and I have it working quite well. I&=
#39;ll share what I have<br>discovered so far.=A0 <br><br>In Eric&#39;s cas=
e, the board seems suspect. There is already a Rev C of this board, but<br>
I am not sure if it is actually available yet. You may want to check on tha=
t.<br><br>Regarding U-Boot, mine shipped with v. 1.3.0. The LTIB provided d=
ts files follow<br>the original dts format. There is a new dts spec and if =
you ever intend to use<br>
a mainline kernel, you will need to use the newer dts provided in the kerne=
l<br>source. Did I mention this board has at least basic support in 2.6.28 =
:). I have<br>not determined the extent of the support though.<br><br>I hav=
e successfully used the provided U-Boot v1.3.0 to boot a 2.6.28 kernel with=
<br>
the dts-v1 device tree. Hence, I hope that will clear your speculation abou=
t the <br>device tree being the problem. <br><br>I have seen the same probl=
em that you guys have seen where U-Boot gets to <br>the &quot;Uncompressing=
 kernel ...&quot; then reboots. This happened to me when I <br>
passed the wrong device tree .dtb. I have also had this happen if I made<br=
>a change to the kernel config. I haven&#39;t been able to determine what e=
xactly <br>that I changed that caused the problem though. <br><br>Also, if =
you are feeling adventurous, you can also get the latest U-Boot. There<br>
is a specifc branch for this board:<br><br>$ git clone git://<a href=3D"htt=
p://git.denx.de/u-boot-mpc83xx.git">git.denx.de/u-boot-mpc83xx.git</a><br><=
br>I haven&#39;t attempted this since I don&#39;t currently have a probe to=
 recovery a <br>
bad boot loader flash.<br><br>Hope this helps,<br><br>Mike<br>

--0015175ce1be27363d0463aeab22--
