Message-ID: <75DF04AC5ED4D511A9810090273CB4163F5DE2@rokonet-e.rokonet.co.il>
From: Eli Brin <elib@rokonet.co.il>
To: "'Wolfgang Denk'" <wd@denx.de>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Access u-boot environment variables from Linux 
Date: Mon, 14 Jul 2003 12:18:17 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Wolfgang,

>With "burn ... the TQ860L ... at 0x3ff00" you  mean  the  TQ-specific
>Hardware   Information   Block  which  can  be  installed  at  offset
>0x0003FFC0 in the first flash bank?

Yes, but our final target will use 0x0003FF00, so we can have more
space. We are making our target as compatible as possible to the
TQM860L.

>This stuff has been obsoleted by  the  solution  in  tools/env  which
>allows for easy configuration to different boards / setups.

Yes. I didn't know of it. It was absent in ppc-boot, and _reading_ the
change log from version to version may solve this...

>Yes, but it makes little sense to always recompile everything from
>scratch when the same tools are ready available as binaries in the ELDK.

Perhaps, and probably, you are right. I will re-check/re-think. It looks
easier to make changes on the SELF scripts. And it can be used on Linux
version that do not support the ELDK rebuild from scratch.

Anyway, my original problem is solved :) . I use the /tools/env, and
perhaps later the MTD patch.

Thanks,
Eli Brin

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
