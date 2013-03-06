Return-Path: <lists@nerdbynature.de>
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
 by ozlabs.org (Postfix) with ESMTP id A9F5F2C03AE
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2013 17:42:40 +1100 (EST)
Date: Tue, 5 Mar 2013 22:42:35 -0800 (PST)
From: Christian Kujau <lists@nerdbynature.de>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] ppc32: Fix compile of sha1-powerpc-asm.S
In-Reply-To: <20130306040950.GC3493@concordia>
Message-ID: <alpine.DEB.2.10.1303052241050.22410@trent.utfs.org>
References: <1361845205-30606-1-git-send-email-tony@bakeyournoodle.com>
 <alpine.DEB.2.10.1303041656010.22410@trent.utfs.org>
 <20130306040950.GC3493@concordia>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 6 Mar 2013 at 15:09, Michael Ellerman wrote:
> Thanks Christian. What hardware are you on?

This is a PowerBook G4, 32bit, uni-processor. Full dmesg, e.g.:

  http://nerdbynature.de/bits/3.9.0-rc1/dmesg.txt

C.
-- 
BOFH excuse #88:

Boss' kid fucked up the machine
