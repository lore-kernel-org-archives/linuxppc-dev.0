Return-Path: <gnathita@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.206])
	by ozlabs.org (Postfix) with ESMTP id 7790A6885E
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Dec 2005 19:10:46 +1100 (EST)
Received: by zproxy.gmail.com with SMTP id m22so282786nzf
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 07 Dec 2005 00:10:44 -0800 (PST)
Message-ID: <259581790512070010s3be8b3cfg6cfd17d2f503b0f7@mail.gmail.com>
Date: Wed, 7 Dec 2005 09:10:44 +0100
From: Paulinha <gnathita@gmail.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_26905_12463809.1133943044352"
Subject: linux 2.4 on Xilinx ml403
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_26905_12463809.1133943044352
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,

I have been trying to run linux 2.4.26 on Virtex 4 for a while and without
success.

I am trying to implement a simple design, with an UART, SystemACE and
everything interrupt driven. When I try to make bzImage, there is an error
in (SysACE) adapter.c file, because XPAR_INTC_0_SYSACE_0_VEC_ID is not
defined.

I have applied the patch given by Xilinx for switching from the ml300 to th=
e
ml403, which copies the bsp, .config and xparameter files into the kernel.

I am stucked here, and do not know how to keep going from that.
Could anyone help me a little bit?

Thanks and have a good day!

------=_Part_26905_12463809.1133943044352
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,<br>
<br>
I have been trying to run linux 2.4.26 on Virtex 4 for a while and without =
success.<br>
<br>
I am trying to implement a simple design, with an UART, SystemACE and
everything interrupt driven. When I try to make bzImage, there is an
error in (SysACE) adapter.c file, because XPAR_INTC_0_SYSACE_0_VEC_ID
is not defined.<br>
<br>
I have applied the patch given by Xilinx for switching from the ml300
to the ml403, which copies the bsp, .config and xparameter files into
the kernel.<br>
<br>
I am stucked here, and do not know how to keep going from that.<br>
Could anyone help me a little bit?<br>
<br>
Thanks and have a good day!<br>


------=_Part_26905_12463809.1133943044352--
