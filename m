Return-Path: <rdreier@cisco.com>
Received: from sj-iport-1.cisco.com (sj-iport-1.cisco.com [171.71.176.70])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-1.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id C5A0DDE187
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Aug 2008 00:48:04 +1000 (EST)
From: Roland Dreier <rdreier@cisco.com>
To: paul@mad-scientist.us
Subject: Re: 2.6.25: include/asm-ppc vs. include/asm-powerpc
References: <1219928864.16802.69.camel@homebase.localnet>
	<200808281553.18167.arnd@arndb.de>
	<1219933848.16802.96.camel@homebase.localnet>
Date: Thu, 28 Aug 2008 07:48:00 -0700
In-Reply-To: <1219933848.16802.96.camel@homebase.localnet> (Paul Smith's
	message of "Thu, 28 Aug 2008 10:30:48 -0400")
Message-ID: <adaej49jivz.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

 > It doesn't matter whether I build my code in the kernel as patches, or
 > not.  The problem is not that I don't have the headers handy, it's that
 > they simply don't exist in asm-ppc anymore, not even in the linux source
 > tree.

I believe that the kernel's build system (before arch/ppc was removed
entirely) had some magic to include files from asm-powerpc if they
didn't exist in asm-ppc.  So building your code with the kernel's build
system (and Documentation/kbuild/modules.txt explains how to do that
even without building in the kernel tree itself) should work.

For example, the reason include/asm-ppc/ppc_asm.h doesn't exist is
because of commit 5f7c6907, which moved the file to asm-powerpc.

 - R.
