Return-Path: <happyphot@gmail.com>
Received: from pproxy.gmail.com (pproxy.gmail.com [64.233.166.183])
	by ozlabs.org (Postfix) with ESMTP id CB08E67B31
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Apr 2006 17:08:36 +1000 (EST)
Received: by pproxy.gmail.com with SMTP id e30so772088pya
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Apr 2006 00:08:34 -0700 (PDT)
Message-ID: <026801c661ed$bcb352d0$0760120a@photon>
From: "HappyPhot" <happyphot@gmail.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: about ppc <asm/string.h>
Date: Mon, 17 Apr 2006 15:08:08 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

  Under linux kernel, the file /include/linux/string.h will include 
<asm/string.h>.
  But I didn't found "string.h" under "asm-ppc", my asm is link to asm-ppc
(CPU is ppc). This makes me compile some code failed.
  (kernel version 2.6.x)

  Anybody knows about this ? Why there is no string.h under "asm-ppc" 
directory.

thanks a lot,
/Phot

 
