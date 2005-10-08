Return-Path: <vijesh.vh@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.199])
	by ozlabs.org (Postfix) with ESMTP id 6B3DC683CF
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  8 Oct 2005 20:13:16 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id i12so428593wra
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 08 Oct 2005 03:13:15 -0700 (PDT)
Message-ID: <8e78982e0510080306n48d9c8b2p858f22bed588f6b9@mail.gmail.com>
Date: Sat, 8 Oct 2005 15:36:36 +0530
From: Vijesh VH <vijesh.vh@gmail.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_3612_1828328.1128765996996"
Subject: USB IRQ Handling in IBMSTBx25xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_3612_1828328.1128765996996
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

Has any one worked on Interrupt handling in PPC 405 for STBx25xx. I am
working in interfacing USB devices for STB. The Device Driver is getting
stuck or runs unconditional in calling ISR. I Identified that that the
spin_unlock_irqrestore function call in the kernel does it. So i am unable
to go ahead and could not find what to do further. If any one is aware or
worked on this kind of problem plz help me.

--
Thanks and Regards,
Vijesh V H

------=_Part_3612_1828328.1128765996996
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,<br>
<br>
&nbsp;&nbsp;&nbsp; Has any one worked on Interrupt handling in PPC 405
for STBx25xx. I am working in interfacing USB devices for STB. The
Device Driver is getting stuck or runs unconditional in calling ISR. I
Identified that that the spin_unlock_irqrestore function call in the
kernel does it. So i am unable to go ahead and could not find what to
do further. If any one is aware or worked on this kind of problem plz
help me.<br clear=3D"all"><br>-- <br>Thanks and Regards,<br>Vijesh V H=20

------=_Part_3612_1828328.1128765996996--
