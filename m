Message-ID: <40FFAB78.1000705@freenet.de>
Date: Thu, 22 Jul 2004 13:56:40 +0200
From: Markus Bernauer <markus.bernauer@freenet.de>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Booting Ebony-evb with u-boot and linux-devel-sourcetree from Denx
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I am trying to boot my Ebony-evb with u-boot and a kernel image generated
from devel-sourcetree from Denx. It seems to me like the kernel image simply
ignores the parameters handed over by u-boot. I also found some earlier
threads
that  support my thoughts. Unfortunately I am bound to u-boot and I am
not able
to switch back to the native bootloader that comes with the evb. Has anyone
already a system up and running booted by u-boot? At first it does not
matter whether
the root filesystem comes from flash or over nfs. Any hints would be
appreciated.

Thanks in advance

Markus


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
