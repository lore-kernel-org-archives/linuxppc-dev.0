Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 68427DDDE6
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 02:32:17 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l2EFWB2m026833
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Mar 2007 08:32:11 -0700 (MST)
Message-ID: <45F8157A.3080300@freescale.com>
Date: Wed, 14 Mar 2007 10:32:10 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jon Loeliger <jdl@freescale.com>, linuxppc-dev@ozlabs.org
Subject: Re: [dtc] Add support for flat device tree format version 17
References: <20070314000240.GD25514@localhost.localdomain>
In-Reply-To: <20070314000240.GD25514@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:

> -	{0x10, 0x10, BPH_V3_SIZE,
> +	{16, 16, BPH_V3_SIZE,
>  	 FTF_BOOTCPUID|FTF_STRTABSIZE},
> +	{17, 16, BPH_V17_SIZE,

So this is compatible with version 16?  Does that mean that a V17 DTB 
will work fine with U-Boot today?  Or will we need to update U-Boot?

The reason I ask is that I created a patch for U-Boot that tests the 
version of the DTB before attempting to process it.  By marking V17 to 
be compatible with V16, the patch will make U-Boot assume that it can 
parse the DTB.
