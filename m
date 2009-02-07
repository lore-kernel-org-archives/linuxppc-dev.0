Return-Path: <sachinp@in.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp09.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 81F6BDDD04
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Feb 2009 04:41:39 +1100 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp09.au.ibm.com (8.13.1/8.13.1) with ESMTP id n17HZgoj026931
	for <linuxppc-dev@ozlabs.org>; Sun, 8 Feb 2009 04:35:42 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n17Hfssh307648
	for <linuxppc-dev@ozlabs.org>; Sun, 8 Feb 2009 04:41:54 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n17HfZRD006846
	for <linuxppc-dev@ozlabs.org>; Sun, 8 Feb 2009 04:41:36 +1100
Message-ID: <498DC7C8.9090508@in.ibm.com>
Date: Sat, 07 Feb 2009 23:11:28 +0530
From: "Sachin P. Sant" <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [patch] powerpc/ps3: Use hard coded values for LV1 device type
References: <498C6C49.1010200@in.ibm.com> <498CF52E.4040903@am.sony.com>
In-Reply-To: <498CF52E.4040903@am.sony.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Mel Gorman <mel@csn.ul.ie>, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geoff Levand wrote:
> Change the PS3 platform code to use hard coded numbers for its
> LV1 device types.
>
> The PS3 platform code was incorrectly using some scsi block
> constants for the device type returned from the LV1 hypervisor.
>
> Fixes build errors like these when CONFIG_BLOCK=n:
>
>   In file included from include/scsi/scsi.h:12,
>                    from arch/powerpc/platforms/ps3/platform.h:25,
>                    from arch/powerpc/platforms/ps3/setup.c:36:
>   include/scsi/scsi_cmnd.h:27:25: warning: "BLK_MAX_CDB" is not defined
>   include/scsi/scsi_cmnd.h:28:3: error: #error MAX_COMMAND_SIZE can not be bigger than BLK_MAX_CDB
>
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> ---
Thanks Geoff. This fixes the issue.

Tested-by : Sachin Sant <sachinp@in.ibm.com>


-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
