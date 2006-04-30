Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id B5AFF67A01
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Apr 2006 21:57:34 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: please pull powerpc.git 'merge' branch
Date: Sun, 30 Apr 2006 13:57:21 +0200
References: <17491.1134.565353.149941@cargo.ozlabs.ibm.com>
	<20060430042059.GO5518@pb15.lixom.net>
	<200604301342.02043.arnd@arndb.de>
In-Reply-To: <200604301342.02043.arnd@arndb.de>
MIME-Version: 1.0
Message-Id: <200604301357.21578.arnd@arndb.de>
Content-Type: text/plain;
  charset="utf-8"
Cc: Olof Johansson <olof@lixom.net>, torvalds@osdl.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 30 April 2006 13:42, Arnd Bergmann wrote:
> The Cell Broadband Engine Architecture in theory is 2.03 and also mandates
> some of the extensions that are optional in there.

Oh, and it also has some extensions that are supposed to be part of later
powerpc architecture releases (CBEA, appendix E):

• Mediated interrupt
• Multiple concurrent large pages
• Add TL (TLB load control) bit to logical-partitioning control register
 (LPCR) for software versus hardware load of TLB
• Change tlbie<l> of large page to always invalidate ERAT
• Hypervisor SPRs no longer readable when HV equals 0

Do we know which ones of these made it into 2.05?

	Arnd <><
