Message-ID: <3F37B7BB.1040206@mvista.com>
Date: Mon, 11 Aug 2003 10:35:23 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Rabeeh Khoury <rabeeh@il.marvell.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: dcbst instruction
References: <3F37B4F1.2040702@il.marvell.com>
In-Reply-To: <3F37B4F1.2040702@il.marvell.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Rabeeh Khoury wrote:
>
> Hi All,
>
> I have a question about the PowerPC cache line clean dcbst instruction.
> Is this instruction used at all in Linux ?
> If used, where ? kernel ? libc ? special builds of user space
> applications ?

It is used in glibc.  I have not seen off the shelf applications using
it, but I wouldn't be surprised if highly optimized apps did attempt to
use it.

As for the kernel, I would assume it's being used.. but a simple grep
should tell you if it is.

--Mark

> Thanks,
> Rabeeh
>
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
