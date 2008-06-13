Return-Path: <Leonid@a-k-a.net>
Received: from mis011.exch011.intermedia.net (mis011.exch011.intermedia.net
	[64.78.21.10]) by ozlabs.org (Postfix) with ESMTP id 9C1D6DDF18
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 14 Jun 2008 08:13:53 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Device tree for powerpc boards.
Date: Fri, 13 Jun 2008 15:13:50 -0700
Message-ID: <406A31B117F2734987636D6CCC93EE3C03A704DA@ehost011-3.exch011.intermedia.net>
In-Reply-To: <4852B331.9060004@freescale.com>
References: <406A31B117F2734987636D6CCC93EE3C03A7042C@ehost011-3.exch011.intermedia.net>
	<4852B331.9060004@freescale.com>
From: "Leonid" <Leonid@a-k-a.net>
To: "Jon Loeliger" <jdl@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, Jon:

Thanks a lot for your explanation.

Leonid.=20

-----Original Message-----
From: Jon Loeliger [mailto:jdl@freescale.com]=20
Sent: Friday, June 13, 2008 10:50 AM
To: Leonid
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Device tree for powerpc boards.

Leonid wrote:
> Hi:

Hi.

> 1) Is the usage of device tree absolutely mandatory for powerpc boards

> or just recommended and by combining appropriate defines in u-boot and

> linux it can be avoided?

Consider it mandatory.

> 2) I understood that I can add my proprietary drivers without creating

> nodes for them in the tree, is it correct?

Maybe, maybe not.  Device Trees describe _hardware_, not drivers.

> 3) In order to compile DT blob from DT source, DT compiler (dtc) is=20
> required. I have installed one on my ubuntu machine and successfully=20
> compiled source, creating a blob. Is this the only way to go? Perhaps=20
> there is some target in Linux or u-boot Makefiles which does this job?

Install the DTC anyway you want.  I recommend grabbing it from jdl.com
and building it.

jdl
