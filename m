Return-Path: <wd@denx.de>
Received: from mailout04.sul.t-online.com (mailout04.sul.t-online.com
	[194.25.134.18]) by ozlabs.org (Postfix) with ESMTP id 3FAB667A8A
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Mar 2005 07:03:23 +1100 (EST)
To: "Stephen Warren" <SWarren@nvidia.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 08 Mar 2005 09:34:20 PST."
	<DBFABB80F7FD3143A911F9E6CFD477B0056A92B5@hqemmail02.nvidia.com>
Date: Tue, 08 Mar 2005 21:03:06 +0100
Sender: wd@denx.de
Message-Id: <20050308200311.1BA17C1510@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC5200 kernel with IDE *and* FEC? 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <DBFABB80F7FD3143A911F9E6CFD477B0056A92B5@hqemmail02.nvidia.com> you wrote:
> 
> By the way, to the people who mentioned using Debian and Gentoo on the
> MPC5200, are there any web-sites that have info on how to do this
> (toolchain and/or distro)? I haven't managed to find anything remotely
> detailed on cross-building either of these distros. But I'll probably
> just do it from scratch now I have NPTL-aware toolchain:-)

You don't have to cross-build anything; you can just use the existing
ISO images for installation. For Debian Woody you can find a detailed
description   (thanks   to    bernhard    Kuhn    for    this!)    at
http://www.denx.de/twiki/bin/view/DULG/DebianOnPowerpcInstallationHowto

In the meantime we swithched to using Ubuntu Linux on the  5200,  but
here  installation  is  a  bit  more  complicated as you will have to
twiddle with  the  installation  ramdisk  image,  and  later  perform
certain  steps  manually. It's probably easier to copy the filesystem
from a "real" PowerPC system ;-)

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
If I can have honesty, it's easier to overlook mistakes.
	-- Kirk, "Space Seed", stardate 3141.9
