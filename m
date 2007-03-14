Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id B0B93DDDFA
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 08:06:44 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l2EL6eJP020239
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Mar 2007 14:06:41 -0700 (MST)
Message-ID: <45F863DF.5050709@freescale.com>
Date: Wed, 14 Mar 2007 16:06:39 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jon Loeliger <jdl@freescale.com>, linuxppc-dev@ozlabs.org
Subject: Re: [dtc] Add support for flat device tree format version 17
References: <20070313062240.GA22737@localhost.localdomain>
In-Reply-To: <20070313062240.GA22737@localhost.localdomain>
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
> libfdt defined a new version of the flattened device tree format,
> version 17.  It is backwards compatible with version 16, just adding
> an extra header field giving the size of the blob's structure blob.

Question:

Since the DTB is compatible with V16, then technically U-Boot can work with it.  What 
would happen if U-Boot added some nodes to the DTB, but it didn't update size_dt_struct? 
Would the value of size_dt_struct still be correct?  If not, then does that mean that 
U-Boot should reject V17 DTBs?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
