Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <40924DBE.2010908@ntlworld.com>
Date: Fri, 30 Apr 2004 13:59:42 +0100
From: Richard Danter <richard.danter@ntlworld.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: bd_t definition changes
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,

I am trying to boot linux 2.4.24 (from ELDK 3.0) on an EST SBC8260 using
U-Boot 1.1.1 which I downloaded from the Denx ftp site.

U-Boot seems to be working just fine. I can tftpboot the uImage and
start executing the kernel using bootm. But...

I have discovered that the bd_t (board info) being seen by the kernel
does not match what it expects. Looking closer at the source, I can see
that the definition of this structure differs between that in the kernel
(arch/ppc/platforms/est8260.h) and U-Boot (include/asm-ppc/u-boot.h).

Should I fix the kernel version and submit it as a patch, or will that
break other things?? Recommendations welcome!

Thanks
Rich


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
