Message-ID: <3D940B2C.3060105@motorola.com>
Date: Fri, 27 Sep 2002 08:39:24 +0100
From: John Traill <john.traill@motorola.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: bi_record location Error ?
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The _ALIGN macro is defined as follows :-

#define _ALIGN(addr,size)        (((addr)+size-1)&(~(size-1)))

However all uses of the ALIGN macro for bi_record location already add the size eg.

rec = (struct bi_record *)_ALIGN((ulong)__bss_start+(1<<20)-1,(1<<20));

The use of _ALIGN for the bi_records is consistent but is there a reason for the double size offset or is it a simple typo ?

--

Regards, John


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
