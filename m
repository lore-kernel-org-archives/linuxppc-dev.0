To: Troy Benjegerdes <hozer@drgw.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Broken asm/div64.h macro
References: <20020126103720.Z14725@altus.drgw.net>
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <20020126103720.Z14725@altus.drgw.net>
Date: 27 Jan 2002 00:51:42 +0200
Message-ID: <87sn8sybcx.fsf@fadata.bg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "Troy" == Troy Benjegerdes <hozer@drgw.net> writes:

Troy> Our div64.h macro is quite broken, and causes printk to not be able to do
Troy> a long long format.

Troy> Is there a 'fast' generic C algorithm we can replace it with, instead of
Troy> mucking with ASM?

Hmm, I sent a patchlet to lkml with Subject: [PATCH] 64-bit divide tweaks.

Doesn't it work for you ?

Regards,
-velco

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
