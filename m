Return-Path: <vneethv@gmail.com>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 886211007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Jul 2011 00:19:12 +1000 (EST)
Received: by bwa18 with SMTP id 18so5410825bwa.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Jul 2011 07:19:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFbQSaAG+pJ0FBodZrM_pejH6RVWJnzyp1+boKfo5pgUOGC_+g@mail.gmail.com>
References: <CAFbQSaAG+pJ0FBodZrM_pejH6RVWJnzyp1+boKfo5pgUOGC_+g@mail.gmail.com>
From: Vineeth <vneethv@gmail.com>
Date: Wed, 13 Jul 2011 19:48:47 +0530
Message-ID: <CAFbQSaBf04W5jd2VF+DeYanen0O6k9amtYe3=+FYcnR5OXj7tg@mail.gmail.com>
Subject: Fwd: MPC7410 BAT Issue
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=0016e6da7b1c6df6ed04a7f419ae
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016e6da7b1c6df6ed04a7f419ae
Content-Type: text/plain; charset=ISO-8859-1

Hi,

We have a MPC7410 based board and we are trying to port Linux on the same.

the Board Architecture/UART connection is as follows

*MPC7410 ---> MPC107(PCI Bridge) ---> PLX9052(PCI->Local Bus Bridge) --->
UART*
The address mapping is as follows

PLX9052 @       0xDB00_0000
UART @           0xDB00_0100
FLASH @         0xFF00_0000
RAM @            0x0

We have to port Linux 2.6.24( default one with ELDK4.2).

as we don't have a debugger, we are using (my_reset) function which simply
resets the board.


We have uboot up and running. we are downloading uImage to RAM location
@0x800000 and JMP to 0x80000

Linux is executing till setup_arch() call in the start_kernel() function.

We are facing some issue in page_init() call; also on setting the BAT
registers.(which is done at platform_init)

Anyone got any clue how to set the BAT for MPC7410 ?

--0016e6da7b1c6df6ed04a7f419ae
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><div class=3D"gmail_quote">Hi,<br><br>We have a MPC7410 based board and=
 we are trying to port Linux on the same.<br><br>the Board Architecture/UAR=
T connection is as follows<br><br><b><span style=3D"color:rgb(153, 0, 0)">M=
PC7410 ---&gt; MPC107(PCI Bridge) ---&gt; PLX9052(PCI-&gt;Local Bus Bridge)=
 ---&gt; UART</span></b><br>



The address mapping is as follows<br><br>PLX9052 @=A0=A0=A0=A0=A0=A0 0xDB00=
_0000<br>UART @ =A0 =A0 =A0 =A0 =A0 0xDB00_0100<br>FLASH @=A0=A0=A0=A0=A0=
=A0=A0=A0 0xFF00_0000<br>RAM @=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x0<br><br>=
We have to port Linux 2.6.24( default one with ELDK4.2).<br>



<br>as we don&#39;t have a debugger, we are using (<span style=3D"color:rgb=
(255, 0, 0)">my_reset</span>) function which simply resets the board.<br><b=
r><br>We have uboot up and running. we are downloading uImage to RAM locati=
on @0x800000 and JMP to 0x80000<br>



<br>Linux is executing till setup_arch() call in the start_kernel() functio=
n.<br><br>We are facing some issue in page_init() call; also on setting the=
 BAT registers.(which is done at platform_init)<br><br>Anyone got any clue =
how to set the BAT for MPC7410 ? <br>



<br>
</div><br>

--0016e6da7b1c6df6ed04a7f419ae--
