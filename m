Message-ID: <3FB02C85.6090400@g-house.de>
Date: Tue, 11 Nov 2003 01:25:41 +0100
From: Christian <evil@g-house.de>
MIME-Version: 1.0
To: linas@austin.ibm.com
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ppc32 lockups with 2.6
References: <3FA5698A.9000905@g-house.de> <3FAABE62.4090804@g-house.de> <20031110125044.A22030@forte.austin.ibm.com> <3FB01392.60500@g-house.de> <20031110175740.A32176@forte.austin.ibm.com>
In-Reply-To: <20031110175740.A32176@forte.austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


linas@austin.ibm.com wrote:
>
> kdb is a built-in kernel debugger. gdb is useless for this case,
> although kgdb could be another alternative.

yes, i thought so. i'm still a bit confused if "kdb" and "kgdb".

as http://kgdb.sourceforge.net/whichdebugger.html points out, kdb would
be the better choice here, but i don't see any "kdb" within the kernel
config nor does it seem to be a user space-tool. anyway, i have

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_SLAB=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_KGDB=y
CONFIG_KGDB_TTYS1=y
CONFIG_XMON=y
CONFIG_DEBUG_INFO=y
CONFIG_BOOTX_TEXT=y

in my kernel now (still compiling), and will try to setup kgdb tomorrow
(read: today :-))

Thank you for your time,
Christian.
--
BOFH excuse #410:

Electrical conduits in machine room are melting.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
