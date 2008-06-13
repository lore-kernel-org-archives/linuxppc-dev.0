Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0BF1DDE17B
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 14 Jun 2008 03:49:44 +1000 (EST)
Message-ID: <4852B331.9060004@freescale.com>
Date: Fri, 13 Jun 2008 12:49:37 -0500
From: Jon Loeliger <jdl@freescale.com>
MIME-Version: 1.0
To: Leonid <Leonid@a-k-a.net>
Subject: Re: Device tree for powerpc boards.
References: <406A31B117F2734987636D6CCC93EE3C03A7042C@ehost011-3.exch011.intermedia.net>
In-Reply-To: <406A31B117F2734987636D6CCC93EE3C03A7042C@ehost011-3.exch011.intermedia.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

> 3) In order to compile DT blob from DT source, DT compiler (dtc) is
> required. I have installed one on my ubuntu machine and successfully
> compiled source, creating a blob. Is this the only way to go? Perhaps
> there is some target in Linux or u-boot Makefiles which does this job? 

Install the DTC anyway you want.  I recommend grabbing
it from jdl.com and building it.

jdl
