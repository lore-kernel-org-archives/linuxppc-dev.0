Return-Path: <linux@rainbow-software.org>
Received: from smtp-1b.atlantis.sk (smtp-1b.atlantis.sk [80.94.52.26])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sCjrR52dLzDr3S
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Aug 2016 03:57:43 +1000 (AEST)
From: Ondrej Zary <linux@rainbow-software.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [ANN] oldworld-deb: Debian Installer boot floppy for OldWorld
 PowerMacs
Date: Mon, 15 Aug 2016 19:49:31 +0200
Cc: Kernel development list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201608151949.31672.linux@rainbow-software.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,
I've just released oldworld-deb - a boot floppy that can boot Debian Installer 
from the CD on OldWorld PowerMacs, such as Power Macintosh 8200.

It's based on miBoot, Linux kernel, kexec-tools, uClibc and a simple init 
program written in C.

You can get the source and also a pre-built image here:
https://github.com/ondrej-zary/oldworld-deb

-- 
Ondrej Zary
