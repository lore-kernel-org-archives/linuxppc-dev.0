Return-Path: <pterry@micromemory.com>
Received: from mail.micromemory.com (unknown [67.95.226.74])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 01018DE1BE
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 06:46:39 +1100 (EST)
Received: from [192.168.0.90] by micromemory.com (MDaemon PRO v9.6.2)
	with ESMTP id md50000487679.msg
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Oct 2007 12:38:43 -0700
Subject: Re: [PATCH 0/5 v3] Porting RapidIO driver from ppc to powerpc
	architecture and adding memory mapped RapidIO driver.
From: Phil Terry <pterry@micromemory.com>
To: wei.zhang@freescale.com
In-Reply-To: <11854393721520-git-send-email-wei.zhang@freescale.com>
References: <11854393721520-git-send-email-wei.zhang@freescale.com>
Content-Type: text/plain
Date: Mon, 29 Oct 2007 12:38:40 -0700
Message-Id: <1193686720.20377.2.camel@pterry-fc6.micromemory.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
Reply-To: pterry@micromemory.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Can anyone tell me what the status of these are? What kernel release are
they targetted for? Currently I'm trying to work with 2.6.23 plus these
patches locally.

Cheers
Phil

On Thu, 2007-07-26 at 16:42 +0800, Zhang Wei wrote:
> These patches are the version 3 patches for RapidIO with dts update and some minor fixups.
> 
> These patches are used for supporting RapidIO controllers of Freescale. I ported them from ppc architecture to powerpc architecture and added some new features, such as memory mapped driver.
> 
> [PATCH 1/5] Add the explanation and sample of RapidIO DTS OF-node to the document of booting-without-of.txt file.
> [PATCH 2/5] Add RapidIO OF-node to MPC8641HPCN board dts file.
> [PATCH 3/5] Add the platform device support with RapidIO to MPC8641HPCN platform.
> [PATCH 4/5] Add RapidIO support to powerpc architecture.
> [PATCH 5/5] Add the memory management driver to RapidIO.
> 
> Please see below descriptions of these patches:
> 1. Add the RapidIO driver of-device support.
> 2. Add the RapidIO driver support to MPC8641HPCN board.
> 3. Port the RapidIO from ppc to powerpc architecture.
> 4. Add Memory mapped RapidIO driver.
> 5. Add the support to multi master ports.
> 6. Add a simple bitmap RapidIO space allocator driver.
> 7. Change the RapidIO system size of menuconfig to automatically detection.
> 
> Thanks!
> 
> Best Regards,
> Zhang Wei
> 
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
> 
