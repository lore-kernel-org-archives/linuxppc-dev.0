Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcG7Y5XydzDqXp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 02:23:05 +1000 (AEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
 linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: 32-bit powerpc, aty128fb: vmap allocation for size 135168 failed
References: <alpine.LRH.2.20.1708180825590.15982@math.ut.ee>
Date: Tue, 22 Aug 2017 18:17:07 +0200
In-Reply-To: <alpine.LRH.2.20.1708180825590.15982@math.ut.ee> (Meelis Roos's
 message of "Fri, 18 Aug 2017 08:37:46 +0300 (EEST)")
Message-ID: <87378ja870.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Aug 18 2017, Meelis Roos <mroos@linux.ee> wrote:

> Aug 17 23:53:57 pohl kernel: [ 2940.146546] aty128fb 0000:00:10.0: Invalid PCI ROM header signature: expecting 0xaa55, got 0x1111
> Aug 17 23:54:02 pohl kernel: [ 2944.804838] aty128fb 0000:00:10.0: Invalid PCI ROM header signature: expecting 0xaa55, got 0x1110

I think these messages are harmless and expected.  This device has no
x86 option ROM but a OpenFirmware one.  This is likely unrelated to the
sddm crash.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
