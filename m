To: iweiny@pacbell.net
Cc: linuxppc-dev@lists.linuxppc.org (linuxdev)
Subject: Re: User level Macros for Endianess
References: <200001120832.AAA10014@batcave2.localdomain>
From: Jesper Skov <jskov@cygnus.co.uk>
Date: 12 Jan 2000 10:11:03 +0100
In-Reply-To: iweiny@pacbell.net's message of "Wed, 12 Jan 2000 00:32:11 -0800 (PST)"
Message-ID: <othfgj64ew.fsf@thinktwice.zoftcorp.dk>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "iweiny" == iweiny  <iweiny@pacbell.net> writes:

iweiny> What Macros should I be using to key off of for this?  I have
iweiny> looked through /usr/include/endian.h and
iweiny> /usr/include/bits/endian.h.  BYTE_ORDER (without the leading
iweiny> underscores) is only defined if __USE_BSD is defined.  BOTH
iweiny> __BIG_ENDIAN and __LITTLE_ENDIAN are defined as are BIG_ENDIAN
iweiny> and LITTLE_ENDIAN.  I'm so confused?

#include <asm/byteorder.h>

then use __le32_to_cpu and friends (see
/usr/include/linux/byteorder/generic.h)

I'm not sure if that's the Proper Way(TM) to do it from user land
though.

Jesper

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
