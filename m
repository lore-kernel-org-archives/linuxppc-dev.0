Message-ID: <39107AB8.75A94A6E@embeddededge.com>
Date: Wed, 03 May 2000 15:15:04 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: diekema_jon <diekema@bucks.si.com>
CC: linuxppc-embedded@lists.linuxppc.org, beatson_mark@bucks.si.com
Subject: Re: Need CPM clock >= 100 Mhz for fast ethernet operation
References: <m12n2oz-001SyZC@bucks>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


diekema_jon wrote:

> diff -u -r1.1 arch/ppc/mbxboot/embed_config.c

>          * here for those people that may load the kernel with
>          * a JTAG/COP tool and not the rom monitor.
>          */

Yeah, well, like the comment says, these are here for you to use
when you don't initialize them in any other way.  I'm not going to
update the kernel sources because they will be different for everyone.
I just stuffed some numbers for testing, change them to suit your
needs.

You should have a boot rom, some NVRAM or I guess we could derive
these numbers from the configuration registers when we know the
external clock speed.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
