Return-Path: <db260179@hotmail.com>
Received: from hotmail.com (bay102-f13.bay102.hotmail.com [64.4.61.23])
	by ozlabs.org (Postfix) with ESMTP id 72649689E6
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jan 2006 02:27:44 +1100 (EST)
Message-ID: <BAY102-F13D14E849CFB668DC92BF8C2250@phx.gbl>
From: "dabby bentam" <db260179@hotmail.com>
To: linuxppc-dev@ozlabs.org
Date: Tue, 10 Jan 2006 15:27:42 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Subject: [DRM] How is the agp_special_page implemented for kernel
	2.6(uninorth-agp) PPC?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Im having more luck with the articiaS agpgart driver, 90% nearly there!

I noticed the uninorth agp uses the agp_special_page function, as ppc 
architecture works different to i386 when remapping memory across the 
aperture (gatt).

I saw this patch for Xfree86 4.3.0 
http://dev.gentoo.org/~spyderous/xfree/patchsets/4.3.0/patch/5114_all_4.3.0-radeon-drm-ioremapagp.patch
I'm assuming this is for kernel 2.4? How does kernel 2.6 use this functions?

As  i would like to use this code for the articiaS agpgart driver. But i 
need to add #define for specific ppc boards i.e amigaone and pegasos 1.

Thanks for any help or info

Pegxlin DEV (aka dabby bentam)

PegXlin Developer

Pegxmac, Pegxlin

Versatile LIVE CD's for Pegasos Mainboards

http://pegxmac.zftp.com
http://www.pegasosppc.com
