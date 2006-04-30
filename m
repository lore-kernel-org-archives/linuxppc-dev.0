Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 5546167B23
	for <linuxppc-dev@ozlabs.org>; Mon,  1 May 2006 01:07:50 +1000 (EST)
Date: Sun, 30 Apr 2006 10:07:03 -0500
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: please pull powerpc.git 'merge' branch
Message-ID: <20060430150702.GS5518@pb15.lixom.net>
References: <17491.1134.565353.149941@cargo.ozlabs.ibm.com>
	<20060430042059.GO5518@pb15.lixom.net>
	<200604301342.02043.arnd@arndb.de>
	<200604301357.21578.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <200604301357.21578.arnd@arndb.de>
From: Olof Johansson <olof@lixom.net>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, torvalds@osdl.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Apr 30, 2006 at 01:57:21PM +0200, Arnd Bergmann wrote:

> • Mediated interrupt
> • Multiple concurrent large pages
> • Add TL (TLB load control) bit to logical-partitioning control register
>  (LPCR) for software versus hardware load of TLB
> • Change tlbie<l> of large page to always invalidate ERAT
> • Hypervisor SPRs no longer readable when HV equals 0
> 
> Do we know which ones of these made it into 2.05?

I'm not sure that can be discussed on a public mailing list, given that
2.02 is the last non-secret architecture version at this time. :-)


-Olof
