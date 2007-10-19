Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B557DDDEE0
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 01:39:57 +1000 (EST)
From: Yuri Tikhonov <yur@emcraft.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] ppc44x: support for 256K PAGE_SIZE
Date: Fri, 19 Oct 2007 19:37:23 +0400
References: <200710181108.19413.yur@emcraft.com>
	<18199.60025.563689.10810@cargo.ozlabs.ibm.com>
In-Reply-To: <18199.60025.563689.10810@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710191937.23638.yur@emcraft.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 19 October 2007 03:21, Paul Mackerras wrote:
> Have you measured the performance using a 64kB page size?  If so, how
> does it compare with the 256kB page size?

 I measured the performance of the sequential full-stripe write operations to
a RAID-5 array (P values below are in MB per second) using the h/w accelerated
RAID-5 driver.

 Here are the comparative results for the different PAGE_SIZE values:

PAGE_SIZE = 4K:
 P = 66 MBps;

PAGE_SIZE = 16K:
 P = 145 MBps;

PAGE_SIZE = 64K:
 P = 196 MBps;

PAGE_SIZE = 256K:
 P = 217 MBps.

> The 64kB page size has the attraction that no binutils changes are
> required.

 That's true, but the additional performance is an attractive thing too.

> 
> Paul.
> 

-- 
Yuri Tikhonov, Senior Software Engineer
Emcraft Systems, www.emcraft.com
