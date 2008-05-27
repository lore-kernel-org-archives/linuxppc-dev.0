Return-Path: <reynekejunk@hotmail.com>
Received: from bay0-omc2-s35.bay0.hotmail.com (bay0-omc2-s35.bay0.hotmail.com
	[65.54.246.171]) by ozlabs.org (Postfix) with ESMTP id A191CDDF9D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 May 2008 23:47:34 +1000 (EST)
Message-ID: <BAY101-W2374D5B0B74777F9BB547DBEBD0@phx.gbl>
From: - Reyneke <reynekejunk@hotmail.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Re: linux powerpc and device trees
Date: Tue, 27 May 2008 13:42:29 +0000
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Thanks everyone for the feedback provided. Looks like the bootloader/kernel=
 cross over is now working OK.

My advice to anyone else doing this move - upgrade to the latest version of=
 u-boot before doing the kernel move.


> I am busy with a platform move from the arch/ppc to arch/powerpc tree of =
the linux kernel. Being relatively new to device trees, I'm trying to ensur=
e I have all the steps covered. The platform is very similar to the AMCC Se=
quioa (440EPx) and that board has been used as reference for the code chang=
es required. Kernel version is 2.6.25, using u-boot 1.2.0 (CONFIG_OF_xxx en=
abled, debug output on).

.
.

> This is where I am unclear as to how to prepare the device tree. Is step =
(4) correct since I'm using uImage? Where is the memory information suppose=
 to come from? Previously U-boot passes this kind of data to the kernel via=
 bd_t - how does it work now using device trees?
>=20
> Cheers
> Jan


_________________________________________________________________

http://clk.atdmt.com/UKM/go/msnnkmgl0010000009ukm/direct/01/=
