Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 39B2FDDEEF
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Aug 2007 07:43:11 +1000 (EST)
Message-ID: <46B8E76F.3020403@anagramm.de>
Date: Tue, 07 Aug 2007 23:43:11 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Michael Brian Willis <willis@arlut.utexas.edu>
Subject: Re: Fedora 7 on a non FPU system
References: <20070313043050.GB82243@server.idefix.lan>	<513703.69187.qm@web302.biz.mail.mud.yahoo.com>	<20070314043305.GB27011@server.idefix.lan>	<20070314065411.GD14658@moe.telargo.com>
	<1186508561.5592.26.camel@louie>
In-Reply-To: <1186508561.5592.26.camel@louie>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, Michael!

Michael Brian Willis schrieb:
> I'm trying to install a Fedora 7 Root File System on an MPC8540 based
> embedded system with a Denx 2.6.21 kernel. I have read the Denx
> Application note located at: 
> http://www.denx.de/wiki/DULG/AN2007_03_InstallFC7OnSequoia. 
> 
> However this App. Note says that the instructions apply only to
> processors that have a full Floating Point Unit (FPU). My processor does
> not have an FPU and I believe that this is causing some system hangs. 

Yes, that won't work.
You can either use FPU emulation or do the floating point stuff on the e500
core's SPE (Signal Processing Engine) which is AFAIK not supported by any
major distribution.

> Has anybody every successfully installed Fedora(or another major distro)
> on a non-FPU system?

CRUX - not a "major distro", because it's targeted at "experienced Linux users".
I am running my selfmade version of "embedded CRUX" on my MPC8540 Boards
based on http://cruxppc.sunsite.dk/wp/index.php which now fully supports
the e500 core features.

> Or, does anybody know what is needed to get it
> working properly on a non FPU system?

... mentioned above.
I bootstrapped the toolchain (binutils, (e)glibc, gcc and friends)
from scratch. See:
http://www.anagramm-technology.com/05_Services/FoxFactSheet.pdf
Current versions: kernel 2.6.23-rc2, gcc-4.2.1, (e)glibc 2.5.1/2.6.1.

Regards,
-- 
Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm-technology.com
Phone: +49-89-741518-50
Fax: +49-89-741518-19
