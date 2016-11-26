Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tR6Rz5BvWzDvs0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Nov 2016 09:04:47 +1100 (AEDT)
Date: Sun, 27 Nov 2016 09:04:30 +1100
From: Anton Blanchard <anton@samba.org>
To: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Nicholas
 Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Kernel build issues with upstream binutils
Message-ID: <20161127090430.5039d436@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

A recent binutils commit:

https://sourceware.org/git/?p=binutils-gdb.git;a=commitdiff;h=1a9ccd70f9a75dc6b48d340059f28ef3550c107b

has broken kernel builds:

/home/anton/gcc.install/bin/ld: arch/powerpc/boot/zImage.pseries: Not enough room for program headers, try linking with -N
/home/anton/gcc.install/bin/ld: final link failed: Bad value

I guess we have an issue with our linker script.

Anton
