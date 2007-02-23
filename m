Return-Path: <Leonid@a-k-a.net>
Received: from mis011.exch011.intermedia.net (mis011.exch011.intermedia.net
	[64.78.21.10]) by ozlabs.org (Postfix) with ESMTP id 0A7F4DDEB6
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 Feb 2007 08:33:49 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: debugging custom Xilinx boot loader with abatron and
	Montavistadevrocket
Date: Fri, 23 Feb 2007 13:33:46 -0800
Message-ID: <406A31B117F2734987636D6CCC93EE3C0108DC6A@ehost011-3.exch011.intermedia.net>
In-Reply-To: <45a1b53e0702230811i79bbc10dqd6e10ac05b06ac16@mail.gmail.com>
References: <45a1b53e0702230811i79bbc10dqd6e10ac05b06ac16@mail.gmail.com>
From: "Leonid" <Leonid@a-k-a.net>
To: "Wade Maxfield" <wmaxfield@gmail.com>, "ppc" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

If you need just bootloader - use u-boot.

________________________________________
From: linuxppc-embedded-bounces+leonid=3Da-k-a.net@ozlabs.org =
[mailto:linuxppc-embedded-bounces+leonid=3Da-k-a.net@ozlabs.org] On =
Behalf Of Wade Maxfield
Sent: Friday, February 23, 2007 8:11 AM
To: ppc
Subject: debugging custom Xilinx boot loader with abatron and =
Montavistadevrocket


=A0 I want to debug a ppc custom boot loader with Montavista (since we =
spent the money on it) under the Xilinx fx60.

=A0 I've been able to get the kernel to debug under MontaVista.=A0 =
However, since the hardware engineers have given up on DDR ram (they =
could not get it to work reliably and will be dropping it from the next =
release), I don't think I can use Linux for now. =A0 Unfortunately, this =
decision is not changeable.=A0 When a hardware engineer is embarrassed, =
the results are not good for software engineers.=20

I don't think I've got enough static ram to host a PPC linux kernel and =
applications (we only have 8 meg).=A0 We will have 16 meg on the next =
release, I expect.=A0 Is that enough for simple apps and linux under =
PPC???=A0 I need some guidance here, as I don't have enough PPC =
experience.=20

=A0 Fortunately, we got the ppc running and can manage the hardware =
using Xilkernel and Xilnet (lwIP maybe later).

=A0 I've done numerous Google searches, and searches on MontaVista =
support page.=A0 They are specific to Linux.=20

=A0 Has anyone debugged a custom boot loader with MontaVista and =
Abatron?=A0 How do you set up the project under=A0 eclipse (which is =
devrocket)?=A0 Nothing I see seems to match, as I need the boot vector =
code, and I don't know how to tell eclipse to compile for that =
option.=A0 Can I just bring over the elf (compiled with debug under =
Xilinx) and the source files and start debugging?=A0 If so, what kind of =
project would I pick under devrocket?=A0 The more I look, the more =
confused I get.=20

=A0=A0 I could possibly bring up linux on an ML403 board and use gdb/ddd =
on that.=A0 if so, how would I cause the boot code to be located at the =
right address?=A0 Any howto's to read that aren't simply hand waves =
would be very useful. I understand once I do it is easy, but getting it =
done the first time is my problem right now.=20

=A0=A0 I've got to pull some serious asses from the fire, so I'm under a =
lot of pressure.=A0 I also know who will be blamed if I don't pull this =
off.

=A0 Any help is greatly appreciated!

thanks,
wade
