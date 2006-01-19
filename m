Return-Path: <peter.ryser@xilinx.com>
Received: from outbound1-ash-R.bigfish.com (outbound-ash.frontbridge.com
	[206.16.192.249])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 7DB0C689D9
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 Jan 2006 18:33:48 +1100 (EST)
Message-ID: <43CF3FD9.1070500@xilinx.com>
Date: Wed, 18 Jan 2006 23:29:29 -0800
From: Peter Ryser <peter.ryser@xilinx.com>
MIME-Version: 1.0
To: jeffer <jefferxu@gmail.com>
Subject: Re: [PATCH 00/10] Updated ML300 & ML403 patches
References: <20060114094658.GA12639@secretlab.ca>
	<43CC5453.3060702@xilinx.com>	<43CC9F35.8010305@secretlab.ca>
	<43CEDCE4.5020903@dlasys.net>
	<98d249d60601182314g774ad2bes@mail.gmail.com>
In-Reply-To: <98d249d60601182314g774ad2bes@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "David H. Lynch Jr." <dhlii@dlasys.net>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

You need to apply a patch to the 2.4 Linux kernel to make it work with 
U-Boot for the MLxxx boards. You can find that patch as part of Xilinx 
Application Note 542 (XAPP542, 
http://direct.xilinx.com/bvdocs/appnotes/xapp542.pdf, 
http://direct.xilinx.com/bvdocs/appnotes/xapp542.zip)

The process on how to apply the patch is described in that application note.

- Peter

PS: The application note is out of date for EDK tools newer than 6.2. 
The patch still works, though.


jeffer wrote:

> Hi at all
>
>
> Since two week I have this Problem and can't solve it. I allready read 
> DULG and search in
> Mailinglists but I can't run linux. Perhaps had the same problem and 
> can help me.
> My Problem:
> After I load the uImage (uImage at 0x00400000 )
> from server, I try to run in with command bootm.
> => bootm 00400000
>  Booting image at  00400000...
>    Image Name:   Linux-2.4.24-pre2
>    Created:      2006-01-19   6:25:03 UTC
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    700730 Bytes = 684.3 kB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
>  
>  don't  start kernel
>   my board  :
>   sdram  16m  0----ffffff
>   flash     4m   ffc00000 ---fffffff
>  
>
>     routing, so my current assumption is
>     that I either have VIRTEX_UART defined improperly or I have the
>     ppc_sys
>     data structure created wrong.
>
>
>     >
>     >
>
>            It would be really nice if the was either some comments in
>     xparameters.h or in the Documents directory explaining what the Linux
>     xparameters values are so that it it would be easy to know what items
>     from xparameters_xxx.h have to be mapped or redefined.
>
>
>
>     > This really isn't a big deal anyway; most of this discussion
>     will become
>     > moot in short order.  Sometime in the next few releases,
>     linuxppc will
>     > flip over to using a flattened device tree to pass device
>     information
>     > from the boot loader to the kernel.  xparameters will drop out
>     of the
>     > kernel proper entirely except for the edk-generated device drivers
>     > (which is another issue entirely).  All the xparam stuff will be
>     > extracted into a device tree by u-boot or the zImage wrapper.  The
>     > kernel just won't care.  :)
>            Where can we get more information on what is happening here ?
>     I started the E12 port with most info in xparameters, but I have been
>     moving towards getting things passed in board_info. I am not using
>     u-boot as the E12 has a general purpose elf loader, and it was
>     easier to
>     add a fee lines for Linux. Regardless I would like to be
>     compatible with
>     whatever is coming - maybe even ahead fo the curve. The e12 is
>     just the
>     first of a family of products - the e14 already exists. There maybe
>     revisions of each at different speeds with different memory.
>
>
>     _______________________________________________
>     Linuxppc-embedded mailing list
>     Linuxppc-embedded@ozlabs.org <mailto:Linuxppc-embedded@ozlabs.org>
>     https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>
>------------------------------------------------------------------------
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
