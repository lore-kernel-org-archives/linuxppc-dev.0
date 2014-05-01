Return-Path: <groeck7@gmail.com>
Received: from mail-pd0-f178.google.com (mail-pd0-f178.google.com
 [209.85.192.178])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6E3FD14011B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 May 2014 02:17:55 +1000 (EST)
Received: by mail-pd0-f178.google.com with SMTP id fp1so3353989pdb.37
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 May 2014 09:17:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 1 May 2014 09:17:46 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: powerpc:allmodconfig build failure (since 3.14)
Message-ID: <20140501161746.GA7375@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

the powerpc:allmodconfig build has been broken since 3.14
with the following error.

arch/powerpc/kernel/exceptions-64s.S: Assembler messages:
arch/powerpc/kernel/exceptions-64s.S:1315: Error: attempt to move .org backwards
make[1]: *** [arch/powerpc/kernel/head_64.o] Error 1

Any chance to get this fixed, or is it time to drop powerpc:allmodconfig
from my test builds ?

I would give it a shot myself, but that file is one that I would prefer
not to touch.

Thanks,
Guenter
