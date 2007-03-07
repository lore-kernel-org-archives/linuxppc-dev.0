Return-Path: <edo@onkeh.net>
Received: from pulsar.hytekhosting.com (pulsar.hytekhosting.com
	[208.101.48.101])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7FD16DDED7
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Mar 2007 11:04:23 +1100 (EST)
Received: from onkehf2 by pulsar.hytekhosting.com with local (Exim 4.63)
	(envelope-from <edo@onkeh.net>) id 1HOjdk-0000N9-L6
	for linuxppc-dev@ozlabs.org; Tue, 06 Mar 2007 19:04:20 -0500
Message-ID: <29357.81.170.117.164.1173225860.squirrel@onkeh.net>
In-Reply-To: <45EDF8F5.9090009@am.sony.com>
References: <29902.81.170.115.218.1173205803.squirrel@onkeh.net>
	<Pine.LNX.4.62.0703062016450.4463@pademelon.sonytel.be>
	<29265.81.170.117.164.1173218499.squirrel@onkeh.net>
	<45EDF8F5.9090009@am.sony.com>
Date: Tue, 6 Mar 2007 19:04:20 -0500 (EST)
Subject: Re: Updated ps3fb usage?
From: "Edward Strong" <edo@onkeh.net>
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Sorry for the trouble, I accidentally applied the patch
> ps3-hires-defconfig.diff
> (below) when committing.  'mode:5' is 1080p, which your monitor does not
> support.
> Just set the mode to one your monitor supports.
>
> BTW, you need to build the video mode into kernel with CONFIG_CMDLINE
> since I
> don't yet have the code to parse and use the command line from kboot done.
>
> -Geoff
>
> --- ps3-linux-dev.orig/arch/powerpc/configs/ps3_defconfig
> +++ ps3-linux-dev/arch/powerpc/configs/ps3_defconfig
> @@ -213 +213,1 @@
> -CONFIG_CMDLINE="root=/dev/sda1 ip=dhcp"
> +CONFIG_CMDLINE="root=/dev/sda1 ip=dhcp video=ps3fb:mode:5"
>
>

Yes this solved it.  Apologies, it was sloppy of me not to check the
defconfig.  Thanks again,

Edward
