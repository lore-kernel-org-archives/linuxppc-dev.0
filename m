From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linas@austin.ibm.com
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20030912120037.A26892@forte.austin.ibm.com>
References: <20030911112823.A27066@forte.austin.ibm.com>
	 <20030912120037.A26892@forte.austin.ibm.com>
Message-Id: <1063477133.9720.23.camel@gaston>
Mime-Version: 1.0
Date: Sat, 13 Sep 2003 20:18:53 +0200
Subject: Re: [PATCH] ppc64 kernel 2.6 ide-related patches (revised)
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2003-09-12 at 19:00, linas@austin.ibm.com wrote:

> -- the current code does *not* auto-negotiate itself up into the
>    highest possible performance mode.  (i.e. 32 bit transfers, dma on,
>    etc.)  This appears to be due to the fact that this task is normally
>    done by i386 BIOS, and the ppc open firmware doesn't do anything
>    analogous, and there's nothing in the kernel (that I know of) to
>    make up for this.

This is done in the kernel by the host chipset driver normally. It works
fine on pmac with ppc32 at least ;)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
