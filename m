MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16184.17299.359649.663018@cargo.ozlabs.ibm.com>
Date: Tue, 12 Aug 2003 11:32:03 +1000
From: Paul Mackerras <paulus@samba.org>
To: Rabeeh Khoury <rabeeh@il.marvell.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: dcbst instruction
In-Reply-To: <3F37B4F1.2040702@il.marvell.com>
References: <3F37B4F1.2040702@il.marvell.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Rabeeh Khoury writes:

> I have a question about the PowerPC cache line clean dcbst instruction.
> Is this instruction used at all in Linux ?
> If used, where ? kernel ? libc ? special builds of user space applications ?

It's used in the kernel and in every program that uses shared
libraries.  I would expect that applications such as Java JIT
compilers would use it too.

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
